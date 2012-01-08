This project provides a simple "framework" for profiling request / response times, and sending the data to another service. It includes a base class `Rack::RequestProfiler` for handling the logic of wrapping and timing the request / response cycle in a rack app.

By default, the `Rack::RequestProfiler` middleware does not do anything with the profiling data. Instead, this logic must be implemented by subclasses by defining the `handle_results` instance method. For example, you might send profiling data to an external web service (stathat, papertrail, loggly, etc), statsd, write to a logfile on disk, put it in a persistent store like redis or mongo, or really anything else your heart desires.

This project currently provides profiler middlewares for stathat and statsd. If you'd like to contribute a profiler middleware, pull requests are welcome.

## Installation

`gem install rack-request_profiler`

## Usage

Simply include one of the profiler middlewares into the middleware stack in any rack-compatible application like so:

```ruby
use Rack::Profilers::Statsd, Statsd.new('localhost'), :ignore_path => /^\/assets/
```

## Profilers

* Statsd - Uses the [statsd ruby client](https://github.com/reinh/statsd-ruby) to send data to statsd / graphite.
* Stathat - Uses the [em-stathat gem](https://github.com/ajsharp/em-stathat) to send data to stathat asynchronously via eventmachine.