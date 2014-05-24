class SettingsController < ApplicationController
  def index
    @settings = Settings.unscoped
  end

  def edit
    @setting = Settings.unscoped.find(params[:id])
  end
end
