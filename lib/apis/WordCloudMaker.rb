require 'rubygems'
require 'mashape'

class WordCloudMaker
	PUBLIC_DNS = "gatheringpoint-word-cloud-maker.p.mashape.com"

	def initialize(public_key, private_key)
		@authentication_handlers = Array.new
		
		@authentication_handlers << Mashape::MashapeAuthentication.new(public_key, private_key)
	end



	def makeWordCloud(height,textblock,width,config=nil,&callback)
		parameters = {
			"height" => height,"textblock" => textblock,"width" => width,"config" => config
		}
		return Mashape::HttpClient.do_request(:post, "https://" + PUBLIC_DNS + "/index.php", parameters, :form, :json, @authentication_handlers, &callback)
	end


end
