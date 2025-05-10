module Maps
  module OrganizationAlliancesMapHelper
    # Prepara datos de organizaciones para el mapa, con opciones de filtrado
    # @param options [Hash] opciones para personalizar los datos del mapa
    # @option options [Integer] :limit Limitar el número de organizaciones (por defecto: 100)
    # @option options [Hash] :scope Condiciones adicionales para filtrar organizaciones
    # @option options [Boolean] :only_allied Mostrar solo organizaciones aliadas
    # @return [Array<Hash>] Datos formateados de organizaciones para el mapa
    def organization_map_data(options = {})
      # Por defecto, limitar a un número razonable para evitar problemas de rendimiento
      limit = options[:limit] || 100

      # Base query con select optimizado
      scope = Organization.select(:id, :name, :city, :address, :neighborhood)

      # Aplicar filtros adicionales si se proporcionan
      scope = scope.where(options[:scope]) if options[:scope].present?

      # Si se solicita solo organizaciones aliadas
      if options[:only_allied] && current_organization.present?
        allied_org_ids = current_organization.allied_organizations.pluck(:id)
        scope = scope.where(id: allied_org_ids + [current_organization.id])
      end

      # Limitar resultados para evitar problemas de rendimiento
      orgs = scope.limit(limit)

      # Formatear datos para el mapa, filtrando los que no tienen coordenadas
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
      end.select { |org| org[:latitude].present? && org[:longitude].present? }
    end

    # Prepara datos de conexiones de alianzas para el mapa
    # @param organization [Organization] organización para la que obtener alianzas (por defecto: current_organization)
    # @return [Array<Hash>] Datos formateados de alianzas para el mapa
    def alliance_map_data(organization = nil)
      org = organization || current_organization
      return [] unless org

      # Obtener todas las alianzas aceptadas
      alliances = org.accepted_alliances

      # Formatear para el mapa
      alliances.map do |alliance|
        {
          source_id: alliance.source_organization_id,
          target_id: alliance.target_organization_id,
          status: alliance.status,
          created_at: alliance.created_at
        }
      end
    end

    # Método auxiliar para precargar coordenadas de organizaciones
    # @param limit [Integer] número máximo de organizaciones a geocodificar
    def preload_organization_geocoding(limit = 50)
      # Solo intentar geocodificar un número razonable de organizaciones
      organizations = Organization.limit(limit).select(:id, :name, :city, :address, :neighborhood)

      # Usar un hilo en segundo plano para iniciar la geocodificación
      Thread.new do
        organizations.each do |org|
          # Esto cacheará las coordenadas para usos futuros
          org.coordinates
        end
      rescue StandardError => e
        Rails.logger.error("Preload geocoding error: #{e.message}")
      ensure
        # Asegurarse de que el hilo termine y libere la conexión
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
  end
end
