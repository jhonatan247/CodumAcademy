load 'DataTable.rb'

weatherTable = DataTable.new(file: "weather.dat")
puts weatherTable.calculateMinDifference(columnNamePrincipal: 'MxT', columnNameSubstraction: 'MnT', extraColumnNames: ["Dy"], title: "Temperature spread")
