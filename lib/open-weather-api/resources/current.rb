module OpenWeatherAPI
  module Resources
    class Current < Base    
      private
      
      def base_url
        return super + 'group'    if is_multiple_city_id?
        return super + 'weather'  if is_city? || is_city_id? || is_geolocation? || is_zipcode?
        return super + 'box/city' if is_bbox?
        return super + 'find'     if is_circle?
      end

      def build_params(parameters = {})
        super build_for_city || build_for_multiple || build_for_city_id || build_for_geolocation || build_for_zipcode || build_for_bbox || build_for_circle
      end

      # Basic city
      # ------------------
      
      # For city
      def is_city?
        city != nil
      end

      def city
        @parameters[:city]
      end

      def country_code
        @parameters[:country_code] || @api_obj.default_country_code
      end

      def build_for_city
        return { q: [city, country_code].compact.flatten.join(',') } if is_city?
      end

      # For city id
      def is_city_id?
        city_id != nil
      end
      
      def is_multiple_city_id?
        city_id.is_a? Array
      end
      
      def city_id
        @parameters[:id] || @parameters[:city_id]
      end

      def build_for_city_id
        return { id: city_id } if is_city_id?
      end

      def build_for_multiple
        return { id: city_id.compact.join(',') } if is_multiple_city_id?
      end
      
      # For geolocation
      def is_geolocation?
        geolocation[:lat] != nil && geolocation[:lon] != nil
      end

      def geolocation
        {
          lat: latitude,
          lon: longitude
        }
      end

      def latitude
        @parameters[:latitude] || @parameters[:lat]
      end

      def longitude
        @parameters[:longitude] || @parameters[:lon]
      end

      def build_for_geolocation
        return geolocation if is_geolocation?
      end

      # For zip code
      def is_zipcode?
        zipcode != nil
      end

      def zipcode
        @parameters[:zipcode] || @parameters[:zip]
      end

      def build_for_zipcode
        return { zip: [zipcode, country_code].compact.flatten.join(',') } if is_zipcode?
      end

      # Multiples cities
      # ------------------

      def cities_count
        @parameters[:count] || @parameters[:cnt] || @parameters[:cities_count]
      end

      def cluster
        @parameters[:cluster] if @parameters[:cluster].to_s == 'yes' || @parameters[:cluster].to_s == 'no'
      end

      # Bounding box
      def is_bbox?
        bbox != nil
      end

      def bbox_top
        [ bbox[:topleft][:lat], bbox[:topleft][:lon] ].join(',')
      end

      def bbox_bottom
        [ bbox[:bottomright][:lat], bbox[:bottomright][:lon] ].join(',')
      end

      def bbox_zoom
        bbox[:zoom] || bbox[:map_zoom] || 10
      end

      def bbox
        @parameters[:box] || @parameters[:box] || @parameters[:rect] || @parameters[:rectangle]
      end

      def build_for_bbox
        if is_bbox?
          hash = { bbox: [bbox_top, bbox_bottom, bbox_zoom].join(',') }
          hash[:cnt] = cities_count if cities_count
          hash[:cluster] = cluster if cluster

          hash
        end
      end

      # Circle
      def is_circle?
        circle != nil
      end

      def circle
        @parameters[:circle]
      end

      def build_for_circle
        if is_circle?
          hash = { lat: circle[:lat], lon: circle[:lon]}
          hash[:cnt] = cities_count if cities_count
          hash[:cluster] = cluster if cluster

          hash
        end
      end
    end
  end
end