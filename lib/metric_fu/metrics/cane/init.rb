module MetricFu
  class MetricCane < Metric

    with_aliase :line_length, :style_measure

    with_default_run_options({:abc_max => 15,
                              :style_measure => 80})

    def name
      :cane
    end

    def has_graph?
      true
    end

    def enable
      if MetricFu.configuration.supports_ripper? && !MetricFu.configuration.ruby18?
        super
      else
        MetricFu.configuration.mf_debug("Cane is only available in MRI. It requires ripper and 1.9 hash syntax support")
      end
    end

    def activate
      super
    end

  end
end
