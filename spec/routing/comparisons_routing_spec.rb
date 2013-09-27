require 'spec_helper'

describe 'comparisons routing' do

  describe 'paths that should work' do
    it 'routes to #create' do
      expect(:post => '/comparisons').to route_to('comparisons#create')
    end
  end

  describe 'paths that should not work' do
    it 'should not route to #index' do
      expect(:get => '/comparisons').not_to be_routable
    end
  end

end
