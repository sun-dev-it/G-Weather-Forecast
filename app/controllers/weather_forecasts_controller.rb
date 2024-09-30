class WeatherForecastsController < ApplicationController
    def index
      get_current_location()
      @api_key = 'e6b57eb7e3514d26a34153934243009'
      @city = params[:city] || get_current_location()
      @day = params[:day].present? ? params[:day].to_i : 5
      @weather = get_weather(@api_key, @city, @day)

      if !@weather.present?
        flash[:danger] = "Failed to retrieve weather data for ' #{@city} '"
        redirect_to root_path
      end
    end

    private

    def get_weather(api_key, city, day)
      url = "https://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{city}&days=#{day}"
      
      begin
        response = HTTParty.get(url)
        if response.success?
            @weather_data = response.parsed_response
        end
      rescue StandardError => e
        @weather_data = nil
      end
    end

    def get_current_location()
      client_ip = request.ip
      response = Net::HTTP.get(URI("https://ipinfo.io/#{client_ip}/json"))
      data = JSON.parse(response)
      city = data['city']
      return city
    end
end
