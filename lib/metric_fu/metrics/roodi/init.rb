module MetricFu
  class MetricRoodi < Metric

    with_aliase :roodi_config, :config

    with_default_run_options({:dirs_to_roodi => MetricFu::Io::FileSystem.directory('code_dirs'),
          :config => "#{MetricFu::Io::FileSystem.directory('root_directory')}/config/roodi_config.yml"})

    def name
      :roodi
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
