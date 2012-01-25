module Treat
  module Sugar
    def edulcorate
      return if @@edulcorated
      @@edulcorated = true
      each_entity_class do |type, klass|
        unless type == :Symbol
          Object.class_eval do
            define_method(type) do |value='',id=nil|
              klass.build(value, id)
            end
          end
        end
      end
    end
    def unedulcorate
      return unless @@edulcorated
      @@edulcorated = false
      each_entity_class do |type, klass| 
        unless type == :Symbol
          Object.class_eval do
             remove_method(type)
          end
        end
      end
    end
    # Whtypeher syntactic sugar is
    # enabled or not.
    def edulcorated?; @@edulcorated; end
    # Syntactic sugar is disabled by default.
    @@edulcorated = false

    private
    
    def each_entity_class
      Treat::Entities.list.each do |entity_type|
        type = :"#{cc(entity_type)}"
        klass = Treat::Entities.const_get(type, klass)
        yield type, klass
      end
    end
  end
end