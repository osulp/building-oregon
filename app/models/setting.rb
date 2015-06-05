class Setting < ActiveRecord::Base
  validates :setting_name, :uniqueness => true, :presence => true
  def self.method_missing(m, *args)
    new_string = self.default_settings.keys.find { |key| key.gsub(" ", "_").underscore.to_s == m.to_s.underscore }
    return super unless new_string
    return self.setting_value(new_string)
  end

  def self.default_settings
    @default_settings ||= YAML.load_file(Rails.root.join("config", "settings.yml")) || {}
  end

  def self.create_defaults
    default_settings.each do |setting_name, settings|
      self.where(:setting_name => setting_name).first_or_create(:value => value(settings))
    end
  end

  def self.value(settings)
    settings["tag_attributes"]["default"]
  end

  def self.method_missing_value(new_string)
    @default_settings[new_string]["tag_attributes"]["default"]
  end

  def self.setting_value(new_string)
    self.where(:setting_name => new_string).first_or_initialize(:value => method_missing_value(new_string)).value.to_s
  end
end
