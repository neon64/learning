
fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

main :: IO ()
main = do
    putStrLn ("Hello" ++ " " ++ "world!")
    putStrLn ("Hello World " ++ show (fib 10))


