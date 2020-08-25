data Tree a = Node a (Tree a) (Tree a) | Empty
    deriving Show

insert :: Ord a => a -> Tree a -> Tree a
insert x Empty = Node x Empty Empty
insert x (Node a t1 t2)
    | x < a = Node a (insert x t1) t2
    | x == a = Node a t1 t2
    | otherwise = Node a t1 (insert x t2)

-- alternative implementation
-- buildtree :: Ord a => [a] -> Tree a
-- buildtree [] = Empty
-- buildtree (x:xs) = insert x (buildtree xs)

buildtree :: Ord a => [a] -> Tree a
buildtree = foldr insert Empty
-- equivalent to `buildtree xs = foldr insert Empty xs`

elements :: Tree a -> [a]
elements Empty = []
elements (Node a left right) = (elements left) ++ [a] ++ (elements right)

treesort :: (Ord a) => [a] -> [a]
treesort = elements . buildtree
