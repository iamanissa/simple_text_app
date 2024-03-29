require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/signup").to route_to("users#new")
      expect(:get => signup_path).to route_to(:controller => "users", :action => "new")
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to("users#create")
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", :id => "1")
    end
  end
end