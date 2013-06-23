require 'spec_helper'

describe "Login" do
  describe "visiting /" do
    before do
      visit root_path
    end

    it "should show login page" do
      page.should have_content('Forgot your password?')
      page.should have_xpath("//input[@id='user_email']")
    end

    it 'should show roadmap after sign_in' do
      fill_in 'user_email', with: 'masteradmin@gmail.com'
      fill_in 'user_password', with: 'masteradmin'
      click_button 'Sign in'
      page.should have_content('Roadmap')
    end
  end
end

describe 'Invitation' do
  before do
    visit root_path
    fill_in 'user_email', with: 'masteradmin@gmail.com'
    fill_in 'user_password', with: 'masteradmin'
    click_button 'Sign in'
  end

  describe 'inviting new user by admin' do
    it 'should sent invitation email' do
      visit users_path
      click_link 'Invite new User'
      fill_in 'user_email', with: 'tracker_user@mailinator.com'
      click_button 'Send an invitation'
      Capybara.default_wait_time=20
      page.should have_content('An invitation email has been sent')
      Capybara.default_wait_time=5
    end
  end

  describe 'accept invitation' do
    it 'should successfully create account' do
      driver = Selenium::WebDriver.for :chrome
      driver.get 'http://mailinator.com'
      input = driver.find_element(:xpath, "//input[@name='email']")
      input.send_keys('tracker_user')
      element = driver.find_element(:xpath, "//input[@type='image']")
      element.click
      letter = driver.find_element(:xpath, "//a[text()='invitation instructions']")
      letter.click
      accept_link = driver.find_element(:xpath, "//a[text()='Accept invitation']")
      url = accept_link.attribute 'href'
      url = url.sub(/http:\/\/.*:\d+/,'')
      visit root_path
      click_link 'Logout'
      visit url
      page.should have_content('Set your name')
    end
  end
end
