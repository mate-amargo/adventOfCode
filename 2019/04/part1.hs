import qualified Data.Set as Set

-- input : 146810-612564
range = [146810..612564]

digits :: Int -> [Int]
digits 0 = []
digits x = digits (x `div` 10) ++ [x `rem` 10]

nonDecreasingDigits :: Int -> Bool
nonDecreasingDigits x = foldl (&&) True $ zipWith (>=) (digits x) (0 : digits x)

-- If we first filter the decreasing numbers out, then there's no need to check for adjacent double digits
-- since all repeating digits must be adjacent.
hasDoubleDigits :: Int -> Bool
hasDoubleDigits x = (length $ Set.toList $ Set.fromList $ digits x) < (length $ digits x)

passwords = filter (hasDoubleDigits) $ filter (nonDecreasingDigits) range

main = do
  putStrLn $ "There are " ++ (show $ length passwords) ++ " different passwords"
