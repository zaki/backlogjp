# encoding: utf-8

module Backlogjp
  class Base
    URI_FORMAT = "https://%s.backlog.jp/XML-RPC"

    def initialize(space, user, pass)
      if space.empty? || user.empty? || pass.empty?
        raise ArgumentException("Provide a valid space, user and password")
      end

      @base_uri = URI.parse( URI_FORMAT % space )

      @client   = XMLRPC::Client.new(@base_uri.host, @base_uri.path, @base_uri.port,
                                     nil, nil,              # proxy
                                     user, pass,
                                     true,                  # SSL
                                     nil                    # timeout
                                    )
    end

    def _command(method, *args)
      @client.call(:"backlog.#{method}", *args)
    end
  end

  class Container
    def self.attributes *attributes
      instance_variable_set :@attributes, attributes
      attr_reader(*attributes)
    end

    def initialize(hash)
      attributes = self.class.instance_variable_get(:@attributes)

      attributes.each do |var|
        instance_variable_set(:"@#{var}", hash[var.to_s] || hash[var.to_sym])
      end
    end

    def to_s
      attributes = self.class.instance_variable_get(:@attributes)
      attribute_map = attributes.map do |attribute|
        value = instance_variable_get(:"@#{attribute}").inspect

        "#{attribute}=#{value}"
      end

      "#<#{self.class} #{attribute_map.join(', ')}>"
    end
  end
end

