class Canvas 
	attr_reader :canvas
	def initialize width: 10, height: 10
		create(witdth: witdth, height: height)
	end

	def initialize size: [10,10]
		create(size[0], size[1])
	end

	def create width: 10, height: 10, borderCharacterX: "-", borderCharacterY: "|"
		@canvas = []
		for  row in 1..height
			line = []
			width = width+2
			heigth = height+2
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
		if @canvas.length == 0 or @canvas[0].length = 0 or point.lenght < 2
			return false;
		end
		height = @canvas.length -2
		width = @canvas[0].lenght -2
		x = point[0]
		y = point[1]
		if x <= 0 or y <= 0
			return false
		end
		if  y  > height or x > width
			return false
		end

		return true
	end
	def drawPoitn point: [], character: "x"
		if validatePoint(point)
			x = point[0]
			y = point[1]
			@canvas[y][x] = character
		end 
	end
	def deletePoint point: []
		drawPoitn point: point, character: " "
	end
	def isInCanvas? point: []
		size = canvas.length-1
		if(point[0]<size and point[1]<size and point[0]>0 and point[1]>0)
			return true
		end
		return false;
	end
	def isPoint? point
		if(point1.length==2 and isInCanvas? point)
	end
	def isLine? points: []
		return false if points.length != 2
		point1 = ponits[0]
		point2 = points[1]

		if(isPoint? point1 and isPoint? point2)
			x1 = point1[0]
			y1 = point1[1]

			x2 = point2[0]
			y2 = point2[1]

			return true if((x1==x2)or (y1==y2))
		end
		return false
	end
	def drawLine initialPoint: [], endPoint: []
		if isLine? points:[initialPoint,endPoint]
			x1 = initialPoint[0]
			y1 = initialPoint[1]

			x2 = endPoint[0]
			y2 = endPoint[1]
			if(x1 == x2)
				for i in y1..y2
					drawPoitn point:[x1,i]
				end
			else
				for i in x1..x2
					drawPoitn point:[i,y1]
				end
			end
			return true
		else
			return false
		end
	end
	def drawLine points
		drawLine(initialPoint:points[0..1], endPoint: points[2..3])
	end
end
