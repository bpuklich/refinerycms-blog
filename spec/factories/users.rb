FactoryGirl.define do
  factory :user, :class => Refinery::Blog.user_class do
    sequence(:username) { |n| "refinery#{n}" }
    sequence(:email) { |n| "refinery#{n}@refinerycms.com" }
    password  "refinerycms"
    password_confirmation "refinerycms"
  end

  factory :refinery_user, :parent => :user do
    roles { [ ::Refinery::Authentication::Devise::Role[:refinery] ] }

    after(:create) do |user|
      ::Refinery::Plugins.registered.each_with_index do |plugin, index|
        user.plugins.create(:name => plugin.name, :position => index)
      end
    end
  end

  factory :refinery_superuser, :parent => :refinery_user do
    roles { [ ::Refinery::Authentication::Devise::Role[:refinery], ::Refinery::Authentication::Devise::Role[:superuser] ]}
  end
end
