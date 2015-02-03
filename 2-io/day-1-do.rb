message := "Hello world"
MyThing := Object clone
thing1 := MyThing clone
thing2 := MyThing clone

MyThing leftHand := "sinister"
MyThing rightHand := "dexter"
MyThing showHands := method((leftHand println) (rightHand println))

thing1 showHands
thing2 showHands
