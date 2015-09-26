module Rack
  module R3
    METHODS = {
      get: ::R3::Method::GET,
      post: ::R3::Method::POST,
      put: ::R3::Method::PUT,
      delete: ::R3::Method::DELETE,
      patch: ::R3::Method::PATCH,
      head: ::R3::Method::HEAD,
      options: ::R3::Method::OPTIONS,
    }

    def self.included(base)
      base.class_eval do
        @@routes = []

        def self.routes
          @@routes
        end

        METHODS.each do |sym, int|
          self.define_singleton_method(sym) do |path, &block|
            @@routes.push({method: int, path: path, block: block})
          end
        end
      end
    end

    def initialize
      routes = self.class.routes
      @tree = ::R3::Tree.new(routes.length)
      routes.each do |route|
        @tree.insert_route(route[:method], route[:path], route[:block])
      end
      @tree.compile
    end

    def call(env)
      @env = env
      method = METHODS[env['REQUEST_METHOD'].downcase.to_sym]
      match = @tree.match(method, env['PATH_INFO'])
      block = match[:data]
      return instance_exec(*match[:params], &block) if block
      not_found(env)
    end

    def not_found(env)
      [404,
       {'content-type' => 'text/plain; charset=utf-8'},
       ["Not Found"]
      ];
    end
  end
end
