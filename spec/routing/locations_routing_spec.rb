require 'spec_helper'

describe 'locations routing' do

  describe 'paths that should work' do

    it 'routes to #create' do
      expect(:post => '/locations').to route_to('locations#create')
    end

    it 'routes to #show' do
      expect(:get => '/locations/1').to route_to('locations#show', :id => '1')
    end

    it 'routes to #update' do
      expect(:put => '/locations/1').to route_to('locations#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/locations/1').to route_to('locations#destroy', :id => '1')
    end

  end

  describe 'paths that should not work' do

    it 'should not route to #index' do
      expect(:get => '/locations').not_to be_routable
    end

    it 'should not route to #new' do
      expect(:get => '/locations/new').not_to route_to('locations#new')
    end

    it 'should not route to #edit' do
      expect(:get => '/locations/1/edit').not_to be_routable
    end
  end

end
