require 'net/http'
require 'json'

class NominatimGeocoder
  @geocoding_mutex = Mutex.new
  @last_request_time = Time.now - 2.seconds

  def self.geocode(address)
    return nil if address.blank?

    uri = URI("https://nominatim.openstreetmap.org/search")
    params = {
      q: address,
      format: 'json',
      limit: 1,
      addressdetails: 1
    }
    uri.query = URI.encode_www_form(params)

    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "TimeOverflow/1.0"
    request["Accept-Language"] = I18n.locale.to_s

    begin
      response = throttled_request(uri, request)

      if response.is_a?(Net::HTTPSuccess)
        result = JSON.parse(response.body).first

        if result
          return {
            latitude: result["lat"].to_f,
            longitude: result["lon"].to_f
          }
        end
      end

      nil
    rescue StandardError => e
      Rails.logger.error("Geocoding error: #{e.message}")
      nil
    end
  end

  def self.throttled_request(uri, request)
    @geocoding_mutex.synchronize do
      time_since_last_request = Time.now - @last_request_time
      if time_since_last_request < 1.1
        sleep(1.1 - time_since_last_request)
      end

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end

      @last_request_time = Time.now

      response
    end
  end
end
