class SettingDecorator < Draper::Decorator
  delegate_all

  def type
    tag_attributes["type"]
  end
  
  def css_class
    tag_attributes["class"]
  end

  private

  def settings
    Setting.default_settings[setting.setting_name] || {}
  end

  def tag_attributes
    settings["tag_attributes"] || {}
  end

end
