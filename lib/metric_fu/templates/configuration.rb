module MetricFu::Templates
  class Configuration

    def initialize
      @options = {}
      @options[:template_class] = AwesomeTemplate
      @options[:darwin_txmt_protocol_no_thanks] = true
      # turning off syntax_highlighting may avoid some UTF-8 issues
      @options[:syntax_highlighting] = true
    end

    [:template_class, :link_prefix, :syntax_highlighting, :darwin_txmt_protocol_no_thanks].each do |option|
      define_method("#{option}=") do |arg|
        @options[option] = arg
      end
    end

    def option(name)
      @options.fetch(name.to_sym) { raise "No such template option: #{name}" }
    end

  end

end