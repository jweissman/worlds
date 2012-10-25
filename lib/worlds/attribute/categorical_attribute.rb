module Worlds
  module Attribute
    class CategoricalAttribute < Base
      attr_accessor :values

      def initialize(name, values)
        super(name)
        @values = values
      end

      def sample
        @values.sample
      end
    end
  end
end