namespace :geocode do
  desc "Precarga las coordenadas de todas las organizaciones"
  task preload: :environment do
    puts "Preloading coordinates for all organizations..."

    organizations = Organization.where(latitude: nil).or(Organization.where(longitude: nil))
    total = organizations.count

    puts "Found #{total} organizations without coordinates"

    organizations.each_with_index do |org, index|
      next if org.full_address.blank?

      puts "Processing #{index + 1}/#{total}: #{org.name}"

      coords = NominatimGeocoder.geocode(org.full_address)

      if coords.present?
        org.update_columns(
          latitude: coords[:latitude],
          longitude: coords[:longitude],
          geocoded_at: Time.current
        )
        puts "  ✓ Coordinates saved: #{coords[:latitude]}, #{coords[:longitude]}"
      else
        puts "  ✗ Could not geocode address: #{org.full_address}"
      end

      # Pausa para no sobrecargar la API de Nominatim
      sleep(1.2)
    end

    puts "Finished preloading coordinates"
  end
end
