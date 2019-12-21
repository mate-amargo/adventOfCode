fuel :: (Integral a) => a -> a
fuel m
  | mass <= 0 = 0
  | otherwise = mass + fuel mass
  where mass = m `div` 3 - 2

main = do
  contents <- readFile "input"
  let masses = map read $ lines contents :: [Int]
  putStrLn $ "The sum of the fuel requirements is: " ++ show (foldl (\acc x -> acc + fuel x) 0 masses)
