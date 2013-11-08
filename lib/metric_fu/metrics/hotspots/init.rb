module MetricFu
  class MetricHotspots < Metric

    # TODO remove explicit Churn dependency
    with_default_run_options({:start_date => "1 year ago", :minimum_churn_count => 10})

    def name
      :hotspots
    end

    def has_graph?
      false
    end

    def enable
      super
    end

  end
end
