require 'spec_helper'

describe MetricFu::OptionsBuilder do

  class DummyGenerator
    include OptionsBuilder

    attr_accessor :options

    def initialize(options)
      @options = options
    end
  end

  def builder_with_options(options)
    @option_builder = DummyGenerator.new(options)
  end

  context 'given a long option' do

    it 'is output as a long option' do
      builder_with_options(Map(:foo => 'qux'))
      expect(@option_builder.build_options).to include('--foo=qux')
    end

    it 'replaces underscores with dash by default' do
      builder_with_options(Map(:foo_bar => 'qux'))
      expect(@option_builder.build_options).to include('--foo-bar=qux')
    end

    context 'when underscores are allowed' do

      before do
        DummyGenerator.with_underscores
      end

      it 'keeps underscore' do
        builder_with_options(Map(:foo_bar => 'qux'))
        expect(@option_builder.build_options).to include('--foo_bar=qux')
      end

    end

    context 'given a long option without parameter' do
      it 'is output without parameter' do
        builder_with_options(Map(:foo => nil))
        expect(@option_builder.build_options).to include('--foo')
      end
    end

  end

  context 'given a short option' do

    it 'is output as a short option' do
      builder_with_options(:f => 'qux')
      expect(@option_builder.build_options).to include('-f qux')
    end

    context 'given a short option without parameter' do
      it 'is output without parameter' do
        builder_with_options(:f => nil)
        expect(@option_builder.build_options).to include('-f')
      end
    end

  end

  context 'given a option with an array parameter' do

    it 'is output once per element' do
      builder_with_options(Map(:foo => ['qux', 'qax']))
      expect(@option_builder.build_options).to include('--foo=qux --foo=qax')
    end

  end

end