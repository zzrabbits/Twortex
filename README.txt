There are three models in this rail application.
	
cloud.rb This is used to generate the visual cloud, query keywords and sub-keywords. array_filter[]is a filter used to filter popular words.
		
getstream.rb This is to collect the twitter stream into our database
		
Tweetdb.rb This class creates the tweet object that we stored in our database
		
Before running the rails program, you should get elastic search running on your server:type \bin\elasticsearch in the command line

Then you go to http://localhost:3000/tweets


