class RfcCalculation

  ARTICLES = ["DEL", "LAS", "DE", "LA", "Y", "A", "MC", "LOS", "VON", "VAN", "MAC", "MI"]

  COMMON_NAMES = ["JOSE", "J.", "J", "MARIA", "MA", "MA."]

  VOCALS = ["A", "E", "I", "O", "U"]

  constructor: (name, paternalLname, maternalLname, birthDate) ->
    @name = name
    @paternalLname = paternalLname
    @maternalLname = maternalLname
    @birthDate = birthDate
    @rfc = ""

    @_toUpperCase()
    @_removeBlankSpacesForNameAndLastName()
    @paternalLname = @_removeArticlesFrom(@paternalLname)
    @maternalLname = @_removeArticlesFrom(@maternalLname)

    @rfc = @paternalLname[0]

    for i in [0..@paternalLname.length]
      if @_isVocal(@paternalLname[i])
        @rfc += @paternalLname[i]
        break

    @rfc += @maternalLname[0] unless @maternalLname is ''

    @rfc += @_ignoresCommonName()

    @rfc += @_ignoresSecondCommonName() if @maternalLname is ''

    @rfc += @_calculateDate()

    @_calculateHomoClave()


  _calculateDate: =>
    date = @birthDate.split("-") # 1995-03-13
    year = date[0].substring(2,4)
    month = date[1]
    day = date[2]

    "#{year}#{month}#{day}"

  _toUpperCase: =>
    @name = @name.toUpperCase()
    @paternalLname = @paternalLname.toUpperCase()
    @maternalLname = @maternalLname.toUpperCase()

  _removeBlankSpacesForNameAndLastName: =>
    @name = @name.trim()
    @paternalLname = @paternalLname.trim()
    @maternalLname = @maternalLname.trim()

  _removeArticlesFrom: (aString) ->
    sanitizedString = ""
    splittedString = aString.split(" ")
    validStrings = []

    for string in splittedString
      unless string in ARTICLES
        validStrings.push(string)

    return validStrings.join(" ").trim()

  _isVocal: (char) ->
    char in VOCALS

  _ignoresCommonName: =>
    names = @name.split(" ")

    #multiple names
    return names[1][0] if names.length > 1 and names[0] in COMMON_NAMES

    #single name
    return @name[0]

  _ignoresSecondCommonName: =>
    names = @name.split(" ")

    #multiple names
    return names[1][1] if names.length > 1 and names[0] in COMMON_NAMES

    #single name
    return @name[1]

  _calculateHomoClave: =>
    nameInNumber = ""
    sumValue = 0

    RFC1 = {
      "&": "10"
      "Ñ": "10"
      "A": "11"
      "B": "12"
      "C": "13"
      "D": "14"
      "E": "15"
      "F": "16"
      "G": "17"
      "H": "18"
      "I": "19"
      "J": "21"
      "K": "22"
      "L": "23"
      "M": "24"
      "N": "25"
      "O": "26"
      "P": "27"
      "Q": "28"
      "R": "29"
      "S": "32"
      "T": "33"
      "U": "34"
      "V": "35"
      "W": "36"
      "X": "37"
      "Y": "38"
      "Z": "39"
      "0": "0"
      "1": "1"
      "2": "2"
      "3": "3"
      "4": "4"
      "5": "5"
      "6": "6"
      "7": "7"
      "8": "8"
      "9": "9"
    }

    RFC2 = {
      "0": "1"
      "1": "2"
      "2": "3"
      "3": "4"
      "4": "5"
      "5": "6"
      "6": "7"
      "7": "8"
      "8": "9"
      "9": "A"
      "10": "B"
      "11": "C"
      "12": "D"
      "13": "E"
      "14": "F"
      "15": "G"
      "16": "H"
      "17": "I"
      "18": "J"
      "19": "K"
      "20": "L"
      "21": "M"
      "22": "N"
      "23": "P"
      "24": "Q"
      "25": "R"
      "26": "S"
      "27": "T"
      "28": "U"
      "29": "V"
      "30": "W"
      "31": "X"
      "32": "Y"
    }

    RFC3 = {
      "A": "10"
      "B": "11"
      "C": "12"
      "D": "13"
      "E": "14"
      "F": "15"
      "G": "16"
      "H": "17"
      "I": "18"
      "J": "19"
      "K": "20"
      "L": "21"
      "M": "22"
      "N": "23"
      "O": "25"
      "P": "26"
      "Q": "27"
      "R": "28"
      "S": "29"
      "T": "30"
      "U": "31"
      "V": "32"
      "W": "33"
      "X": "34"
      "Y": "35"
      "Z": "36"
      "0": "0"
      "1": "1"
      "2": "2"
      "3": "3"
      "4": "4"
      "5": "5"
      "6": "6"
      "7": "7"
      "8": "8"
      "9": "9"
      "": "24"
      " ": "37"
    }

    #we add a zero to the name number representation
    nameInNumber += "0"

    fullName = "#{@paternalLname} #{@maternalLname} #{@name}"

    #//Recorremos el nombre y vamos convirtiendo las letras en
    #//su valor numérico
    i = 0
    while i < fullName.length
      nameInNumber += (RFC1[fullName[i]] || "00")
      i++

    #//Calculamos la suma de la secuencia de números
    #//calculados anteriormente
    #//la formula es:
    #//( (el caracter actual multiplicado por diez)
    #//mas el valor del caracter siguiente )
    #//(y lo anterior multiplicado por el valor del caracter siguiente)
    i = 0
    while i < nameInNumber.length - 1
      currentValue = parseInt(nameInNumber[i])
      nextValue = parseInt(nameInNumber[i + 1])

      sumValue += ((currentValue * 10) + nextValue) * nextValue

      i++

    div = 0
    mod = 0

    div = parseInt(sumValue % 1000)
    mod = div % 34
    div = (div - mod) / 34

    index = 0

    hc = ""

    while index <= 1
      key = if index is 0 then "#{div}" else "#{mod}"
      hc += (RFC2[key] || "Z")

      index++

    @rfc += hc

    rfcToSum = 0
    partialSum = 0

    for i in [0..@rfc.length]
      if RFC3.hasOwnProperty("#{@rfc[i]}")
        rfcToSum = parseInt(RFC3["#{@rfc[i]}"])
        partialSum += (rfcToSum * (14 - (i + 1)))

    verifierModule = partialSum % 11
    if verifierModule is 0
      @rfc += "0"
    else
      partialSum = 11 - verifierModule

    if partialSum is 10
      @rfc += "A"
    else
      @rfc += partialSum

  module.exports = RfcCalculation