module Maps
  module OrganizationAlliancesMapHelper
    def organization_map_data(options = {})
      limit = options[:limit] || 100

      # Ahora seleccionamos explícitamente latitude y longitude
      scope = Organization.select(:id, :name, :city, :address, :neighborhood, :latitude, :longitude)

      scope = scope.where(options[:scope]) if options[:scope].present?

      if options[:only_allied] && current_organization.present?
        allied_org_ids = current_organization.allied_organizations.pluck(:id)
        scope = scope.where(id: allied_org_ids + [current_organization.id])
      end

      # Podemos filtrar por organizaciones que ya tienen coordenadas
      if options[:only_geocoded]
        scope = scope.where.not(latitude: nil).where.not(longitude: nil)
      end

      orgs = scope.limit(limit)

      # Ahora no necesitamos hacer caché, directamente usamos los valores almacenados
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

    def preload_organization_geocoding(limit = 20)
      # Buscamos organizaciones que necesitan geocodificación
      organizations = Organization.where(latitude: nil).or(Organization.where(longitude: nil))
                              .limit(limit)
                              .select(:id, :name, :city, :address, :neighborhood)

      # Creamos un hilo en segundo plano
      Thread.new do
        organizations.each do |org|
          begin
            org.geocode_address if org.needs_geocoding?

            # Pausa para no sobrecargar Nominatim
            sleep(1.2)
          rescue StandardError => e
            Rails.logger.error("Error geocoding #{org.name}: #{e.message}")
          end
        end
      rescue StandardError => e
        Rails.logger.error("Preload geocoding error: #{e.message}")
      ensure
        # Liberar la conexión
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
  end
end
