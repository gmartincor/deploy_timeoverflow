class OrganizationAlliance < ApplicationRecord
  belongs_to :source_organization, class_name: "Organization"
  belongs_to :target_organization, class_name: "Organization"

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :source_organization_id, presence: true
  validates :target_organization_id, presence: true
  validate :cannot_ally_with_self
  validate :custom_uniqueness_validation

  scope :pending, -> { where(status: "pending") }
  scope :accepted, -> { where(status: "accepted") }
  scope :rejected, -> { where(status: "rejected") }

  private

  def cannot_ally_with_self
    if source_organization_id == target_organization_id
      errors.add(:base, "Cannot create an alliance with yourself")
    end
  end

  def custom_uniqueness_validation
    return false unless source_organization_id.present? && target_organization_id.present?

    if OrganizationAlliance.exists?(source_organization_id: source_organization_id, target_organization_id: target_organization_id, status: 'pending') ||
       OrganizationAlliance.exists?(source_organization_id: target_organization_id, target_organization_id: source_organization_id, status: 'pending')
      errors.add(:base, I18n.t('organization_alliances.errors.pending_alliance_exists'))
    elsif OrganizationAlliance.exists?(source_organization_id: source_organization_id, target_organization_id: target_organization_id, status: 'accepted') ||
          OrganizationAlliance.exists?(source_organization_id: target_organization_id, target_organization_id: source_organization_id, status: 'accepted')
      errors.add(:base, I18n.t('organization_alliances.errors.active_alliance_exists'))
    elsif OrganizationAlliance.exists?(source_organization_id: source_organization_id, target_organization_id: target_organization_id) ||
          OrganizationAlliance.exists?(source_organization_id: target_organization_id, target_organization_id: source_organization_id)
      errors.add(:base, I18n.t('organization_alliances.errors.alliance_exists'))
    end

    # Verificar la unicidad básica si no se encontró ninguna condición específica
    if self.class.where(source_organization_id: source_organization_id, target_organization_id: target_organization_id).where.not(id: id).exists?
      return true
    end

    false
  end
end
