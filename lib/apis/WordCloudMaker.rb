require 'rubygems'
require 'mashape'

class WordCloudMaker
	PUBLIC_DNS = "gatheringpoint-word-cloud-maker.p.mashape.com"

	def initialize
		@authentication_handlers = Array.new
		@authentication_handlers << Mashape::MashapeAuthentication.new("xdychn3yvjk2ywk9ux8ks2x3xsv3fw", "itof6mgqqqvietyy5apdva4ugdsxdf")
	end

	def makeWordCloud(height, textblock, width, config=nil, &callback)
		parameters = {
			"height" => height,"textblock" => textblock,"width" => width,"config" => config
		}
		return Mashape::HttpClient.do_request(:post, "https://" + PUBLIC_DNS + "/index.php", parameters, :form, :json, @authentication_handlers, &callback)
	end


end
