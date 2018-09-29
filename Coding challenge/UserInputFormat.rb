load 'Format.rb'
class UserInputFormat
	attr_accessor :formatList, :inputMessage, :errorMessage
	def initialize formatList: []
		createFormats(formatList)
	end
	def initialize formatList: [], inputMessage: "Insert text format", errorMessage: "the format entered is incorrect" 
		createFormats(formatList)
		@inputMessage = inputMessage
		@errorMessage = errorMessage
	end
	def createFormats formatList
		@formatList = []
		formatList.each do |format|
			@formatList.push(Format.to_format(format))
		end

	end
	def add_format format
		@formatList.push(Format.to_format(format))
	end

	def is_valid? command
		@formatList.each do |format|
			if(format.is_valid_command? command )
				return true
			end
		end
		return false
	end
	def read
		while true
			print(self.inputMessage)
			input = gets.chomp.strip
			if(input.length>0)
				command = Command.to_command(input)
				if is_valid? command
					return command
				end
			end
			puts(@errorMessage)
		end
	end
end