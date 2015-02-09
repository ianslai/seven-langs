# Number 1

fib := method(num,
  if(num <= 2, 1, fib(num - 1) + fib(num - 2))
)

fib_it := method(num,
  prior := 1
  ret := 1
  while(num > 2,
    new_ret := prior + ret
    prior = ret
    ret = new_ret
    num = num - 1
  )
  ret
)


# Number 2

originalDivide := Number getSlot("/")

Number setSlot("/", method(b,
    if(b == 0, 0, self originalDivide(b))
  )
)

# Number 3

sum_2d_array := method(array, array flatten reduce(+))

sum_2d_array(list(1,list(4,5),3))

# Number 4

List myAverage := method(self flatten reduce(+) / (self size))

#Io> list(1, 2, 3, 4, 5, 6) myAverage
#==> 3.5

#Io> list(1, 2, 3, 4, "a") myAverage
#  Exception: argument 0 to method '+' must be a Number, not a 'Sequence'

# Number 5

TwoDList := Object clone

TwoDList init := method(
  self arr := list()
)

TwoDList dim := method(x, y,
  arr = list()
  for (i, 1, y,
    self arr push(list() setSize(x))
  )
)

TwoDList set := method(x, y, value, self arr at(y) atPut(x, value))
TwoDList get := method(x, y, self arr at(y) at(x))

# Number 6
TwoDList transpose := method(
  y_size := arr size ;
  x_size := arr at(0) size ;
  new_arr := list() ;
  for (i, 1, x_size,
    new_arr push(arr map(at(i - 1)))
  ) ;
  new_arr
)

meh := TwoDList clone

meh dim(2, 3)
meh set(0, 0, 1)
meh set(1, 0, 2)
meh set(0, 1, 3)
meh set(1, 1, 4)
meh set(0, 2, 5)
meh set(1, 2, 6)

meh println
meh transpose println

# Number 7

TwoDList size := method(
  list(arr at(0) size, arr size)
)

TwoDList writeTo := method(file,
  f := File with(file) openForUpdating
  s := self size
  f write(s at(0) asString, ",", s at(1) asString, "\n")
  self arr foreach(sub_arr,
    f write(sub_arr join(","), "\n")
  )
  f close  
)

TwoDList readFrom := method(file,
  f := File with(file) openForReading
  s := f readLine split(",")
  x_size := s at (0) asNumber
  y_size := s at (1) asNumber
  self arr = list()
  for (i, 1, y_size,
    self arr push(f readLine split(","))
  )
  f close
)

meh writeTo("/tmp/meh.matrix")
meh2 := TwoDList clone
meh2 readFrom("/tmp/meh.matrix")
meh2 println

# Number 8

guessingGame := method(low, high,
  num := (Random value * (high - low + 1)) floor + low
  numTries := 10
  stdin := File standardInput
  lastGuess := 0
  firstGuess := true
  while(numTries > 0,
    "Guess a number between " with(low asString, " and ", high asString, ": ") print
    guess := stdin readLine asNumber
    if(guess == num,
      "You guessed it!" println ; return,
      if (firstGuess,
        "That's not it, try again",
        if ((guess - num) abs <= (lastGuess - num) abs,
          "That's not it, but you're hotter",
          "That's not it, you're getting colder"
        )
      ) println
    )
    lastGuess = guess
    firstGuess = false
    numTries = numTries - 1
  )
  "Whoops, ran out of tries!  The correct number was " with(num asString) println
)

guessingGame(1, 100)
