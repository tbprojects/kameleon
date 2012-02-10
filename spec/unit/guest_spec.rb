require 'spec_helper'

describe "Kameleon::User::Guest" do
  include ::Capybara::DSL

  before(:all) do
    Capybara.current_driver = :rack_test
    @guest = Kameleon::User::Guest.new(self, {:session_name => :see_world})
    @another_guest = Kameleon::User::Guest.new(self)
  end

  after(:all) { Capybara.use_default_driver }

  context "sessions" do
    it "by default user should get some session" do
      @another_guest.send(:session).should be_kind_of(Capybara::Session)
      @another_guest.debug.should be_kind_of(Capybara::Session)
    end

    it "guests should have separate session if param :session_name defined" do
      @guest.debug.should_not == Capybara.current_session
    end
  end

  context "driver" do
    it "will not change if not defined in params" do
      @guest.debug.driver.should be_a Capybara.current_session.driver.class
    end

    context "selecting custom driver" do
      before(:all) do
        @selenium = Kameleon::User::Guest.new(self, {:session_name => :new_world, :driver => :selenium, :skip_page_autoload => true})
      end

      it "should set Selenium if params :driver => :selenium" do
        @selenium.debug.driver.should be_a Capybara::Selenium::Driver
      end

      it "shouldn't change drivers for other users'" do
        [@guest, @another_guest].each do |user|
          user.debug.driver.should be_a Capybara::RackTest::Driver
        end
      end
    end
  end
end
