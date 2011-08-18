require_relative '../spec_helper'

describe Griddle::Grid do
  
  it 'must have id attribute' do
    grid = Griddle::Grid.new(123)
    grid.id.must_equal 123
  end
  
  it 'must retrieve list identifiers of all logical grids' do
    Griddle.expects(:run).with(grid: 'list').returns([1,2,3])
    list = Griddle::Grid.list
    list.must_equal [1,2,3]
  end
  
  describe 'a grid' do
    
    before do
      @grid = Griddle::Grid.new(123)
      @attributes = {
        'name' => 'name',
        'gridMegahertz' => '0',
        'isDefault' => 'YES'
      }
    end
    
    it 'must retrieve attributes' do
      Griddle.expects(:run).with(grid: 'attributes', gid: 123).returns('gridAttributes' => @attributes)
      @grid.attributes.must_equal @attributes
    end
    
    it 'must retrieve name' do
      @grid.expects(:attributes).returns(@attributes)
      @grid.name.must_equal 'name'
    end
    
    it 'must retrieve megahertz' do
      @grid.expects(:attributes).returns(@attributes)
      @grid.megahertz.must_equal '0'
    end
    
    describe '#is_default' do
      
      it 'must be true when isDefault is YES' do
        @grid.expects(:attributes).returns(@attributes)
        @grid.is_default?.must_equal true
      end
      
      it 'must be false when isDefault is NO' do
        attributes = @attributes.merge('isDefault' => 'NO')
        @grid.expects(:attributes).returns(attributes)
        @grid.is_default?.must_equal false
      end
    end
    
  end
end