require 'spec_helper'

describe MetricFu::MetricConfiguration do

  class DummyMetric
    include MetricConfiguration
  end

  context 'given a option' do

    before do
      @metric = DummyMetric.new
    end

    it 'can be configured as an attribute' do
      @metric.foo = 'qux'
      expect(@metric.run_options[:foo]).to eq('qux')
    end

    context 'given aliases' do

      before do
        DummyMetric.with_aliases({:bar => :foo})
      end

      it 'configures the aliased option' do
        @metric.bar = 'qux'
        expect(@metric.run_options[:foo]).to eq('qux')
        expect(@metric.run_options[:bar]).to be_nil
      end
    end

  end


end