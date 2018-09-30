load 'Point.rb'
class Canvas 
	attr_reader :canvas, :borderCharacterX,:borderCharacterY, :width, :height
	def initialize width: 10, height: 10
		create(witdth: witdth, height: height)
	end

	def initialize size: [10,10]
		create(witdth: size[0], height: size[1])
	end

	def initialize size
		create(width: size[0], height: size[1])
	end

	def create width: 10, height: 10, borderCharacterX: "-", borderCharacterY: "|"
		width = width.to_i
		height = height.to_i

		@width = width
		@height = height
		@borderCharacterX = borderCharacterX
		@borderCharacterY = borderCharacterY
		@canvas = []

		width = width+2
		height = height+2
		for  row in 1..height
			line = []
			if (row == 1 or row == height)
				for column in 1..width
					line.push(borderCharacterX)
				end
			else
				for column in 1..width
					if (column == 1 or column == width)
						line.push(borderCharacterY)
					else
						line.push(" ")
					end
				end
			end
			@canvas.push(line)
		end
	end

	def print
		@canvas.each do |row|
			puts row.join
		end
	end
	def validate_point point
		return false unless  point.is_a? Point

		return false if (@height <= 0 or  @width <= 0)

		return false if (point.x <= 0 or point.y <= 0)

		return false if (point.y  > @height or point.x > @width)

		return false unless point.value.length == 1

		return true
	end
	def draw_point point
		if validate_point point
			@canvas[point.y][point.x] = point.value
		end 
	end
	def is_line? initialPoint, endPoint
		if (validate_point initialPoint and validate_point endPoint)
			return true if (initialPoint.x == endPoint.x) or (initialPoint.y == endPoint.y)
		end
		return false
	end
	def create_line initialPoint, endPoint, value
		if is_line? initialPoint, endPoint
			if( initialPoint.x == endPoint.x)
				for i in initialPoint.y..endPoint.y
					draw_point Point.new(initialPoint.x , i, value)
				end
			else
				for i in initialPoint.x..endPoint.x
					draw_point Point.new(i, initialPoint.y, value)
				end
			end
			return true
		else
			return false
		end
	end
	def is_square? initialPoint, endPoint
		return true if (validate_point initialPoint and validate_point endPoint)
		return false
	end
	def create_square initialPoint, endPoint, value
		if is_square? initialPoint, endPoint
			xIni = initialPoint.x
			yIni = initialPoint.y
			xEnd = endPoint.x
			yEnd = endPoint.y

			create_line initialPoint, Point.new(xIni,yEnd), value
			create_line initialPoint, Point.new(xEnd, yIni), value
			create_line Point.new(xEnd, yIni), endPoint, value 
			create_line Point.new(xIni, yEnd), endPoint, value
			return true
		end
		return false
	end
	def get_value point
		return @canvas[point.y][point.x] if validate_point point
		return nil
	end
	def fill_area point
		if validate_point point
			queue = Queue.new
			queue << point
			initValue = get_value(point)

			return true if initValue == point.value

			value = point.value
			begin
				currentPoint = queue.pop
				draw_point currentPoint
				x = currentPoint.x
				y = currentPoint.y

				pointUp = Point.new(x, y - 1, value)
				queue << pointUp if get_value(pointUp) == initValue
					
				pointDown = Point.new(x, y + 1, value)
				queue<< pointDown if get_value(pointDown) == initValue
					
				pointLeft = Point.new(x - 1, y, value)
				queue << pointLeft if get_value(pointLeft) == initValue

				pointRight = Point.new(x + 1 , y, value)
				queue << pointRight if get_value(pointRight) == initValue

			end while queue.length >0
			return true
		end
		return false
	end
	def fill args
		value = ' '
		value = args[2] if(args.length > 2)
		return fill_area Point.new(args[0] ,args[1], value)
	end
	def draw_square args
		value = 'x'
		value = args[4] if(args.length > 4)
		return create_square Point.new(args[0] ,args[1]), Point.new(args[2] ,args[3]), value
	end
	def draw_line args
		value = 'x'
		value = args[4] if(args.length > 4)
		return create_line Point.new(args[0] ,args[1]), Point.new(args[2] ,args[3]), value
	end
end
