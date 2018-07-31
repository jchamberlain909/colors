class PixelsController < ApplicationController
    include ActionController::Live

    def index
        render json: Pixel.all, status: 200
    end

    def show
        pixel = Pixel.find(params[:id])
        render json: pixel, status: 200
    end

    def update
        pixel = Pixel.find(params[:id])
        pixel.update(params.require(:pixel).permit(:color,:user_id))
        SseRailsEngine.send_event('pixel', pixel)
        render json: pixel, status: 200
    end

    def subscribe
        response.headers['Content-Type'] = 'text/event-stream'
        sse = SSE.new(response.stream)
        
        begin
            Pixel.on_change do |pixel|
            sse.write(pixel)
        end
        rescue IOError
            # Client Disconnected
        ensure
            sse.close
        end
        render nothing: true
    end
end
