class PixelsController < ApplicationController

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

        
        $redis.publish 'pixels', {color:pixel.color, x: pixel.x, y:pixel.y}.to_json
        
        

        render json: pixel, status: 200
    end

    
end
