class SsesController < ApplicationController
    include ActionController::Live
    
    def subscribe
        response.headers['Content-Type'] = 'text/event-stream'
        sse = SSE.new(response.stream)
        
        begin
            $redis.subscribe('pixels', 'messages') do |on|
                on.message do |channel, msg|
                    sse.write(msg, event: channel)
                end
            end
        
        rescue IOError
            # Client Disconnected
        ensure
            sse.close
        end
        render nothing: true
    end
    

    def message
        $redis.publish 'messages', {message:params[:message]}.to_json
    end
end