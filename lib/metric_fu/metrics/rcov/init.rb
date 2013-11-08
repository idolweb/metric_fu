module MetricFu
  class MetricRcov < Metric

    def self.rcov_opts
      rcov_opts = [
          "--sort coverage",
          "--no-html",
          "--text-coverage",
          "--no-color",
          "--profile",
          "--exclude-only '.*'",
          '--include-file "\Aapp,\Alib"'
      ]
      rcov_opts << "-Ispec" if File.exist?("spec")
      rcov_opts
    end

    with_default_run_options({:environment => 'test',
          :test_files => Dir['{spec,test}/**/*_{spec,test}.rb'],
          :rcov_opts => self.rcov_opts,
          :external => nil})

    def name
      :rcov
    end

    def has_graph?
      true
    end

    def enable
      MetricFu.configuration.mf_debug("rcov is not available. See README")
    end

    def activate
      super
    end



  end
end
