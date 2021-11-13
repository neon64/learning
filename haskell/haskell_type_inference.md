# Haskell Type Inference

*(from video by Harald Sondergard, University of Melbourne)*

GHC uses unification for type inference.

How do we reconcile what we learned about unification for propositional / predicate logic, and Haskell's type inference system?

- "terms" are now type expressions in Haskell. Just using a different syntax

```haskell
x -> y -- a function symbol would normally write f(x, y)

constants:
Bool, Char -- could use b, c as names for such constants


-- type expression - function symbol is just the list constructor
[x]
-- equivalent to
MyList x
-- or mylist(x)


-- bin(x)
data BinTree x = Void | Node x (BinTree x) (BinTree x)


-- first argument is a function
-- returns a function from lists [x], to lists [y]
map :: (x -> y) -> ([x] -> [y])
map :: (x -> y) -> [x] -> [y]


null :: [z] -> Bool
```

How does Haskell now reason about expressions which involve `map` and `null` etc... e.g.: consider the following expression:

```haskell
map null "hello"
```

Analysis follows:

```haskell
-- first argument should have type: x -> y
-- applying map to `null`, null :: [z] -> Bool


-- expects [x],
-- we apply it to [Char]

-- get two equations:
-- x -> y = [z] -> Bool
-- [x] = [Char]

-- generates:
-- x = [z]
-- y = Bool
-- x = Char

-- then substitute
-- [z] = Char

-- ERROR: unification failure - Char is a constant, [] is a function symbol, we cannot unify the expression

map null ["hi", "there"] -- is well typed

-- x = [z]
-- y = Bool
-- [x] = [[Char]]

-- x = [Char]
-- [z] = [Char]
-- z = Char
-- y = Bool

-- output: [Bool] is the resultant type.

```





Haskell's type system: **[Hindley-Milner type system](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system)**
- everybody liked it, but it wasn't for many years until it was introduced that even just printing out type expressions is exponential time complexity with respect to the size of the input program.
- but it is very useful



## Example

Consider the following Haskell program:

```haskell
p x y z = z x y
a x = p x x
b = a . a
c = b . b
d = c . c
```

- `:t b` - reasonably complicated type expression
- `:t c` - more complicated
- `:t d ` - even more complicated type expression, takes forever to print out



Point is - no programmer would ever write programs which as are complicated as the above ^, from a type resolution standpoint.