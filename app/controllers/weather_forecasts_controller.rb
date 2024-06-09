class WeatherForecastsController < ApplicationController
    def index
        @city = params[:city] || 'Ho Chi Minh'
        @weather = get_weather(@city)
        if @weather.present?
          # Các câu lệnh xử lý dữ liệu thời tiết ở đây
        else
          flash[:danger] = "Failed to retrieve weather data for '#{@city}'"
          redirect_to root_path
        end
    end

    private

    def get_weather(city)
      api_key = '4434526b73164a9097693313240506'
      @day = params[:day].present? ? params[:day].to_i : 5
      url = "https://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{city}&days=#{@day}"

      @left = params[:left].present? ? params[:left].to_i : 1
      @right = params[:right].present? ? params[:right].to_i : 4

      begin
        response = HTTParty.get(url)
        if response.success?
            @weather_data = response.parsed_response
        end
      rescue StandardError => e
        @weather_data = nil
      end

    end

    def get_current_location
      location = Geocoder.search(request.remote_ip).first
      return location.city
    end
end
