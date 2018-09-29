class Command
	attr_accessor :code, :arguments
	def initialize code:"Q", arguments:[]
		@arguments=[]
		@code = code.upcase
		arguments.each do |arg|
			@arguments.push(arg)
		end
	end
	def size
		return @arguments.length
	end
	def self.to_command command
		commandData = command.split
		return Command.new(code:commandData[0], arguments: commandData[1..commandData.length-1])
	end
end