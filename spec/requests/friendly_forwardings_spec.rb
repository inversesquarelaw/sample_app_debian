require 'spec_helper'

describe "FriendlyForwardings" do
  describe "GET /friendly_forwardings" do
    it "should forward to the request page after signin" do
      user = Factory(:user)
      visit edit_user_path(user)
      fill_in :email, :with => user.email
      fill_in :password, :with => user.password
      click_button
      response.should render_template('users/edit')

      visit signout_path
      visit signin_path
      fill_in :email, :with => user.email
      fill_in :password, :with => user.password
      click_button
      response.should render_template('users/show')
    end
  end
end