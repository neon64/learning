-- generating pythagorean triples,
-- e.g.: (3,4 ,5)

pyth :: [(Integer,Integer,Integer)]
pyth = [(a, b, c) | c <- [1..], a <- [1..c], b <- [1..c], a^2 + b^2 == c^2 ]

pyth2 :: [(Integer,Integer,Integer)]
pyth2 = concat [[(b,a,c), (a,b,c)] | (a) <- [1..], b <- [1..a], Just c <- [getC a b]]

getC :: Integer -> Integer -> Maybe Integer
getC a b
    | isInt c = Just (round c)
    | otherwise = Nothing
    where c = sqrt (fromInteger (a^2+b^2))

isInt :: Float -> Bool
isInt a = a == fromInteger (round a)
