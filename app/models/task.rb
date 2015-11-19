class Task < ActiveRecord::Base
	belongs_to :user
	
	require 'json'
	def self.ajax_request

	response = Faraday.get 'http://api.openweathermap.org/data/2.5/forecast?q=London,us&mode=json&appid=2de143494c0b295cca9337e1e96b00e0' 
    response_json = JSON.parse(response.body)
    response_list = response_json['list']
    response_list[16]['dt_txt']
    response_list[1]['dt_txt'].to_date == response_list[2]['dt_txt'].to_date

    	response_list.select! { |info| info['dt_txt'].include? "12:00"}  # getting info for each day at 12 pm 
    	weather_forcast_five_days = response_list.collect { |info| info = info['weather'][0]['main'] } 
    	binding.pry
    	# response_list.each_with_index do |response, index|
    	# 	date = response['dt_txt'].to_date
    	# 	a <<

    	# response_list[1]['weather'][0]['main']

	




		#  conn = Faraday.new(:url => 'http://api.openweathermap.org') do |faraday|
		#   faraday.request  :url_encoded             # form-encode POST params
		#   faraday.response :logger                  # log requests to STDOUT
		#   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	 # 	 end

		# ## GET ##

		# response = conn.get '/data/2.5/forecast?q=London,us&mode=json&appid=2de143494c0b295cca9337e1e96b00e0'  
		#    # GET http://sushi.com/nigiri/sake.json
		# response.body
		# binding.pry

		# conn.get '/nigiri', { :name => 'Maguro' }   # GET http://sushi.com/nigiri?name=Maguro

		# conn.get do |req|                           # GET http://sushi.com/search?page=2&limit=100
		#   req.url '/search', :page => 2
		#   req.params['limit'] = 100
		# end
	end
end
