
boggleText := "ABCDABAZAOGGAAEL"

WordTrail := Object clone

WordTrail init := method(
  self trail := list()
)

WordTrail with := method(crumb,
  newTrail := self clone
  newTrail trail := trail clone
  newTrail trail append(crumb)
  newTrail
)

WordTrail contains := method(crumb,
  self trail contains(crumb)
)

WordTrail asString := method(
  "Trail: " with(self trail map(coord,
      "(" with(coord at(0) asString, ", ",
               coord at(1) asString, ")")
    ) join(" -> ")
  )
)

BoggleBoard := Object clone

BoggleBoard init := method(
  self board := ""
  self size := 0
)

BoggleBoard setText := method(boardText,
  self board = boardText
  size = self board size sqrt floor
  if(size * size != self board size, Exception raise("Board must be square"))
)

BoggleBoard at := method(x, y,
  self board at(x + y * (self size))
)

BoggleBoard neighbors := method(x, y,
  list(
    list(x - 1, y),
    list(x + 1, y),
    list(x, y - 1),
    list(x, y + 1)
  ) select(x, self isInBoard(x))
)

BoggleBoard isInBoard := method(coords,
  x := coords at(0)
  y := coords at(1)
  x >= 0 and y >= 0 and x < (self size) and y < (self size)
)

BoggleBoard find := method(word,
  solutions := list()
  for (x, 0, self size - 1,
    for (y, 0, self size - 1,
      answers := self findHelper(x, y, word, WordTrail clone)
      solutions append(answers)
    )
  )
  solutions flatten select (trail, trail isNil not)
)

BoggleBoard findHelper := method(x, y, word, trail,
  if (word size == 0, return trail)
  if (word at(0) != self at(x, y), return nil)

  newWord := word exSlice(1, word size)
  newTrail := trail with(list(x, y))

  coordsToExplore := self neighbors(x, y) select (neighbor,
    newTrail contains(neighbor) not
  )
  coordsToExplore map(coord,
    self findHelper(coord at(0), coord at(1), newWord, newTrail)
  ) select (trail, trail isNil not)
)

BoggleBoard asString := method(
  lines := list()
  for (x, 0, self size - 1,
    lines append(self board exSlice(x * size, x * size + size))
  )
  lines join("\n")
)

myBoard := BoggleBoard clone
myBoard setText(boggleText)

myBoard println
myBoard find("BOGGLE") println
