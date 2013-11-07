require 'metric_fu/constantize'
module MetricFu
  module Formatter
    BUILTIN_FORMATS = {
      'html' => ['MetricFu::Formatter::HTML', 'Generates a templated HTML report using the configured template class and graph engine.'],
      'yaml' => ['MetricFu::Formatter::YAML', 'Generates the raw output as yaml']
    }
    DEFAULT = [[:html]]

    class << self
      include MetricFu::Constantize

      def class_for(format)
        if (builtin = BUILTIN_FORMATS[format.to_s])
          constantize(builtin[0])
        else
          constantize(format.to_s)
        end
      end

    end

    module Templates
      MetricFu.reporting_require { 'templates/awesome/awesome_template' }

      module_function

      def option(name)
        @config.send(name.to_sym)
      end

      # TODO: Remove config argument
      def configure_template(config)
        @config = config
      end

    end
  end
end
