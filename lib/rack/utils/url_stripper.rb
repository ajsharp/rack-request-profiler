module Rack
  module Utils
    class UrlStripper
      # A crude attempt at matching a BSON id format (http://bsonspec.org/)
      ID_PATTERN = /[0-9]+[a-zA-Z]+[^\/]*/

      def self.replace_id(url)
        url.gsub(ID_PATTERN, 'ID')
      end
    end
  end
end
