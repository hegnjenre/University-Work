import GHC.IO.Handle (hClose)

-- c == correct
-- c/2 == half correct
-- s == needed solution

-- 1
myLast:: [a] -> a -- c
myLast (x:[]) = x
myLast (x:xs) = myLast xs

-- 2
myButtLast:: [a] -> a -- c
myButtLast (x:[]) = x
myButtLast (x:y:[]) = x
myButtLast (x:y:zs) = myButtLast (y:zs)

-- 3
elementat:: [a] -> Int -> a -- c
elementat (x:_) 1 = x
elementat (_:xs) c = elementat xs (c-1)
elementat _ _ = error "Index out of bounds"

-- 4
myLength:: [a] -> Int -- c
myLength [] = 0
myLength [x] = 1
myLength (x:xs) = 1 + myLength xs

-- 5
myRev:: [a] -> [a] -- c
myRev [] = []
myRev [x] = [x]
myRev (x:xs) = myRev xs ++ [x]

-- 6
isPalindrome:: (Eq a) => [a] -> Bool -- c
isPalindrome str | myRev str == str  = True
                 | otherwise         = False


-- 7
data NestedList a = Elem a | List [NestedList a]

flatten:: NestedList a -> [a] -- s
flatten (Elem x) = [x]
flatten (List xs) = foldr ((++) . flatten) [] xs

-- 8
compress::(Eq a) => [a] -> [a] -- c
compress [] = []
compress (x:xs) | x `elem` xs && head xs == x = compress xs
                | otherwise                   = x : compress xs

compress2::(Eq a) => [a] -> [a] -- other solution
compress2 xs = compress_acc xs []
        where compress_acc [] acc = acc
              compress_acc [x] acc = acc ++ [x]
              compress_acc (x:xs) acc | x == head xs = compress_acc xs acc
                                      | otherwise = compress_acc xs (acc ++ [x])

-- 9
pack::(Eq a) => [a] -> [a] -- s
pack [] = []
pack [x] = [x]
pack (x:xs) | x == head xs  = x : pack xs
            | otherwise     = x : head xs : pack xs
            
myPack :: Eq a => [a] -> [[a]] -- solution
myPack [] = []             
myPack (y:ys) = impl ys [[y]]
    where
        impl [] packed = packed
        impl (x:xs) packed | x == (head (last packed)) = impl xs ((init packed) ++ [x:(last packed)])
                           | otherwise                 = impl xs (packed ++ [[x]])

-- 10, 11, 12, 13 skipped because not in module

-- 14 
dupli::(Eq a) => [a] -> [a] -- c
dupli [] = []
dupli [x] = [x] ++ [x]
dupli (x:xs) = [x] ++ [x] ++ dupli xs

-- 15
repli::(Eq a) => [a] -> Int -> [a] -- s
repli [] _ = []
repli (x:xs) c = foldr (const (x:)) (repli xs c) [1..c]

-- 16, 17, 18, 19 not in module

-- 20
removeAt:: [a] -> Int -> [a] -- c/2
removeAt xs 0 = xs
removeAt [] _ = []
removeAt [x] 1 = []
removeAt [x] _ = [x]
removeAt (x:xs) 1 = xs
removeAt (x:xs) c = x : removeAt xs (c-1)

-- 21
insertAt:: a -> [a] -> Int -> [a] -- c
insertAt _ [] _ = []
insertAt z [x] 0 = z : [x] 
insertAt z [x] 1 = z : [x]
insertAt z [x] 2 = x : [z]
insertAt z [x] c = error "index out of bounds"
insertAt z (x:xs) 0 = z : x : xs
insertAt z (x:xs) 1 = z : x : xs
insertAt z (x:xs) c = x : insertAt z xs (c-1) 

-- 22
range:: Int -> Int -> [Int] -- c
range _ 0 = []
--range y x = [y .. x]
range y x | y /= x    = y : range (y+1) x
          | otherwise = [y]

-- 23 24 25 uses random and i can't be bothered learning how to use it

-- 26
comb:: Int -> [a] -> [[a]] -- s
comb 0 _ = []
comb _ [] = []
--comb c [x] = [[x]]
comb c (x:xs) = map (x:) (comb (c-1) xs) ++ comb c xs

-- 27 skipped

-- 28
--lsort:: [[a]] -> [[a]] -- s
--lsort [] = []
--lsort [x] = [x]
--lsort xs = fmap (\x acc -> lsort x ++ head acc) [] xs

--29 30 don't exist?

