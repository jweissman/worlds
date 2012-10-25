module Worlds
  module Attribute
    #
    #   Attribute base entity.
    #
    #   Subclasses expected to implement a #sample method, and override #sample!
    #
    class Base < Struct.new(:name)
      def sample!(individual)
        individual[name] = self.sample
      end
    end
  end
end