class AboutController < ApplicationController

  def index
    @setting = Setting.About
  end
end
