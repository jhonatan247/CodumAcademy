load 'Command.rb'
load 'UserInputFormat.rb'
load 'Canvas.rb'
class DrawingTool
	attr_accessor :canvas
	def initialize
		formats = ["C i i", "L i i i i c", "L i i i i", "R i i i i c", "R i i i i", "B i i c", "B i i", "Q"]
		@userInput = UserInputFormat.new formatList: formats, inputMessage: "Enter command: " 
		@canvas = nil
		@error = false
	end
	def start
		while true
			command = @userInput.read
			if command.code == "Q"
				break
			else
				execute(command)
			end
			print_screen
		end
	end
	def print_error
		puts "the command entered is incorrect"
	end
	def clear_screen
		Gem.win_platform? ? (system "cls") : (system "clear")
	end
	def print_screen
		clear_screen
		if validate_canvas
			@canvas.print
		end
		if @error
			print_error
			@error = false
		end
	end
	def execute command
		if command.code == "C"
			@canvas = Canvas.new command.arguments
			return
		end
		unless validate_canvas
			@error = true
			return
		end

		case command.code
		when "L"
			unless canvas.draw_line command.arguments
				@error = true
			end
		when "R"
			unless canvas.draw_square command.arguments
				@error = true
			end
		when "B"
			unless canvas.fill command.arguments
				@error = true
			end
		end

	end
	def validate_canvas
		return @canvas != nil
	end
end