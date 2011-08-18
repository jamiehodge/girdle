require_relative '../spec_helper'

describe Girdle::Controller do
  
  it 'must have id attribute' do
    grid = Girdle::Controller.new(123)
    grid.id.must_equal 123
  end
  
  it 'must retrieve list of failover controllers' do
    Girdle.expects(:run).
      with(controller: 'list').
      returns('controllerList' => Hash.new)
    list = Girdle::Controller.list
    list.must_equal Hash.new
  end
  
  it 'must retrieve role of controller' do
    Girdle.expects(:run).
      with(controller: 'role').
      returns('controllerRole' => 'MASTER')
    role = Girdle::Controller.role
    role.must_equal 'MASTER'
  end
  
  describe '::promote' do
    
    it 'must promote the controller to MASTER role' do
      Girdle.expects(:run).
        with(controller: 'promote', role: 'MASTER').
        returns('controllerRole' => 'MASTER')
      role = Girdle::Controller.promote(:master)
      role.must_equal 'MASTER'
    end
    
    it 'must promote the controller to PASSIVE role' do
      Girdle.expects(:run).
        with(controller: 'promote', role: 'PASSIVE').
        returns('controllerRole' => 'PASSIVE')
      role = Girdle::Controller.promote(:passive)
      role.must_equal 'PASSIVE'
    end
  
  end
  
  describe '::autopromote' do
    
    it 'must autopromote the controller to MASTER role' do
      Girdle.expects(:run).
        with(controller: 'autopromote', role: 'MASTER').
        returns('controllerRole' => 'MASTER')
      role = Girdle::Controller.autopromote(:master)
      role.must_equal 'MASTER'
    end
    
    it 'must autopromote the controller to PASSIVE role' do
      Girdle.expects(:run).
        with(controller: 'autopromote', role: 'PASSIVE').
        returns('controllerRole' => 'PASSIVE')
      role = Girdle::Controller.autopromote(:passive)
      role.must_equal 'PASSIVE'
    end
  
  end
  
  
end