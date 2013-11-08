require 'set'
require_relative 'metric_configuration'
MetricFu.lib_require { 'gem_run' }
# Encapsulates the configuration options for each metric
module MetricFu
  class Metric
    include MetricConfiguration

    attr_accessor :enabled, :activated

    def initialize
      self.enabled = false
      @libraries = Set.new
    end

    def enable
      self.enabled = true
    end

    # TODO: Confirm this catches load errors from requires in subclasses, such as for flog
    def activate
      @libraries.each {|library| require(library) }
      self.activated = true
    rescue LoadError => e
      mf_log "#{name} metric not activated, #{e.message}"
    end

    # @return metric name [Symbol]
    def name
      not_implemented
    end

    def gem_name
      name
    end

    def run
      not_implemented
    end

    def run_external(args = default_run_args)
      runner = GemRun.new({
        gem_name: gem_name.to_s,
        metric_name: name.to_s,
        # version: ,
        args: args,
      })
      runner.run
    end

    # @return metric_options [Hash]
    def has_graph?
      not_implemented
    end

    @metrics = []
    # @return all subclassed metrics [Array<MetricFu::Metric>]
    # ensure :hotspots runs last
    def self.metrics
      @metrics
    end

    def self.enabled_metrics
      metrics.select{|metric| metric.enabled && metric.activated}.sort_by {|metric| metric.name  == :hotspots ? 1 : 0 }
    end

    def self.get_metric(name)
      metrics.find{|metric|metric.name.to_s == name.to_s}
    end

    def self.inherited(subclass)
      @metrics << subclass.new
    end

    private

    def not_implemented
      raise "Required method #{caller[0]} not implemented in #{__FILE__}"
    end

    def activate_library(file)
      @libraries << file.strip
    end

  end
end
