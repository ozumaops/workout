class TraningMenusController < ApplicationController

    def new
        @training_menus = @user.training_menus.new
        @body_parts= Bodypart.where(id: params[:body_part])
    end