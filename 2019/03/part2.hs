import Data.List.Split
import qualified Data.Set as Set

data Direction = L | R | U | D deriving Eq
type Section = (Direction, Int)
type Wire = [Section]

type Coord = (Int, Int)

string2Wire :: [String] -> Wire
string2Wire [] = []
string2Wire (x:xs)
  | dir == 'L' = (L, num) : string2Wire xs
  | dir == 'R' = (R, num) : string2Wire xs
  | dir == 'U' = (U, num) : string2Wire xs
  | dir == 'D' = (D, num) : string2Wire xs
  where dir = x !! 0
        num = read $ tail x

getCoords :: Wire -> [Coord]
getCoords [] = []
getCoords (coord:wire) = (x,y) : getCoords wire
  where x = case fst coord of L -> (-1) * snd coord
                              R -> snd coord
                              _ -> 0
        y = case fst coord of D -> (-1) * snd coord
                              U -> snd coord
                              _ -> 0

generatePath :: [Coord] -> [Coord]
generatePath [] = []
generatePath (x1y1:coords) = (x1, y1) : (map (\(x,y) -> (x+x1,y+y1)) $ generatePath coords)
  where x1 = fst x1y1
        y1 = snd x1y1

connect :: Coord -> Coord -> [Coord]
connect (x1,y1) (x2,y2)
  | x1 == x2 = [(x1,y) | y <- if y2-1 >= y1 then [y1..y2-1] else [y1,y1-1..y2+1]]
  | y1 == y2 = [(x,y1) | x <- if x2-1 >= x1 then [x1..x2-1] else [x1,x1-1..x2+1]]

connectCoords :: [Coord] -> [Coord]
connectCoords [] = []
connectCoords (x1y1:[]) = [x1y1]
connectCoords (x1y1:coords) = connect (x1,y1) (x2,y2) ++ connectCoords coords
  where x1 = fst x1y1
        y1 = snd x1y1
        x2 = fst $ head coords
        y2 = snd $ head coords

getIntersections :: [Coord] -> [Coord] -> [Coord]
getIntersections _ [] = []
getIntersections [] _ = []
getIntersections path1 path2 = tail $ Set.toList $ Set.intersection set1 set2
  where set1 = Set.fromList path1
        set2 = Set.fromList path2

cut :: [Coord] -> Coord -> [Coord]
cut xs intersection = takeWhile (\(x,y) -> (x,y) /= intersection) xs ++ [intersection]

calculate :: [Coord] -> Int
calculate (x1y1:[]) = 0
calculate (x1y1:coords)
  | x1 == x2 = calculate coords + abs (y1 - y2)
  | y1 == y2 = calculate coords + abs (x1 - x2)
  where x1 = fst x1y1
        y1 = snd x1y1
        x2 = fst $ head coords
        y2 = snd $ head coords

main = do
  contents <- readFile "input"
  let wire1 = string2Wire $ splitOn "," $ head $ lines contents
  let wire2 = string2Wire $ splitOn "," $ last $ lines contents
  let path1 = connectCoords $ generatePath $ (0,0) : getCoords wire1
  let path2 = connectCoords $ generatePath $ (0,0) : getCoords wire2
  let intersections = getIntersections path1 path2
  let cut1 = map (cut path1) intersections
  let cut2 = map (cut path2) intersections
  let steps1 = map calculate cut1
  let steps2 = map calculate cut2
  let steps = minimum $ zipWith (+) steps1 steps2
  putStrLn $ "The fewest combined steps the wires must take to reach an intersection is: " ++ show steps
