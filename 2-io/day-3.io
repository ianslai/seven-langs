OperatorTable addAssignOperator(":", "atPutNumber")
curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
  r
)

Map atPutNumber := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
    call evalArgAt(1)
  )
)

s := File with("phonebook.txt") openForReading contents

phoneNumbers := doString(s)
phoneNumbers keys   println
phoneNumbers values println

# Number 1: XML with indentation

XmlBuilder := Object clone
XmlBuilder _level := 0
XmlBuilder _indent := method(
  list() setSize(self _level) map(x, "  ") join
)
XmlBuilder forward := method(
  writeln(_indent, "<", call message name, ">")
  _level = _level + 1
  call message arguments foreach(
    arg,
    content := self doMessage(arg);
    if (content type == "Sequence", writeln(_indent, content))
  )
  _level = _level - 1
  writeln(_indent, "</", call message name, ">")
)

XmlBuilder ul(
  li("Io"),
  li("Lua"),
  li("JavaScript")
)

# Number 2: Square brackets

squareBrackets := method(
  call message arguments
)

[1, 2, 3, 4] println

# Number 3: XML with attributes

XmlBuilder forward := method(
  args := call message arguments

  // Curly brackets are handled especially as attributes
  attrs := if (args size > 1 and args at(0) name == "curlyBrackets",
    self doMessage(args at(0)) map(key, value, " " with(key) with("=\"") with(value) with("\"")) join,
    args = args last(args size - 1); ""
  )
  writeln(_indent, "<", call message name, attrs, ">")
  _level = _level + 1
  call message arguments foreach(
    arg,
    content := self doMessage(arg);
    if (content type == "Sequence", writeln(_indent, content))
  )
  _level = _level - 1
  writeln(_indent, "</", call message name, ">")
)

XmlBuilder curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    # Sadly, doMessage doesn't work -- you have to convert it to a string and then back
    r doString(arg asString)
  )
  r
)

XmlBuilder ul(
  { "author": "Tate",
    "subject": "Languages" },
  li("Io"),
  li("Lua"),
  li("JavaScript")
)
