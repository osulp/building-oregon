class Admin::SettingsController < AdminController
  respond_to :html, :json
  before_filter :find_setting, :only => [:update]
  before_filter :default, :only => [:index]

  def index  
    @settings = Setting.all.decorate
  end

  def update
    flash[:success] = "Successfully Updated Setting" if @setting.update_attributes(setting_params)
    respond_with @setting, :location => admin_settings_path
  end

  private

  def default
    Setting.create_defaults
  end

  def setting_params
    params.require(:setting).permit(:setting_name, :value)
  end

  def find_setting
    @setting = Setting.find(params[:id])
  end
end