module Backlogjp
  # Represents a backlog.jp component
  class Component < Container
    # @!attribute [r] id
    #   @return [Fixnum] Component ID
    # @!attribute [r] name
    #   @return [String] Component name
    attributes :id, :name

    class << self
      # Creates a new component on the given project
      # @param [Project|Fixnum] Project or integer project id
      # @param [String] Component name
      # @return [Component] The created component or nil if it could not be created
      # @example
      #   project = Backlogjp::Project.all.first
      #   Backlogjp::Component.create(project, "COMPONENT")
      def create(project, name)
        hash = Backlogjp.base._command "addComponent",
                                       :project_id=>Container.get_id(project),
                                       :name=>name

        Component.new(hash) if hash
      end

      # Updates an existing Component
      # @param [String] Component name
      # @return [Component] The updated component
      # @example
      #   # assuming component is a valid Component
      #   Backlogjp::Component.update("COMPONENT_NAME")
      def update(component, name)
        hash = Backlogjp.base._command "updateComponent",
                                       :id=>Container.get_id(component),
                                       :name=>name

        Component.new(hash) if hash
      end

      # Deletes an existing Component
      # @param [Component|Integer] Component or id
      # @example
      #   # assuming component is a valid Component
      #   Backlogjp::Component.delete(component)
      def delete(component)
        Backlogjp.base._command "deleteComponent", Container.get_id(component)
      end
    end

    # Updates the Component
    # @param [String] Component name
    # @return [Component] The updated component
    # @example
    #   # assuming component is a valid Component
    #   component.update("TEST_COMPONENT")
    def update(name)
      Backlogjp::Component.update(self, :name=>name)

      @name  = name

      self
    end

    # Deletes the Component
    # @example
    #   # assuming compoennt is a valid Component
    #   component.delete
    def delete
      Backlogjp::Component.delete(self)
    end
  end
end

