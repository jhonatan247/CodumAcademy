load 'Command.rb'
class Format
	attr_accessor :code, :arguments
	def initialize code: "Q", arguments: []
		@code = code
		arguments.each do |argument|
			raise "Format argument exception" unless ( Format.is_argument? argument )
		end
		@arguments = arguments
	end
	def size
		return arguments.length
	end

	def self.to_format format
		formatData =  format.split
		return Format.new(code: formatData[0], arguments: formatData[1..formatData.length-1])
	end

	def self.is_argument? argument
		return (argument == "i" or argument == "c")
	end
	def self.is_valid? argument:'i', value:''
		case argument
		when "i"
			unless value.is_number?
				valid = false
			end
		when "c"
			unless value.to_s.length == 1
				valid = false
			end
		end
	end 
	def is_valid_command? command
		if ( size == command.size and @code == command.code )
			valid = true
			for i in 0..@arguments.length-1
				
			end
			if valid
				return true
			end
		end
		return false
	end
end