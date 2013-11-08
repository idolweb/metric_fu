module MetricFu
  class MetricReek < Metric

    with_aliase :config_file_pattern, :config

    with_default_run_options({:dirs_to_reek => MetricFu::Io::FileSystem.directory('code_dirs'),
          :config => 'config/*.reek', :line_number => true})

    def name
      :reek
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
