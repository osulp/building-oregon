class HelpController < ApplicationController
  def index
    @setting = Setting.Help
  end
end
