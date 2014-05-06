class SettingsController < ApplicationController
  before_action :admin_user, [:index, :update]


  def index
  	@settings = Setting.all
  end

  def update
  	@setting = Setting.find(params[:id])
  	@setting.update_attributes(settings_params)
    if @setting.save
      flash[:success] = "Setting updated."
      redirect_to settings_path
    else
      flash[:error] = "Setting not updated."
  	  render 'index'
    end
  end


  private

   	def admin_user	
  		redirect_to(root_url) unless current_user.admin?
  	end

  	def settings_params
  		params.require(:setting).permit(:value)
  	end
end
