module Backlogjp
  # Represents a backlog.jp component
  # @todo
  #   * addComponent
  #   * updateComponent
  #   * deleteComponent
  class Component < Container
    # @!attribute [r] id
    #   @return [Fixnum] Component ID
    # @!attribute [r] name
    #   @return [String] Component name
    attributes :id, :name
  end
end

