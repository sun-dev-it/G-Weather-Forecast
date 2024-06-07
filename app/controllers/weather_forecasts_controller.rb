class WeatherForecastsController < ApplicationController
    def index
        @city = params[:city] || 'Ho Chi Minh'
        @weather = get_weather(@city)
        if @weather.present?
          # Các câu lệnh xử lý dữ liệu thời tiết ở đây
        else
          flash.now[:error] = "Failed to retrieve weather data for #{@city}"
          render :index
        end
    end

    private

    def get_weather(city)
        api_key = '4434526b73164a9097693313240506'
        url = "https://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{city}&days=5"
        response = HTTParty.get(url)

        if response.success?
            @weather_data = response.parsed_response
        end
    end

    def get_current_location
      location = Geocoder.search(request.remote_ip).first
      return location.city
    end
end
