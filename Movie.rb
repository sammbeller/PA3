#Movie.rb

class Movie

	attr_reader :title, :year, :genres


	def initialize(movie_array)

		@title = movie_array[1]

		@year = movie_array[2].split("-")[2]

		load_genres(movie_array[5 .. -1])

	end



=begin

	Array => Array
=end

	def load_genres(tag_arr)

		@genres = Array.new(tag_arr.size)

		tag_arr.each_with_index do |el ,i|

				@genres[i] = true if el == 1

				@genres[i] ||= false #might not be necessary

			end

	end


	def to_s

		@title

	end

end