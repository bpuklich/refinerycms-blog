module Refinery
  module Blog
    module Admin
      module PostsHelper

        def find_all_refinery_users
          Refinery::Blog.user_class.all.select{|u| u.has_role?(:refinery)}
        end
      end
    end
  end
end
