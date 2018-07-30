class Pixel < ApplicationRecord
    belongs_to :user, optional: true
    after_update :notify_pixel_changed

    class << self
        def on_change
        Pixel.connection.execute "LISTEN pixels"
        loop do
        Pixel.connection.raw_connection.wait_for_notify do |event, pid, pixel|
            yield pixel
        end
        end
        ensure
            Pixel.connection.execute "UNLISTEN pixels"
        end
    end

    def basic_info_json
        JSON.generate({color: color,x: x, y: y })
    end


    private

    def notify_pixel_changed
        Pixel.connection.execute "NOTIFY pixels, '#{self.basic_info_json}'"
    end
end
