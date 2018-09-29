class Canvas 
	attr_reader :canvas
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
		@canvas = []
		width = width+2
		heigth = height+2
		for  row in 1..height
			line = []
			if row == 1 or row == height
				for column in 1..width
					line.push(borderCharacterX)
				end
			else
				for column in 1..width
					if column == 1 or column == width
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
	def validatePonit point: []
		return false unless  point.is_a? Array
		if (@canvas.length == 0 or @canvas[0].length == 0 or point.length != 2)
			return false;
		end
		height = @canvas.length() -2
		width = @canvas[0].length() -2
		x = point[0]
		y = point[1]
		if x <= 0 or y <= 0
			return false
		end
		if  (y  > height or x > width)
			return false
		end

		return true
	end
	def drawPoint point: [], character: "x"
		if validatePonit point: point
			x = point[0]
			y = point[1]
			@canvas[y][x] = character
		end 
	end
	def deletePoint point: []
		drawPoint point: point, character: " "
	end
	def isLine? points: []
		return false if points.length != 2
		point1 = points[0]
		point2 = points[1]

		if(validatePonit point: point1 and validatePonit point: point2)
			x1 = point1[0]
			y1 = point1[1]

			x2 = point2[0]
			y2 = point2[1]

			return true if((x1==x2)or (y1==y2))
		end
		return false
	end
	def createLine initialPoint: [], endPoint: []
		if isLine? points:[initialPoint,endPoint]
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
	def drawLine points
		createLine(initialPoint:[points[0].to_i,points[1].to_i], endPoint: [points[2].to_i,points[3].to_i])
	end
end
