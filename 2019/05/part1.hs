import Data.List.Split
import Text.Printf

-- Replace the number of list xs at position p with the value n
replaceNth :: [Int] -> Int -> Int -> [Int]
replaceNth xs p n = fst sl ++ n : tail (snd sl)
  where sl = splitAt p xs

decodeOp:: [Int] -> Int -> Int -> Int -> (Int,Int)
decodeOp xs opcode x y = (xo, yo)
  where padedCode = printf "%04d" opcode :: [Char]
        opcodey = read $ take 1 padedCode :: Int
        opcodex = read $ take 1 $ drop 1 padedCode :: Int
        operation = read $ drop 2 padedCode :: Int
        yo = if opcodey == 0 then xs !! y else y
        xo = if opcodex == 0 then xs !! x else x

compute :: [Int] -> Int -> IO [Int]
compute xs p
  | opcode == 1 = operation1
  | opcode == 2 = operation2
  | opcode == 3 = operation3
  | opcode == 4 = operation4
  | opcode == 99 = return xs
  | otherwise = return []
  where opcode = read $ drop 2 (printf "%04d" (xs !! p) :: [Char]) :: Int
        (operand1, operand2) = decodeOp xs (xs !! p) (xs !! (p+1)) (xs !! (p+2))
        resultPosition = xs !! (p+3)
        operation1 = do
                       let xs' = replaceNth xs resultPosition (operand1 + operand2)
                       compute xs' (p+4)
        operation2 = do
                       let xs' = replaceNth xs resultPosition (operand1 * operand2)
                       compute xs' (p+4)
        operation3 = do
                     putStrLn "Insert input value: "
                     input <- getLine
                     let x = read input :: Int
                     let xs' = replaceNth xs (xs !! (p+1)) x
                     compute xs' (p+2)
        operation4 = do
                     putStrLn $ ">>> " ++ show (xs !! (xs !! (p+1)))
                     compute xs (p+2)

main = do
  contents <- readFile "input"
  let program = map read $ splitOn "," $ filter (/= '\n') contents :: [Int]
  compute program 0
