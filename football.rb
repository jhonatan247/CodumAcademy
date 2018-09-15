load 'DataTable.rb'

weatherTable = DataTable.new(file: "football.dat", ignoreColumnIndex: true, dataAlign: "left")
puts weatherTable.calculateMinDifference(columnNamePrincipal: 'F', columnNameSubstraction: 'A', extraColumnNames: ["Team"])