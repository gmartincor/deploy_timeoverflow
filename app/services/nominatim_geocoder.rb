# app/services/nominatim_geocoder.rb
require 'net/http'
require 'json'

class NominatimGeocoder
  CACHE_EXPIRY = 30.days

  # Mutex for rate limiting
  @geocoding_mutex = Mutex.new
  @last_request_time = Time.now - 2.seconds

  def self.geocode(address)
    return nil if address.blank?

    # Check cache first
    cache_key = "geocode_#{address.parameterize}"
    cached = Rails.cache.read(cache_key)
    return cached if cached.present?

    # Make API request if not in cache
    uri = URI("https://nominatim.openstreetmap.org/search")
    params = {
      q: address,
      format: 'json',
      limit: 1,
      addressdetails: 1
    }
    uri.query = URI.encode_www_form(params)

    # Add a user agent as required by Nominatim's usage policy
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "TimeOverflow/1.0"
    request["Accept-Language"] = I18n.locale.to_s

    begin
      response = throttled_request(uri, request)

      if response.is_a?(Net::HTTPSuccess)
        result = JSON.parse(response.body).first

        if result
          coordinates = {
            latitude: result["lat"].to_f,
            longitude: result["lon"].to_f
          }

          # Cache the result
          Rails.cache.write(cache_key, coordinates, expires_in: CACHE_EXPIRY)

          return coordinates
        end
      end

      # Return nil if request failed or no results
      nil
    rescue StandardError => e
      Rails.logger.error("Geocoding error: #{e.message}")
      nil
    end
  end

  def self.throttled_request(uri, request)
    @geocoding_mutex.synchronize do
      # Ensure at least 1.1 seconds between requests
      time_since_last_request = Time.now - @last_request_time
      if time_since_last_request < 1.1
        sleep(1.1 - time_since_last_request)
      end

      # Make the request
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end

      # Update last request time
      @last_request_time = Time.now

      response
    end
  end
end
