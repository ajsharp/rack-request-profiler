module Rack
  module Utils
    class UrlStripper
      ID_PATTERN = /([0-9][a-z][^\/]+)/

      def self.replace_id(url)
        url.gsub(ID_PATTERN, 'ID')
      end
    end
  end
end
