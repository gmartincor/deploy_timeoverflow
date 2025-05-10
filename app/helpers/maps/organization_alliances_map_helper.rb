module Maps
  module OrganizationAlliancesMapHelper
    def organization_map_data(options = {})
      limit = options[:limit] || 100

      scope = Organization.select(:id, :name, :city, :address, :neighborhood)

      scope = scope.where(options[:scope]) if options[:scope].present?

      if options[:only_allied] && current_organization.present?
        allied_org_ids = current_organization.allied_organizations.pluck(:id)
        scope = scope.where(id: allied_org_ids + [current_organization.id])
      end

      orgs = scope.limit(limit)

      orgs.map do |org|
        {
          id: org.id,
          name: org.name,
          city: org.city,
          address: org.full_address,
          latitude: org.latitude,
          longitude: org.longitude,
          is_current: org.id == current_organization&.id
        }
      end
    end

    def alliance_map_data(organization = nil)
      org = organization || current_organization
      return [] unless org

      alliances = case @status
                 when "pending"
                   org.pending_sent_alliances + org.pending_received_alliances
                 when "accepted"
                   org.accepted_alliances
                 when "rejected"
                   org.rejected_alliances
                 else
                   []
                 end

      alliances.map do |alliance|
        {
          source_id: alliance.source_organization_id,
          target_id: alliance.target_organization_id,
          status: alliance.status,
          created_at: alliance.created_at
        }
      end
    end

    def preload_organization_geocoding(limit = 50)
      organizations = Organization.limit(limit).select(:id, :name, :city, :address, :neighborhood)

      Thread.new do
        organizations.each do |org|
          org.coordinates
        rescue StandardError => e
          Rails.logger.error("Error geocoding #{org.name}: #{e.message}")
        end
      rescue StandardError => e
        Rails.logger.error("Preload geocoding error: #{e.message}")
      ensure
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
  end
end
