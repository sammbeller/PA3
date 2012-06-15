#User.rb


class User

	attr_reader :occupation, :sex, :age, :zip


	def initialize(user_array)

		@age = user_array[1].to_i

		@sex = user_array[2]

		@occupation = user_array[3]

		@zip = user_array[4]

	end

end


	a = User.new("6|42|M|executive|98101".split("|"))

	puts a.age

	puts a.sex

	puts a.occupation

	puts a.zip