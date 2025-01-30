require 'geocoder/results/base'

module Geocoder::Result
  class AmazonLocationService < Base
    def initialize(result)
      @place = result.place
      super
    end

    def coordinates
      [@place.geometry.point[1], @place.geometry.point[0]]
    end

    def address
      @place.label
    end

    def neighborhood
      @place.neighborhood
    end

    def route
      @place.street
    end

    def city
      @place.municipality || @place.sub_region
    end

    def state
      @place.region
    end

    def state_code
      @place.region
    end

    def province
      @place.region
    end

    def province_code
      @place.region
    end

    def postal_code
      @place.postal_code
    end

    def country
      @place.country
    end

    def country_code
      @place.country
    end

    def place_id
      data.place_id if data.respond_to?(:place_id)
    end

    # Wefunder Fork Specific
    # Hacking and pushing this off
    # Amazon Location Service does not provide a proper street_address API, meaning this will likely break for non-us addresses
    # We should utilize Google instead, but I CBA to set that up rn bc I gotta fix termsets/purchases.
    # I'm trying to maintain the same API as the google service with street_number and street_address so we can migrate going forward.
    # However, this is not going to be upstreamed. I'll wait until someones shit gets fucked up and they find this commit.
    def street_number
      @place.address_number
    end

    def street_address
      [street_number, route].compact.join(" ")
    end
  end
end
