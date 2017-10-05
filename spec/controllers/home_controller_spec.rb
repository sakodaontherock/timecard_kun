require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    after do
      Timecop.return
    end

    it "assigns users" do
      Timecop.freeze Time.zone.local(2017, 9, 25)
      users = FactoryGirl.create_list(:user, 2)
      get :index
      expect(assigns(:users)).to eq users
    end

    it "assigns records grouped by user_id" do
      Timecop.freeze Time.zone.local(2017, 9, 25)
      users = FactoryGirl.create_list(:user, 2)
      records = users.map do |user|
        [
          FactoryGirl.create(:record, user: user, started_at: Time.zone.local(2017, 9, 25, 7, 57, 28)),
          FactoryGirl.create(:record, user: user, started_at: Time.zone.local(2017, 9, 25, 8, 57, 28))
        ]
      end
      get :index
      expect(assigns(:users)).to eq users
      expect(assigns(:records)[users[0].id]).to eq records[0]
      expect(assigns(:records)[users[1].id]).to eq records[1]
    end
  end
end
