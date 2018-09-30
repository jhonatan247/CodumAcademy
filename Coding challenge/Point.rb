class Point
	attr_accessor  :x, :y, :value
	def initialize *args
		@x = args[0].to_i
		@y = args[1].to_i
		@value = ' '
		if(args.length > 2)
			@value = args[2]
		end
	end
end