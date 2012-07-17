module Rack
  module Utils
    class UrlStripper
      class << self
        def id_pattern
          # A crude attempt at matching a BSON id format (http://bsonspec.org/)
          @id_pattern ||= /[0-9]+[a-zA-Z]+[^\/]*/
        end

        def id_pattern=(pattern)
          @id_pattern = pattern
        end

        def replace_id(url)
          url.gsub(id_pattern, 'ID')
        end
      end
    end
  end
end
