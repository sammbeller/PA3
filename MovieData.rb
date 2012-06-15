#MovieData.rb

require 'Movie'

require 'User'

class MovieData

	attr_reader :mratings, :uratings, :movies, :users, :genres

	def initialize(folder_name)

		@mratings = Hash.new

		@uratings = Hash.new

		@genres = Hash.new

		genre_file = File.new(folder_name + '/u.genre', 'r')

		movie_file = File.new(folder_name + '/u.item', 'r')

		user_file = File.new(folder_name + '/u.user', 'r')

		review_file = File.new(folder_name + '/u.item', 'r')

		load_genres(genre_file)

		genre_file.close

		load_movies(movie_file)

		movie_file.close

		load_users(user_file)

		user_file.close

		distribute_reviews(review_file)

		review_file.close

	end

	def find_movies

	end

	def find_users

	end

	def test_movies

	end

	def test_users

	end





private



=begin

	File => Hash{:sym => Fixnum}

	This method takes in a file giving the names of genres and populates a hash from symbols of the genre names to their index value

=end

	def load_genres(genre_file)

		IO.foreach(genre_file) do |el|

			el = el.split("|")

			@genres[el[0].to_sym] = el[1]

		end

	end



=begin

	File => Array[Movie]

	This method takes in a file and, for each line, creates a Movie object 
=end

	def load_movies(movie_file)

		i = 0

		IO.foreach(movie_file) do |el|

			el = el.split("|")

			@movies[i] = Movie.new(el)

			i += 1

		end

	end



=begin

	File => Array[User]

	Thie method takes in a file and, for each line, creates a User object

=end

	def load_users(user_file)

		i = 0

		IO.foreach(user_file) do |el|

			el = el.split("|")

			@users[i] = User.new(el)

			i += 1

	end

end



=begin

	File => Hash[Fixnum => Hash[Fixnum => Fixnum]]
			Hash[Fixnum => Hash[Fixnum => Fixnum]]

		This method takes in a file and then, for each line, adds a key of the movie id to mratings the value of which
		is a hash with key user id and value rating
		It then adds a key of the user id to uratings the value of which is a hash with key movie id and value rating
=end

	def distribute_reviews(review_file)

		IO.foreach(review_file) do |el|

			el = el.split

			@mratings[el[1]] ||= Hash.new

			@mratings[el[1]][el[0]] = el[2]

			@uratings[el[0]] ||= Hash.new

			@uratings[el[0]][el[1]] = el[2]

		end

	end

end


a = MovieData.new("ml-100k")