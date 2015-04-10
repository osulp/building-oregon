# Responsibility of this object is to render the representation of a field's
# value for the show view.
class ControlledValue
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def to_s
    label
  end

  private

  def split_string
    @split_string ||= value.split("$")
  end

  def label
    split_string.first
  end
end
