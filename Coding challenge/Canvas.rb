class Canvas 
	attr_reader :canvas, :borderCharacterX,:borderCharacterY
	def initialize width: 10, height: 10
		create(witdth: witdth, height: height)
	end

	def initialize size: [10,10]
		create(witdth: size[0].to_i, height: size[1].to_i)
	end

	def initialize size
		create(width: size[0].to_i, height: size[1].to_i)
	end

	def create width: 10, height: 10, borderCharacterX: "-", borderCharacterY: "|"
		@borderCharacterX = borderCharacterX
		@borderCharacterY = borderCharacterY
		@canvas = []
		width = (width+2)
		height = (height+2)
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
	def validatePonit point
		return false unless  point.is_a? Array
		if (@canvas.length == 0 or @canvas[0].length == 0 or point.length != 2)
			return false;
		end
		height = @canvas.length() -2
		width = @canvas[0].length() -2
		x = point[0]
		y = point[1]
		if (x <= 0 or y <= 0)
			return false
		end
		if  (y  > height or x > width)
			return false
		end

		return true
	end
	def drawPoint point: [], character: "x"
		if(validatePonit point and character.length == 1)
			x = point[0]
			y = point[1]
			@canvas[y][x] = character
		end 
	end
	def deletePoint point: []
		drawPoint point: point, character: " "
	end
	def isLine? initialPoint: [], endPoint: []
		if(validatePonit initialPoint and validatePonit endPoint)
			x1 = initialPoint[0]
			y1 = initialPoint[1]

			x2 = endPoint[0]
			y2 = endPoint[1]

			return true if((x1==x2)or (y1==y2))
		end
		return false
	end
	def createLine initialPoint: [], endPoint: []
		if isLine? initialPoint:initialPoint, endPoint:endPoint
			x1 = initialPoint[0]
			y1 = initialPoint[1]

			x2 = endPoint[0]
			y2 = endPoint[1]
			if(x1 == x2)
				for i in y1..y2
					drawPoint point:[x1,i]
				end
			else
				for i in x1..x2
					drawPoint point:[i,y1]
				end
			end
			return true
		else
			return false
		end
	end
	def createSquare initialPoint: [], endPoint: []
		if (validatePonit(initialPoint) and validatePonit(endPoint))
			x1 = initialPoint[0]
			y1 = initialPoint[1]

			x2 = endPoint[0]
			y2 = endPoint[1]
			if(isLine? initialPoint:[x1, y1], endPoint:[x2, y1] and isLine? initialPoint: [x1, y2], endPoint:[x2, y2])
				createLine(initialPoint:[x1, y1], endPoint: [x1, y2]) 
				createLine(initialPoint:[x1, y1], endPoint: [x2, y1]) 
				createLine(initialPoint:[x2, y1], endPoint: [x2, y2]) 
				createLine(initialPoint:[x1, y2], endPoint: [x2, y2])
				return true
			end
		end
		return false
	end
	def getValue point
		x = point[0]
		y = point[1]
		return @canvas[y][x]
	end
	def fillArea point:[],  character: " "
		if(validatePonit point and character.length == 1)
			queue = Queue.new
			queue << point
			charCompare = getValue(point)
			return true if charCompare == character
			begin
				currentPoint = queue.pop
				drawPoint point: currentPoint, character: character
				x = currentPoint[0]
				y = currentPoint[1]

				up = [x, y - 1]
				queue << up if getValue(up) == charCompare
					
				down = [x, y + 1]
				queue<< down if getValue(down) == charCompare
					
				left = [x - 1, y]
				queue << left if getValue(left) == charCompare

				right = [x + 1 , y]
				queue << right if getValue(right) == charCompare
			end while queue.length >0
			return true
		end
		return false
	end
	def fill args
		point = [args[0].to_i,args[1].to_i]
		char = ' '
		if(args.length>2)
			char = args[2]
		end
		return fillArea point:point,  character: char
	end
	def drawSquare points
		return createSquare(initialPoint:[points[0].to_i,points[1].to_i], endPoint: [points[2].to_i,points[3].to_i])
	end
	def drawLine points
		return createLine(initialPoint:[points[0].to_i,points[1].to_i], endPoint: [points[2].to_i,points[3].to_i])
	end
end
