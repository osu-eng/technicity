require "spec_helper"

describe RegionSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/region_sets").should route_to("region_sets#index")
    end

    it "routes to #new" do
      get("/region_sets/new").should route_to("region_sets#new")
    end

    it "routes to #show" do
      get("/region_sets/1").should route_to("region_sets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/region_sets/1/edit").should route_to("region_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/region_sets").should route_to("region_sets#create")
    end

    it "routes to #update" do
      put("/region_sets/1").should route_to("region_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/region_sets/1").should route_to("region_sets#destroy", :id => "1")
    end

  end
end
