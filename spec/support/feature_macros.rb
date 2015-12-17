include Warden::Test::Helpers
Warden.test_mode!

module FeatureMacros
  def refinery_blog_login_with(factory)
    let!(:logged_in_user) { FactoryGirl.create(factory) }

    before do
      login_as logged_in_user, :scope => :authentication_devise_user
    end
    after { Warden.test_reset! }
  end
  #
end
