class StatisticsController < ApplicationController
  before_action :authenticate_user!

  def global_activity
    members = current_organization.members
    @active_members = members.active

    @total_hours = num_movements = 0
    members.each do |m|
      num_movements += m.account.movements.count
      @total_hours += m.account.movements.map do
        |a| (a.amount > 0) ? a.amount : 0
      end.inject(0, :+)
    end
    @total_hours += current_organization.account.movements.
                    map { |a| (a.amount > 0) ? a.amount : 0 }.inject(0, :+)

    @num_swaps = (num_movements + current_organization.account.movements.count) / 2

    from = params[:from].presence.try(:to_date) || DateTime.now.to_date - 5.month
    to = params[:to].presence.try(:to_date) || DateTime.now.to_date
    num_months = (to.year * 12 + to.month) - (from.year * 12 + from.month) + 1
    date = from

    @months_names = []
    @user_reg_months = []
    @num_swaps_months = []
    @hours_swaps_months = []

    num_months.times do
      @months_names << l(date, format: "%B %Y")
      @user_reg_months << members.by_month(date).count

      swaps_members = members.map { |a| a.account.movements.by_month(date) }
      swaps_organization = current_organization.account.movements.by_month(date)
      sum_swaps = (swaps_members.flatten.count + swaps_organization.count) / 2
      @num_swaps_months << sum_swaps

      sum_hours = 0
      swaps_members.flatten.each do |s|
        sum_hours += (s.amount > 0) ? s.amount : 0
      end
      sum_hours += swaps_organization.map do
        |a| (a.amount > 0) ? a.amount : 0
      end.inject(0, :+)
      sum_hours = sum_hours / 3600.0 if sum_hours > 0
      @hours_swaps_months << sum_hours

      date = date.next_month
    end
  end

  def inactive_users
    @members = current_organization.members.active
  end

  def demographics
    members = current_organization.members
    @age_counts = age_counts(members)
    @gender_counts = gender_counts(members)
  end

  def last_login
    @members = current_organization.members.active.joins(:user).
               order("users.current_sign_in_at ASC NULLS FIRST")
  end

  def without_offers
    @members = current_organization.members.active
  end

  def type_swaps
    offers = current_organization.posts.
             where(type: "Offer").joins(:transfers, transfers: :movements).
             select("posts.tags, posts.category_id, SUM(movements.amount) as
                     sum_of_transfers, COUNT(transfers.id) as
                     count_of_transfers").
             where("movements.amount > 0").
             group("posts.tags, posts.category_id, posts.updated_at")

    @offers = count_offers_by_label(offers).to_a.each { |a| a.flatten!(1) }.
              sort_by(&:last).reverse
  end

  def all_transfers
    @transfers = current_organization.
                 all_transfers_with_accounts.
                 page(params[:page]).
                 per(20)
  end

  def alliance_transfers
    unless current_user.manages?(current_organization)
      redirect_to root_path, alert: t("organization_alliances.not_authorized")
      return
    end

    @allied_organizations = current_organization.allied_organizations

    if @allied_organizations.empty?
      @no_alliances = true
      return
    end

    if params[:target_organization_id].present?
      @target_organization = Organization.find_by(id: params[:target_organization_id])
      @allied_organizations = @allied_organizations.where(id: params[:target_organization_id]) if @target_organization
    end

    from_date = params[:from].presence.try(:to_date) || DateTime.now.to_date - 3.month
    to_date = params[:to].presence.try(:to_date) || DateTime.now.to_date

    @transfers_summary = {}
    @balance_by_org = {}
    @transfers_by_month = {}

    @allied_organizations.each do |org|
      alliance = current_organization.alliance_with(org)
      next unless alliance&.accepted?

      outgoing_movements = Movement.where(account_id: current_organization.account.id)
                                 .where("amount < 0")
                                 .where(created_at: from_date.beginning_of_day..to_date.end_of_day)
                                 .joins(:transfer)
                                 .select { |m| m.transfer.movements.any? { |other_m| other_m.account_id == org.account.id } }

      incoming_movements = Movement.where(account_id: current_organization.account.id)
                                 .where("amount > 0")
                                 .where(created_at: from_date.beginning_of_day..to_date.end_of_day)
                                 .joins(:transfer)
                                 .select { |m| m.transfer.movements.any? { |other_m| other_m.account_id == org.account.id } }

      outgoing_transfers = outgoing_movements.map(&:transfer).uniq
      incoming_transfers = incoming_movements.map(&:transfer).uniq

      outgoing_total_seconds = outgoing_movements.sum(&:amount).abs
      incoming_total_seconds = incoming_movements.sum(&:amount)

      @transfers_summary[org.id] = {
        name: org.name,
        outgoing_count: outgoing_transfers.size,
        incoming_count: incoming_transfers.size,
        outgoing_hours: (outgoing_total_seconds / 3600.0).round(2),
        incoming_hours: (incoming_total_seconds / 3600.0).round(2),
        total_transfers: outgoing_transfers.size + incoming_transfers.size
      }

      @balance_by_org[org.id] = {
        name: org.name,
        balance: (incoming_total_seconds - outgoing_total_seconds) / 3600.0
      }

      months_data = {}
      month_range = (from_date.to_date..to_date.to_date).map { |d| Date.new(d.year, d.month, 1) }.uniq

      month_range.each do |month|
        month_start = month.beginning_of_month
        month_end = month.end_of_month

        month_outgoing_movements = outgoing_movements.select { |m| m.created_at.between?(month_start, month_end) }
        month_incoming_movements = incoming_movements.select { |m| m.created_at.between?(month_start, month_end) }

        outgoing_seconds = month_outgoing_movements.sum(&:amount).abs
        incoming_seconds = month_incoming_movements.sum(&:amount)

        month_name = I18n.l(month, format: "%B %Y")
        months_data[month_name] = {
          outgoing: (outgoing_seconds / 3600.0).round(2),
          incoming: (incoming_seconds / 3600.0).round(2),
          balance: ((incoming_seconds - outgoing_seconds) / 3600.0).round(2)
        }
      end

      @transfers_by_month[org.id] = {
        name: org.name,
        months: months_data
      }
    end
  end

  protected

  def count_offers_by_label(offers)
    # Cannot use Hash.new([0, 0]) because then counters[key][0] += n
    # will modify directly the "global default" instead of
    # first assigning a new array with the zeroed counters.
    counters = Hash.new { |h, k| h[k] = [0, 0] }

    offers.each do |offer|
      labels_for_offer(offer).each do |labels|
        counters[labels][0] += offer.sum_of_transfers
        counters[labels][1] += offer.count_of_transfers
      end
    end
    add_ratios(counters)

    counters
  end

  def add_ratios(counters)
    total_count = counters.values.map { |_, counts| counts }.sum

    counters.each do |_, v|
      v << v[1].to_f / total_count
    end
  end

  def labels_for_offer(offer)
    tag_labels = offer.tags.presence ||
                 [t("statistics.type_swaps.without_tags")]

    category_label = offer.category.try(:name) ||
                     t("statistics.type_swaps.without_category")

    [category_label].product(tag_labels)
  end

  def age_counts(members)
    members.each_with_object(Hash.new(0)) do |member, counts|
      age = compute_age(member.user_date_of_birth)

      age_label = age_group_labels.detect do |range, _|
        range.include? age
      end.try(:last) || t("statistics.demographics.unknown")

      counts[age_label] += 1
    end
  end

  def compute_age(date_of_birth)
    return unless date_of_birth

    age_in_days = Date.today - date_of_birth
    (age_in_days / 365.26).to_i
  end

  def age_group_labels
    {
      0..17   => "-17",
      18..24  => "18-24",
      25..34  => "25-34",
      35..44  => "35-44",
      45..54  => "45-54",
      55..64  => "55-64",
      65..100 => "65+"
    }
  end

  def gender_counts(members)
    members.each_with_object(Hash.new(0)) do |member, counts|
      gender = member.user_gender
      gender_label = if gender.present?
        t("simple_form.options.user.gender.#{gender}")
      else
        t("statistics.demographics.unknown")
      end
      counts[gender_label] += 1
    end
  end
end
