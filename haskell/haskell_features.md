# Notes on Haskell features

These aren't meant to be in any particular order, nor is this meant to be any sort of comprehensive cheat-sheet for Haskell. I'm just listing interesting things I find as I go, for future reference.

## Data types

```haskell
-- record syntax
data Car = Car {
	company :: String,
	model :: String,
	year :: Int
} deriving(Show)

-- creating a record
let stang = Car {company = "Ford", model="Mustang", year=1967}

-- `deriving` notation
data Either a b = Left a | Right b
	deriving (Eq, Ord, Read, Show)

-- constraints on type variables
data (Ord k) => Map k v

```


## Defining typeclasses

Definition of the `Eq` typeclass.

```haskell
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x == y = not (x /= y)
    x /= y = not (x == y)

-- list contains function
-- needs each element of the list to satisfy `Eq`
contains :: Eq a => a -> [a] -> Bool

```

Implementing a typeclass `Show` for a datatype `TrafficLight`:

```haskell
instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"
```

## The Functor Typeclass

> a functor is a map between two categories
>
> -Wikipedia

Great. That definition doesn't really help in the context of programming.



```haskell
-- 'f' here is a type constructor, e.g.: []
class Functor f where
	fmap :: (a -> b) -> f a -> f b

-- some functor laws
fmap id = id
fmap (g . h) = (fmap g) . (fmap h)

-- map is fmap which only works on lists
map :: (a->b) -> [a] -> [b]
instance Functor [] where
	fmap = map

-- is this equivalent to `impl Functor for Maybe` in Rust?
instance Functor Maybe where
	-- note: the `f` here isn't the same `f` above ^^
	-- the `f` here is a function f :: a -> b
	fmap f (Just x) = Just (f x)
	fmap f Nothing = Nothing
```


(examples from http://learnyouahaskell.com/making-our-own-types-and-typeclasses)


## Useful functions

`elem` function - infix operator for 'element of' check

```haskell
3 `elem` [1, 4, 7] -- false
```

- `fromIntegral`, `round`

### Functors in Rust

https://varkor.github.io/blog/2018/08/28/feasible-functors-in-rust.html

- couldn't understand this post on my first try, need to read more to understand.

Rust doesn't have higher-kinded types so cannot implement functors currently.

## $ dollar sign in Haskell

The `$` operator is used to change operator precedence, purely a syntactic feature.

```haskell
($) :: (a->b) -> a -> b

infixr 0 $ -- right associativity, lowest precence possible
```

```haskell
sort ("julie" ++ "moronuki")

-- equivalent to

sort $ "julie" ++ "moronuki"
```


```haskell
head . sort $ "hello"

-- or

head $ sort "hello"
```

### Summary of differences between functor, applicative and monad

Functor
- `fmap`

Applicative

- `<*>`
- `pure`

Monad

- `>>=` (bind)
- `return`

Here's an example of Haskell IO without "do"-notation

```haskell
greet = putStr "Hello, "
        >>=
        \_ -> getLine
        >>=
        \name -> (
            putStr "Where are you from? "
            >>=
            \_ -> getLine
            >>=
            \town ->
                let msg = "..."
                in putStrLn msg
        )
```

Also note that the `let` syntax is different inside `do` notation: namely, `in` is not used:

```haskell
name <- getLine
let msg = "Welcome, " ++ name ++ "from " ++ town
putStrLn msg
```

