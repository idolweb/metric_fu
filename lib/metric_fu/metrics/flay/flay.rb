module MetricFu

  class FlayGenerator < Generator

    ignore_option :dirs_to_flay
    with_long_option_type :long_option_without_equals

    def self.metric
      :flay
    end

    def emit
      @output = run!(build_options)
    end

    def build_options
      args = super
      args << ' ' + options[:dirs_to_flay].join(" ") unless options[:dirs_to_flay].empty?
      args
    end

    def analyze
      @matches = @output.chomp.split("\n\n").map{|m| m.split("\n  ") }
    end

    def to_h
      target = []
      total_score = @matches.shift.first.split('=').last.strip
      @matches.each do |problem|
        reason = problem.shift.strip
        lines_info = problem.map do |full_line|
          name, line = full_line.split(":")
          {:name => name.strip, :line => line.strip}
        end
        target << [:reason => reason, :matches => lines_info]
      end
      {:flay => {:total_score => total_score, :matches => target.flatten}}
    end
  end
end
