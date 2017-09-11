# frozen_string_literal: true

require "prep_locator/version"
require "rest_client"
require "geocoder"
require "json"

# Main module for retrieving prep locations.
module PrepLocator
  MAIN_ENDPOINT = "https://aidsvu.org/wp-admin/admin-ajax.php"

  def self.params(query)
    location = Geocoder.search(query).first
    { action: "av_ajax_get_locations",
      latitude: location.latitude,
      longitude: location.longitude,
      postal_code: location.postal_code,
      source: "prep" }
  end

  def self.locations(query)
    response = RestClient.post(MAIN_ENDPOINT, params(query))
    JSON.parse!(response)
  end
end
