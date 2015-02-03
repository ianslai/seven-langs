
1 + 1

# 2

1 + "one"

# Error

# Strongly-typed, it appears:
# -> type is attached to object
# -> cannot coerce types to another

# Both 0 and "" are true:

# 0 and true => true
# "" and true => true

# nil is false.

# slotNames

# = set a new value for a slot, otherwise raises exception
# := sets a new slot or a new value
# ::= additionally can also add a setter
# e.g.
#Io> Vehicle foo ::= "goo"
#==> goo
#Io> Vehicle slotNames
#==> list(foo, type, setFoo)
