load 'Command.rb'
class Format
	attr_accessor :code, :arguments
	def initialize code: "Q", arguments: []
		@code = code.upcase
		@arguments=[]
		arguments.each do |argument|
			argument = argument.upcase.swapcase
			raise "Format argument exception" unless ( Format.is_argument? argument )
			@arguments.push(argument)
		end
	end
	def size
		return @arguments.length
	end

	def self.to_format format
		formatData =  format.split
		return Format.new(code: formatData[0], arguments: formatData[1..formatData.length-1])
	end

	def self.is_argument? argument
		return (argument == "i" or argument == "c")
	end
	def self.is_i? value
		if !/\A\d+\z/.match(value)
			return false
		else
			return true
		end 
	end
	def self.is_valid? argument:'i', value:''
		case argument
		when "i"
			if Format.is_i? value
				return true
			end
		when "c"
			if value.to_s.length == 1
				return true
			end
		end
		return false
	end 
	def is_valid_command? command
		if ( size == command.size and @code == command.code )
			for i in 0..@arguments.length-1
				return false unless (Format.is_valid? argument: @arguments[i], value: command.arguments[i])
			end
			return true
		end
		return false
	end
end