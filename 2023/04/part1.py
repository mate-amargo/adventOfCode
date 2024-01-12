with open("input", encoding="utf-8") as f:
    cards = f.read().splitlines()

points = 0
for card in cards:
    winning, mine = card.split(':')[1].split('|')
    winning = set(winning.split())
    mine = set(mine.split())
    intersects = len(mine.intersection(winning))
    if intersects > 0:
        points += 2 ** (intersects - 1)

print(points)
