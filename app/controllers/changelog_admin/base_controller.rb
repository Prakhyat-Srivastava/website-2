module ChangelogAdmin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled!
    before_action :check_authorization!

    layout "changelog_admin"

    protected

    def unauthorized!
      redirect_to root_path, status: 401
    end

    private

    def check_feature_enabled!
      return unauthorized! unless Flipper[:changelog].enabled?(current_user)
    end

    def check_authorization!
      return unauthorized! unless current_user.may_edit_changelog?
    end
  end
end
