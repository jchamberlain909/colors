class BoardsController < ApplicationController
    include ActionController::Live

    @@sse
    
    def index
        render json: Board.all, status: 200
    end

    def show
        board = Board.find(params[:id])
        render json: board, status: 200
    end

    def create
        board = Board.create(params.require(:board).permit(:game_type))
        # create pixels
        for x in 0..9 do
            for y in 0..9 do
                Pixel.create(color: 'white', x:x, y:y, board_id:board.id)
            end
        end 
        render json: board, status: 200
    end

    def reset
        board = Board.find(params[:id])
        board.pixels.each do |pixel|
            pixel.color = 'white'
        end 
        render json: board, status: 200
    end

    def destroy
        # Reassign users to canvas board
        board = Board.find(params[:id])
        board.users.each do |user|
            user.board_id = 1
        end 

        Board.destroy(params[:id])
        render json: {}, status: 200
    end


    def subscribe
        response.headers['Content-Type'] = 'text/event-stream'
        sse= SSE.new(response.stream)

        begin
            Pixel.on_change do |pixel|
                split = pixel.split(':')
                puts split.last.chop 
                puts params[:id]
                if split.last.chop == params[:id]
                    puts "send"
                    sse.write(pixel)
                end
                
            end
        rescue IOError
            # Client Disconnected
        ensure
            sse.close
        end
        render nothing: true
    end


    
end
