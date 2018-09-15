class DataTable
	attr_accessor :tableRows, :tableColumns, :header
	def initialize(file: "input.data", ignoreColumnIndex: false, dataAlign: "right")
		@tableRows = []
		@tableColumns = []
		@header = []
		readTable(file: file, ignoreColumnIndex: ignoreColumnIndex, dataAlign:dataAlign)
	end
	def validateLine(line)
		if(line.delete(' ') == "")
			return false
		elsif(line[0] == '-')
			return false
		else
			return true
		end
	end
	def isNil(value)
		if value == ' '
			return true
		elsif value == '-'
			return true
		else
			return false
		end
	end
	def readTable(file: "input.data", ignoreColumnIndex: false, dataAlign: "right")
		@tableRows = []
		@tableColumns = []
		File.open(file, 'r') do |myFile|
			headerLine = myFile.gets()
			header = headerLine.split()
			#indice dentro de cada linea, del espacio en donde se alinean los datos con el header
			headerIndex = []
			header.each do |s|
				if dataAlign=="right"
					headerIndex.push(headerLine.index(s) +s.length - 1)
				elsif dataAlign=="left"
					headerIndex.push(headerLine.index(s))
				end
			end
			while line = myFile.gets()
				if validateLine(line)
					lectura = line.split()

					data = []
					j = 0
					if ignoreColumnIndex
						j = 1
					end
					headerIndex.each do |indx|
						if isNil(line[indx])
							data.push("null")
						else
							data.push(lectura[j])
							j+=1
						end
					end
					@header = header
					@tableRows.push(data)
				end
			end
		end
	end
	def convertToColumnTable()
		@tableColumns =  @tableRows.transpose
	end
	def validateColumn(columnName: 'col1')
		indx =  @header.index(columnName)
		if indx.to_i < 0
			return false 
		end
		return true
	end
	def validateTable()
		if @tableRows.length == 0
			return false
		elsif @tableColumns.length == 0
			convertToColumnTable()
		end
		return true
	end
	def getColumns(*columnNames)
		columns = []
		columnNames.each do |column|
			if validateColumn(columnName: column)
				indx = @header.index(column)
				completeColumn = [column]
				completeColumn = completeColumn + @tableColumns[indx.to_i]
				columns.push(completeColumn)
			end
		end
		return columns
	end
	def calculateDifference(columnNamePrincipal: 'col1', columnNameSubstraction: 'col2', title: 'Difference', extraColumnNames: [])
		unless ( validateTable() and 
			validateColumn(columnName: columnNamePrincipal) and 
			validateColumn(columnName: columnNameSubstraction) )
			return []
		end
		indxColumnPrincipal =  @header.index(columnNamePrincipal)
		columnPrincipal = tableColumns[indxColumnPrincipal]
		indxcolumnSubstraction =  @header.index(columnNameSubstraction)
		columnSubstraction = tableColumns[indxcolumnSubstraction]

		returnTable = []

		extraColumns = getColumns(extraColumnNames)
		returnTable = returnTable + extraColumns

		diff = [title]

		for i in 0..(@tableRows.length-1)
			diff.push(columnPrincipal[i].to_f-columnSubstraction[i].to_f)
		end
		returnTable.push(diff)

		return returnTable

	end
	def calculateMin(table: [])
		if table.length == 0
			return []
		end
		if table[0].length == 0
			return []
		end

		minVal = table[table.length() -1][1].to_i + 1
		min = []
		for i in 1..(table[0].length-1)
			if minVal > table[table.length() -1][i].to_f
				minVal = table[table.length() -1][i].to_f
				min = []
				for j in 0..(table.length-1)
					min.push([table[j].to_a[0], table[j].to_a[i]])
				end
			end
		end
		return min
	end
	def calculateMinDifference(columnNamePrincipal: 'col1', columnNameSubstraction: 'col2', title: 'Difference', extraColumnNames: [])
		differenceTable = calculateDifference(columnNamePrincipal: columnNamePrincipal, columnNameSubstraction: columnNameSubstraction, title: title, extraColumnNames: extraColumnNames)
		return calculateMin(table: differenceTable)
	end
end