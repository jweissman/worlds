module Worlds
  module Attribute
    class ConstantAttribute < Base
      attr_accessor :value
      def initialize(name, value)
        super(name)
        @value = value
      end

      def sample
        @value
      end
    end
  end
end