module MetricFu
  class MetricFlay < Metric

    with_aliase :minimum_score, :mass
    with_default_run_options({:dirs_to_flay => MetricFu::Io::FileSystem.directory('code_dirs')})

    def name
      :flay
    end

    def has_graph?
      true
    end

    def enable
      super
    end

    def activate
      super
    end

  end
end