-- 31
primeHelper:: Int -> Int -> Int --c
primeHelper c 0 = 1
primeHelper c 1 = 1
primeHelper c n | c `mod` n == 0 = 0
                | otherwise      = primeHelper c (n-1)

isPrime:: Int -> Bool
isPrime 0 = True
isPrime x | primeHelper x (x-1) == 0  = False
          | otherwise             = True

-- 32 - 38 skip because idk euclid's algorthim

-- 39
primesR:: Int -> Int -> [Int] -- c
primesR _ 0 = []
primesR x y | x == y               = []
            | x /= y && isPrime x  = x : primesR (x+1) y 
            | otherwise            = primesR (x+1) y

-- 40
goldHelp:: Int -> Int -> Int -> (Int, Int)
goldHelp 2 x y = (1, 1)
goldHelp n x y | (x + y == n) && (isPrime x && isPrime y)  = (x, y)
               | x == n                                    = goldHelp n 0 (y+1)
               | y == n                                    = (0, 0)
               | otherwise                                 = goldHelp n (x+1) y

goldbach:: Int -> (Int, Int) -- c
goldbach 0 = (0, 0)
goldbach x | even x && goldHelp x 0 1 /= (0, 0)  = goldHelp x 0 1
           | odd x                               = error "Goldbach's conjecture only works on even numbers"
           | otherwise                           = error "Goldbach's conjecture proven false??????????????"

-- 41
goldbachList:: Int -> Int -> [(Int, Int)] -- c
goldbachList _ 0 = []
goldbachList l u | even l && l <= u  = goldbach l : goldbachList (l+1) u
                 | odd l            = goldbachList (l+1) u
                 | otherwise        = []

myflip:: [a] -> [a]
myflip [] = []
myflip xs = foldr (\x acc -> acc ++ [x]) [] xs

-- 42 - 45 missing again?
-- 46

not':: Bool -> Bool
not' False = True
not' True = False

and':: Bool -> Bool -> Bool
and' False True = False
and' True False = False
and' False False = False
and' _ _ = True

or':: Bool -> Bool -> Bool
or' _ True = True
or' True _ = True
or' _ _ = False

nand':: Bool -> Bool -> Bool
nand' True True = False
nand' _ _ = True

nor':: Bool -> Bool -> Bool
nor' True True = False
nor' False True = False
nor' True False = False
nor' False False = True

xor':: Bool -> Bool -> Bool
xor' True False = True
xor' False True = True
xor' _ _ = False

impl':: Bool -> Bool -> Bool
impl' True False = False
impl' _ _ = True

-- c ?
-- skipping to binary trees as this is not in class scope

-- 54
data Tree a = Empty | Branch a (Tree a) (Tree a)
              deriving (Show, Eq)
leaf x = Branch x Empty Empty

-- 55 s

-- 56
symmetric:: Tree a -> Bool -- c
symmetric Empty = True
symmetric (Branch _ Empty Empty) = True
symmetric (Branch _ lt Empty) = False
symmetric (Branch _ Empty rt) = False
symmetric (Branch _ lt rt) = symmetric lt && symmetric rt

-- skip to 60s
-- 61
tree4 = Branch 1 (Branch 2 Empty (Branch 4 Empty Empty))
                 (Branch 2 Empty Empty)

countLeaves:: Tree a -> Int
countLeaves Empty = 0
countLeaves (Branch _ Empty Empty) = 1
countLeaves (Branch _ lt rt) = countLeaves lt + countLeaves rt

-- 61A
leaves:: Tree a -> [a]
leaves Empty = []
leaves (Branch x Empty Empty) = [x]
leaves (Branch _ lt rt) = leaves lt ++ leaves rt

-- 62
internals:: Tree a -> [a]
internals Empty = []
internals (Branch _ Empty Empty) = []
internals (Branch x lt rt) = x : internals lt ++ internals rt

-- 62B
atLevel:: Tree a -> Int -> [a]
atLevel Empty _ = []
atLevel (Branch x Empty Empty) 1 = [x]
atLevel (Branch x Empty Empty) c = []
atLevel (Branch x lt rt) 1 = [x]
atLevel (Branch x lt rt) c = atLevel lt (c-1) ++ atLevel rt (c-1)

-- 63
comBtree:: Int -> Tree Char
comBtree 0 = Branch 'x' Empty Empty
comBtree h = Branch 'x' (comBtree (h-1)) (comBtree (h-1))

-- skip up to 70, end because rest is not in scope (: