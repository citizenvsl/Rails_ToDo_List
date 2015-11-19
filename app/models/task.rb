class Task < ActiveRecord::Base
	belongs_to :user
	require 'json'
	def self.ajax_request(city)
		response = Faraday.get 'http://api.openweathermap.org/data/2.5/forecast?q=#{city},us&mode=json&appid=2de143494c0b295cca9337e1e96b00e0' 
	    response_json = JSON.parse(response.body)
	    response_list = response_json['list']
		response_list.select! { |info| info['dt_txt'].include? "12:00"}  # getting info for each day at 12 pm 
		weather_forcast_next_five_days = response_list.collect { |info| info = info['weather'][0]['main'] } 
		weather_forcast_next_five_days.map! {|weather| (weather == "Clear") ? "sunny" : weather}
		weather_forcast_next_five_days.map! {|weather| (weather == "Clouds") ? "cloudy" : weather}
	end

	def self.get_next_five_days
		 Array.new(5) { |number| (Time.now.to_date + number.day).strftime("%A")}
	end
end
