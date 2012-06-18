#MovieData.rb

load 'Movie.rb'

load 'User.rb'

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

	def find_movies(hash)

		temp_arr = @movies

		if hash[:year]

			temp_arr = year_search(hash[:year], temp_arr)

		end 

		if hash[:genre]

			temp_arr = genre_search(@genres[hash[:genre]])

		end

		if hash[:title]

			temp_arr = title_search(hash[:title], temp_arr)

		end		

	end

	def find_users(hash)

		temp_arr = @users

		if hash[:sex]

			temp_arr = sex_search(hash[:sex], temp_arr)

		end

		if hash[:occupation]

			temp_arr = occ_search(hash[:occupation], temp_arr)

		end

		if hash[:age]

			temp_arr = age_search(hash[:age], temp_arr)

		end

		if hash[:zip]

			temp_arr = zip_search(hash[:zip], temp_arr)

		end

	end

	def test_movies(genre, year)

		find_movies({genre: genre, year: year})

	end

	def test_users(agerange, sex, n)

		user_arr = find_users({age: agerange, sex: sex})

	end





private



=begin

	File => Hash{:sym => Fixnum}

	This method takes in a file giving the names of genres and populates a hash from symbols of the genre names to their index value

=end

	def load_genres(genre_file)

		genre_file.each_line do |el|

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

		movie_file.each_line do |el|

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



=begin

	String, Array => Array

	This method takes in a String and an Array of Movies, and returns the Array of movies containing those for which the titles 
	contains the given String.

=end

	def title_search(value, arr)

		arr.select {|el| el.title.include?(value)}

	end



=begin

	Fixnum, Array => Array

	This method takes in a Fixnum representing a genre, and an Array of Movies. It returns the Array of Moives containing those
	given genre

=end

	def genre_search(value,arr)

		arr.select {|el| el.genres[value]}

	end



=begin

	Fixnum or Range, Array => Array

	This method takes in an Array of Movie objects and either a Fixnum representing a year or a Range
	representing a range of years and then returns an array of those Movies which match that Fixnum or Range

=end

	def year_search(value, arr)

		if value.class == Fixnum 

			arr.select {|el| value == el.year}

		else

			arr.select {|el| value.include(el.year)}

		end

	end



=begin

	Fixnum or Range, Array => Array

	This method takes in an Array of User objects and either a Fixnum representing the User's age or a Range represeting 
	a range of ages, and then returns an a array of those Users with that age or in that range of ages

=end

	def age_search(value, arr)

		if value.class == Fixnum 

			arr.select {|el| value == el.age}

		else

			arr.select {|el| value.include(el.age)}

		end

	end



=begin

	Symbol or String, Array => Array

	This method takes in a Symbol or String representing occupation, an Array of User objects. It returns those Users
	with the given occupation.

=end

	def occ_search(value, arr)

		if value.class == String

			arr.select {|el| el.occupation == value.to_sym}

		else

			arr.select {|el| el.occupation == value}

		end

	end



=begin

	String and Symbol, Array => Array
	
	This method takes in either a Symbol, or a String denoting sex, and an Array of User objects. It then returns an Array of those
	Users of the given sex.

=end

	def sex_search(value, arr)

		if value.class == String

			arr.select {|el| el.sex == value[0,1].to_sym}

		else

			arr.select {|el| el.sex == value}

		end

	end



=begin

	Fixnum, Array => Array

	This method take in a Fisnum representing a zip code, and an Array of User objects and returns an Array of those User objects
	with that zip code

=end

	def zip_search(value,arr)

		arr.select {|el| el.zip == value}

	end

end

a = Movie.new('ml-100k')
