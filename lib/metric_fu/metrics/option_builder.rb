require 'set'
require 'map'

module MetricFu
  module OptionsBuilder

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods

      def ignore_options(new_ignored_options)
        ignored_options.merge(new_ignored_options)
      end

      def ignore_option(ignored_option)
        ignored_options.store(ignored_option, nil)
      end

      def ignored_options
        # a map is used to take advantage of symbol/string indifference
        @ignored_options ||= Map.new
      end

      def with_long_option_type(long_option_type)
        @long_option_type = long_option_type
      end

      def long_option_type
        @long_option_type ||= :long_option_with_equals
      end

      def with_underscores
        @underscores = true
      end

      def underscores
        @underscores ||= false
      end

    end

    def build_options
      opts = []
      options.each do |option, value|
        unless self.class.ignored_options.has_key?(option)
          opts << build_option(option, value)
        end
      end
      opts.join(' ').strip
    end

    def build_option(option, value)
      value = [value] unless value.is_a?(Array)
      arg = []
      value.each do |val|
        if option.length == 1
          arg << build_short_option(option, val)
        else
          arg << build_long_option(option, val)
        end
      end
      arg.join(' ').strip
    end

    def build_short_option(option, val)
      arg = "-#{option}"
      arg << " #{val}" unless val.nil? || val == true
      arg
    end

    def build_long_option(option, val)
      arg = "--#{sanitize_option_name(option)}"
      unless val.nil? || val == true
        arg << "#{long_option_separator}#{val}"
      end
      arg
    end

    def long_option_separator
      if self.class.long_option_type == :long_option_with_equals
        '='
      else
        ' '
      end
    end

    def sanitize_option_name(option)
      if self.class.underscores
        option
      else
        option.to_s.gsub(/_/, '-')
      end
    end
  end
end