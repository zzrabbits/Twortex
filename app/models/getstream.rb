require "rubygems"
require 'tire'

# require your gems as usual
require 'yajl'

class Getstream
	attr_accessor :name

	def inititalizer
		#@name=["china","taiwan"]
		#@name="china"
		#puts @name
	end

	def test_update
		Twitter.update("hello from class")
	end

	def me
		Twitter.update("I'm tweeting !")
	end
	def follow
		Twitter.follow("startupnorth")
	end
	def follower
		Twitter.followers("gem")
	end
	def hello
		puts "hello"
	end


	def collect_stream
		@name_withspace=["justin trudeau","martin cauchon","david bertschi","marc garneau","joyce murray","deborah coyne","george takach","karen mccrimmon"]
		@name_withoutspace=["justintrudeau","martincauchon","davidbertschi","marcgarneau","joycemurray","deborahcoyne","georgetakach","karenmccrimmon"]
		@statuses = []
		TweetStream::Client.new.track(@name_withspace) do |status, client|
  			@statuses << status
  			puts "#{status.text}"
  			puts "#{status.created_at}"
  			puts "#{status.id}"
  			puts "#{status.source}"
  			puts "#{status.user.id}"
  			puts "#{status.user.name}"
  			puts "#{status.user.screen_name}"
  			puts "#{status.user.location}"
 			index=nil
  			content="#{status.text}"
  			for i in 0..@name_withspace.length-1
	  			if content.downcase.include? @name_withspace[i]
	  				Tweetdb.create :created_at=>status.created_at,
	  							   :text=>status.text,
	  							   :id=>status.id,
	  							   :tag=>@name_withspace[i],
	  							   :source=>status.source,
	  							   :user_id=>status.user.id,
	  							   :user_name=>status.user.name,
	  							   :screen_name=>status.user.screen_name,
	  							   :location=>status.user.location
	  			end
	  		end
  			#Crack::JSON.parse()
  			#sample=JSON.parse('{"tag":"This is the contents"}')
  		#	Pol.create({:content => status.text,:name =>@name[index]}) 			
  			client.stop if @statuses.size >= 500
		end
	end

end