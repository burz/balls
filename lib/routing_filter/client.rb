module RoutingFilter
  class Client < Filter

    def around_recognize(path, env, &block)
      client = nil
      path.sub! %r(^/([a-zA-Z]{3})(?=/|$)) do client = $1; '' end
      yield.tap do |params|
        params[:client] = client || 'web'
      end
    end

    def around_generate(*args, &block)
      client = args.extract_options!.delete(:client) || 'web'
      yield.tap do |result|
        if client != 'web'
          result.sub!(%r(^(http.?://[^/]*)?(.*))){ "#{$1}/#{client}#{$2}" }
        end 
      end
    end
  end
end
