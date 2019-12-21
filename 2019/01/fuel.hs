fuel :: (Integral a) => a -> a
fuel m = m `div` 3 - 2

main = do
  contents <- readFile "input"
  let masses = map read $ lines contents :: [Int]
  putStrLn $ "The sum of the fuel requirements is: " ++ show (foldl (\acc x -> acc + fuel x) 0 masses)
