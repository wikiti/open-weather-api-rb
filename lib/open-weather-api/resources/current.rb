module OpenWeatherAPI
  module Resources
    class Current < Base

      def base_url
        return super + 'group'    if city_id.multiple?
        return super + 'weather'  if [city, city_id, geolocation, zipcode].any? { |h| h.can? }
        return super + 'box/city' if bbox.can?
        return super + 'find'     if circle.can?
      end

      def build_params(parameters = {})
        super [city, city_id, geolocation, zipcode, bbox, circle].each{ |h| break h.handle if h.can? }
      end

      # Simple handlers
      def city
        City.new @api_obj, @parameters
      end

      def city_id
        CityID.new @api_obj, @parameters
      end

      def geolocation
        Geolocation.new @api_obj, @parameters
      end

      def zipcode
        Zipcode.new @api_obj, @parameters
      end

      # Other handlers
      # ------------------
      def bbox
        BoundingBox.new @api_obj, @parameters
      end
      
      def circle
        Circle.new @api_obj, @parameters
      end

    end
  end
end