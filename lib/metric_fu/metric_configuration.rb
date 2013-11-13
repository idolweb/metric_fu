require 'map'

module MetricFu
  module MetricConfiguration

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def with_aliases(aliases)
        aliases.each do |an_alias, option|
          with_aliase(an_alias, option)
        end
      end

      def with_aliase(an_alias, option)
        define_method("#{an_alias}=") do |value|
          set_option(option, value)
        end
      end

      def with_default_run_options(options)
        default_run_options.merge!(options)
      end

      def default_run_options
        @default_run_options ||= Map.new
      end
    end

    # Enable using a syntax such as metric.foo = 'foo'
    #   by catching the missing method here,
    #   and setting the key/value in the @configured_run_options map
    def method_missing(method, *args)
      key = method_to_attr(method)
      value = args.first
      if value == false
        remove_option(key)
      else
        set_option(key, args.first)
      end
    end

    def set_option(option, value)
      configured_run_options[option] = value
    end

    def remove_option(option)
      configured_run_options.delete(option)
    end

    # Used above to identify the stem of a setter method
    def method_to_attr(method)
      method.to_s.sub(/=$/, '').to_sym
    end

    def configured_run_options
      @configured_run_options ||= Map.new
    end

    def run_options
      self.class.default_run_options.merge(configured_run_options)
    end

  end
end