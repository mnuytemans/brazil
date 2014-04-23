require 'spec_helper'

describe BettablesController do

  describe "GET 'New'" do
    it "returns http success" do
      get 'New'
      response.should be_success
    end
  end

  describe "GET 'Edit'" do
    it "returns http success" do
      get 'Edit'
      response.should be_success
    end
  end

end
