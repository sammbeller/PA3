#User.rb


class User

	attr_reader :occupation, :sex, :age, :zip


	def initialize(user_array)

		@age = user_array[1].to_i

		@sex = user_array[2].to_sym

		@occupation = user_array[3].to_sym

		@zip = user_array[4]

	end

end