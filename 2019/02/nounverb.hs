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

createProgram :: [Int] -> Int -> Int -> [Int]
createProgram xs noun verb = head xs : [noun,verb] ++ drop 3 xs

main = do
  contents <- readFile "input"
  let input = map read $ splitOn "," $ filter (/= '\n') contents :: [Int]
  -- Find the noun (value at position 1) and the verb (value at position 2)
  -- that produces the output 19690720
  let programs = [(program,noun*100+verb) | noun <- [0..99], verb <- [0..99], program <- compute (createProgram input noun verb) 0]
  putStrLn $ "The value 100*noun+verb that produces the output 19690720 is: " ++ show (snd $ head $ filter (\x -> fst x == 19690720) programs)
