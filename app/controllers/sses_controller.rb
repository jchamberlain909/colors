class SsesController < ApplicationController
    include ActionController::Live
    
    def subscribe
        response.headers['Content-Type'] = 'text/event-stream'
        response.headers['Cache-Control'] = 'no-cache'
        response.headers['X-Accel-Buffering'] = 'no'


        sse = SSE.new(response.stream)

        sse.write("Connected")
        
        begin
            $redis.subscribe('pixels', 'messages') do |on|
                on.message do |channel, msg|
                    sse.write(msg)
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
        Thread.new do
            $redis.publish 'messages', {message:params[:message]}.to_json
        end
        
        render render json: {message:params[:message]}.to_json, status: 200
    end
end