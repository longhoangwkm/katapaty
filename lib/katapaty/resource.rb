module Katapaty
  class Resource
    class << self
      def api_name
        to_s.split('::').last.gsub(/[^\A]([A-Z])/, '_\\1').downcase
      end
    end
  end
end
