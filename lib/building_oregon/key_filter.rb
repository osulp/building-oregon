module BuildingOregon
  class KeyFilter
    def initialize(keys, exceptions)
      @keys ||= keys
      @exceptions = exceptions
    end

    def call
      filter_exceptions
    end

    def filter_exceptions
      return @keys.delete_if{|key| contained_in_exceptions_list(key) }
    end

    def exceptions_list
      @exceptions
    end

    private

    def contained_in_exceptions_list(key)
      exceptions_list.include?(key)
    end
  end
end
