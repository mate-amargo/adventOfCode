import Data.List.Split

-- Replace the number of list xs at position p with the value n
replaceNth :: [Int] -> Int -> Int -> [Int]
replaceNth xs p n = fst sl ++ n : tail (snd sl)
  where sl = splitAt p xs

compute :: [Int] -> Int -> [Int]
compute xs p
  | xs !! p == 1 = compute operation1 (p+4)
  | xs !! p == 2 = compute operation2 (p+4)
  | xs !! p == 99 = xs
  | otherwise = []
  where operand1 = xs !! (p+1)
        operand2 = xs !! (p+2)
        resultPosition = xs !! (p+3)
        operation1 = replaceNth xs resultPosition ((xs !! operand1) + (xs !! operand2))
        operation2 = replaceNth xs resultPosition ((xs !! operand1) * (xs !! operand2))

main = do
  contents <- readFile "input"
  let brokenProgram = map read $ splitOn "," $ filter (/= '\n') contents :: [Int]
  -- Fix the program: Replace position 1 with the value 12 and replace position 2 with the value 2
  let program = head brokenProgram : [12,2] ++ drop 3 brokenProgram
  putStrLn $ "The value left at position 0 is: " ++ show (head $ compute program 0)
