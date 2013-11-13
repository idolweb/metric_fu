module MetricFu
  class MetricChurn < Metric

    with_default_run_options({:start_date => %q("1 year ago"), :minimum_churn_count => 10, :yaml => true})

    def name
      :churn
    end

    def has_graph?
      false
    end

    def enable
      super
    end

    def activate
      super
    end

  end
end
