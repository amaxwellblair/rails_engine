module Api
  module ApiHelpers
    def parse_attributes
      column = nil
      model.attribute_names.each do |attribute|
        column = attribute if params[attribute]
      end
      return column
    end

    def parse_relations
      relationship = ""
      relations.each do |relation|
        relationship = relation if params["relation"] == relation
      end
      return relationship
    end
  end
end
