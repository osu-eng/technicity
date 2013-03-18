require "spec_helper"

describe RegionSetMembershipsController do
  describe "routing" do

    it "routes to #index" do
      get("/region_set_memberships").should route_to("region_set_memberships#index")
    end

    it "routes to #new" do
      get("/region_set_memberships/new").should route_to("region_set_memberships#new")
    end

    it "routes to #show" do
      get("/region_set_memberships/1").should route_to("region_set_memberships#show", :id => "1")
    end

    it "routes to #edit" do
      get("/region_set_memberships/1/edit").should route_to("region_set_memberships#edit", :id => "1")
    end

    it "routes to #create" do
      post("/region_set_memberships").should route_to("region_set_memberships#create")
    end

    it "routes to #update" do
      put("/region_set_memberships/1").should route_to("region_set_memberships#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/region_set_memberships/1").should route_to("region_set_memberships#destroy", :id => "1")
    end

  end
end
