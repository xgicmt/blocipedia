class UserController < ApplicationController
       def downgrade
         current_user.update_attribute(:role, 'standard')
           current_user.wikis.each do |wiki|
              wiki.update_attributes(private: false)
           end
         flash[:notice] = "You are now back to a normal loser, I mean user"
         redirect_to wikis_path
       end
end
