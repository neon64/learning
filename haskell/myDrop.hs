myDrop :: Int -> [a] -> [a]
myDrop n xs
    | n <= 0 || null xs = xs
    | otherwise = myDrop (n - 1) (tail xs)

lastButOne xs = head ( tail (reverse xs) )
