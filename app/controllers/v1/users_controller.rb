module V1
  class UsersController < ApplicationController
    prepend_before_action :swap_id_for_me, only: [:show]

    def swap_id_for_me
      return unless params[:id] == 'me'
      params[:id] = current_user.try(:id)
    end
  end
end
