rfc = require('../lib/rfc_calculation')

exports.calculationTest = (test) ->
  name = "Walter"
  paternalLname = "Reyes"
  maternalLname = "Mata"
  birthDate = "1994-02-11"

  result = new rfc(name, paternalLname, maternalLname, birthDate)
  test.equal(result.rfc, "REMW940211KJ6", ["Success"])

  test.done()