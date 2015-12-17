include Devise::TestHelpers

module ControllerMacros
  def refinery_blog_login_with(*roles)
    mock_user roles
  end

  def mock_user(roles)
    let(:controller_permission) { true }
    let(:logged_in_user) do
      user = double 'Refinery::Devise::Authentication::User', :username => 'Joe Fake'
      roles.each do |role|
        user.stub(:has_role?).with(role).and_return true
      end
      user.stub(:has_role?).with(:superuser).and_return false if roles.exclude? :superuser
      user
    end

    before do
      controller.should_receive(:authenticate_refinery_user!).and_return true
      controller.should_receive(:allow_controller?).and_return controller_permission
    end
  end
end
