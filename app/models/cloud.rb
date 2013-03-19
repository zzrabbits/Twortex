class Cloud
	attr_accessor :max_size,:array_filter,:hash_filter

	def initialize
		@h=Hash.new
		@max_size=100
		@hash_filter=Hash.new
		@array_filter=["but","was","just","your","what","tweet","here","hi","before","after","about","very","all","now","lt","it","my","be","self","of","in","http","and","you","to","co","not","do","did","https","our","some","from","the","rt","is","are","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","r","w","x","y","z","yourself","me","myself","he","him","her","they","ya","via","on","we","had","have","its","his","she","no","if","en","de","la","them","us","it","itself","our","their","theirs","ours","ourselves","themselves","yours","hers","as","or","in","at","this","that","these","those","has","have","so","with","of","by","for","get","hey","1","2","3","4","5","6","7","8","9","0"]
		@array_filter.each do |item|
			@hash_filter[item.downcase]=1
		end
	end

	def self.get_keywords
		#@keywords=Pol.select("name")
		@keywords = Tire.search('tweets', :query => {"match_all" => {}},:size =>1000000).results
		@hash_keywords=Hash.new
		for item in @keywords
			t=item.tag
			if t!=[]&&!@hash_keywords.has_key?(t)
				@hash_keywords[t]=1
			end
		end
		puts @hash_keywords.keys
		return @hash_keywords.keys
	end
	def query_subkeyword(subkeyword,keyword)
		#tmp_keyword=@keyword
		s = Tire.search 'tweets' do
		#s=Tweetdb.search do
    		query do
    			#@query="tag: #{keyword}"
        		#string @query
        		boolean do
        			must {string "tag: #{keyword}"}
        			must {string "text: #{subkeyword}"}
        		end
      		end


      		size 100000

      		facet 'current-tags' do
        		terms :text,
        		:size=>1000
      		end
      	end

      	@array_keyword=keyword.split(' ')
      	@subkeyword_list=[]
    	s.results.facets['current-tags']['terms'].each_with_index do |f,count|
    			break if count>=@max_size
				if f['term']!=subkeyword and !@hash_filter.has_key?(f['term']) and !@array_keyword.include?f['term']
					@subkeyword_list<<[f['term'],f['count']]	
				end
    	end
    	#@subkeyword_list.sort{|word,count| count}
    	return normalize(@subkeyword_list)

	end

	def query_keyword(tag)
		#@keyword=tag
		s = Tire.search 'tweets' do
		#s=Tweetdb.search do
    		query do
    			@query="tag: #{tag}"
        		string @query
      		end
      		size 100000

      		facet 'current-tags' do
        		terms :text,
        		:size=>1000,
        		:exclude => "justin"
      		end
      	end

      	@array_keyword=tag.split(' ')
      	@subkeyword_list=[]
    	s.results.facets['current-tags']['terms'].each_with_index do |f,count|
    			break if count>=@max_size
				if f['term']!=tag and !@hash_filter.has_key?(f['term']) and !@array_keyword.include?f['term']
					@subkeyword_list<<[f['term'],f['count']]	
				end
     		#puts "#{f['term'].ljust(10)} #{f['count']}"
    	end
    	#@subkeyword_list=@subkeyword_list.shuffle
    	return normalize(@subkeyword_list)

	end

  def normalize(list)
    unit=list[-1][1]
    for item in list
      item[1]/=unit
    end
    return list
  end
end