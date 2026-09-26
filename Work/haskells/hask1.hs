mux :: Bool -> Bool -> Bool -> Bool
--mux c x y = (not c && x) || (c && y)
mux False x y = x
mux True x y = y

modHelp :: Int -> Int -> Int
modHelp x 1 = 1
modHelp x y | mod x y > 0 = modHelp x (y-1)
                | otherwise = 0

prime :: Int -> Bool
prime 1 = True
prime n | modHelp n (n-1) > 0 = True
            | otherwise = False

issq :: Int -> Bool --is square
issq n | mod n n == 0  = True
            | otherwise = False