require_relative 'spec_helper'

describe Girdle::Helpers do 
  
  describe '::validate_options!' do
    
    before do
      @valid_options = [:foo, :bar]
    end
    
    it 'must validate valid options' do
      Girdle::Helpers.validate_options!(@valid_options, foo: 'foo', bar: 'bar').must_equal true
    end
    
    it 'must invalidate invalid options' do
      Proc.new { Girdle::Helpers.validate_options!(@valid_options, ugh: 'ugh', foo: 'foo')}.must_raise ArgumentError
    end
    
  end
end