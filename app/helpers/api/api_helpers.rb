module Api
  module ApiHelpers
    def parse_attributes
      column = nil
      attributes.each do |attribute|
        column = attribute if params[attribute]
      end
      return column
    end
  end
end
