require 'spec_helper'

describe AssetsController do
  let(:project) { Factory(:project) }
  let(:ticket) { Factory(:ticket, :project => project) }
  let(:good_user) { Factory(:user) }
  let(:bad_user) { Factory(:user) }

  let(:path) { Rails.root + "spec/fixtures/speed.txt" }
  let(:asset) do
    ticket.assets.create(:asset => File.open(path))
  end

  before do
    good_user.permissions.create!(:action => "view", :object => project)
  end

  context "users with access" do
    before do
      sign_in(:user, good_user)
      good_user.confirm!
    end

    it "can access assets in a project" do
      get 'show', :id => asset.id
      response.body.should eql(File.read(path))
    end
  end

  context "users without access" do
    before do
      sign_in(:user, bad_user)
      bad_user.confirm!
    end

    it "cannot access assets in this project" do
      get 'show', :id => asset.id
      response.should redirect_to(root_path)
      flash[:alert].should eql("The asset you were looking for could not be found.")
    end
  end
end
