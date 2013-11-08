module MetricFu
  class ChurnGenerator < Generator

    with_underscores

    def self.metric
      :churn
    end

    def emit
      @output = generate_churn_metrics
    end

    def analyze
      if @output.nil? || @output.match(/Churning requires.*git/)
        @churn = {:churn => {}}
      else
        @churn = YAML::load(@output)
      end
    end

    # ensure hash only has the :churn key
    def to_h
      {:churn => @churn[:churn]}
    end

    private

    def generate_churn_metrics
      output = churn_code
      ensure_output_is_valid_yaml(output)
    end

    def churn_code
      run!(build_options)
    end

    def ensure_output_is_valid_yaml(output)
      yaml_start = output.index("---")
      if yaml_start
        output[yaml_start...output.length]
      else
        nil
      end
    end

  end

end
