module OpenWeatherAPI
  module Resources

    class Current
      private

      class City < QueryHandler
        private
        
        def build
          { q: [value, country_code].compact.flatten.join(',') }
        end
        
        def value
          @parameters[:city]
        end
      end

      class CityID < QueryHandler
        def multiple?
          value.is_a? Array
        end

        private

        def build
          { q: [value].flatten.compact.join(',') }
        end

        def value
          @parameters[:id] || @parameters[:city_id]
        end
      end

      class Geolocation < QueryHandler
        def can?
          latitude != nil && longitude != nil
        end

        private

        def build
          { lat: latitude, lon: longitude }
        end

        def latitude
          @parameters[:latitude] || @parameters[:lat]
        end

        def longitude
          @parameters[:longitude] || @parameters[:lon]
        end
      end

      class Zipcode < QueryHandler
        private

        def build
          { zip: [value, country_code].compact.flatten.join(',') }
        end
        
        def value
          @parameters[:zipcode] || @parameters[:zip]
        end
      end
      
      class BoundingBox < QueryHandler
        private
        
        def topleft
          [ value[:topleft][:lat], value[:topleft][:lon] ].join(',')
        end

        def bottomright
          [ value[:bottomright][:lat], value[:bottomright][:lon] ].join(',')
        end

        def zoom
          value[:zoom] || value[:map_zoom] || 10
        end

        def value
          @parameters[:box] || @parameters[:box] || @parameters[:rect] || @parameters[:rectangle]
        end

        def build
          fill bbox: [topleft, bottomright, zoom].join(',')
        end
      end

      class Circle < QueryHandler
        private

        def value
          @parameters[:circle]
        end

        def build
          fill lat: value[:lat], lon: value[:lon]
        end
      end
    end
  end
end