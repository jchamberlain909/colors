class SsesController < ApplicationController
    include ActionController::Live
    
    def subscribe
        puts 'subscribe'
        response.headers['Content-Type'] = 'text/event-stream'
        response.headers['Cache-Control'] = 'no-cache'
        response.headers['X-Accel-Buffering'] = 'no'


        sse = SSE.new(response.stream)

        sse.write("Connected", event:"connected")
        
        begin
            redis = Redis.new.subscribe('pixels', 'messages') do |on|
                on.message do |channel, msg|
                    sse.write(msg, event:channel)
                end
            end
        
        rescue IOError
            # Client Disconnected
            redis.unsubscribe('pixels', 'messages')
            sse.close
        ensure
            redis.unsubscribe('pixels', 'messages')
            sse.close
        end
        render nothing: true
    end
    

    def message
    
        Redis.new.publish 'messages', {message:params[:message],username:params[:username],time: DateTime.now.strftime("%I:%M")}.to_json
        
        
        render json: {message:params[:message]}.to_json, status: 200
    end
end