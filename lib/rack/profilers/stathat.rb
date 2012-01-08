require 'rack/request_profiler'
require 'em-stathat'

module Rack
  module Profilers

    # NOTE: This middleware expects that you are running an EventMachine
    # reactor in the current process, and should not be used otherwise.
    class Stathat < RequestProfiler
      def handle_results(env, request)
        clean_url = Utils::UrlStripper.replace_id(request.path)

        EM.next_tick do
          EM::StatHat.new.ez_value("#{request.request_method} #{clean_url}", run_time)
        end
      end
    end
  end
end
