with open("input", encoding="utf-8") as f:
    cards = f.read().splitlines()

total = [1] * len(cards)
for num, card in enumerate(cards):
    winning, mine = card.split(':')[1].split('|')
    winning = set(winning.split())
    mine = set(mine.split())
    matching = len(mine.intersection(winning))
    for i in range(num+1, num+matching+1):
        total[i] += total[num]

print(sum(total))
