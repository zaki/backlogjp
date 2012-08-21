module Backlogjp
  # Represents a backlog.jp User
  #
  # @todo
  #   * getUserIcon
  class User < Container
    # @!attribute [r] id
    #   @return [Integer] User ID
    # @!attribute [r] name
    #   @return [String] User name
    # @!attribute [r] lang
    #   @return [String] Interface language
    # @!attribute [r] updated_on
    #   @return [DateTime] Last update time
    attributes :id, :name, :lang, :updated_on

    def initialize(hash)
      super(hash)

      @updated_on = DateTime.parse(@updated_on) if @updated_on
    end


    # Returns the user matching the id
    # @return [User] The user matching the requested id or `nil` if no users match
    # @example
    #   Backlogjp::User.find_by_id "test-user"
    #   # >> User
    def self.find_by_id(id)
      user = Backlogjp.base._command("getUser", id)

      User.new(user) if user
    rescue XMLRPC::FaultException
      # the remote API raises if the user could not be found
      # swallow this exception and return nil instead
      nil
    end

  end
end

