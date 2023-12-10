import re

max_red = 12
max_green = 13
max_blue = 14

sums = 0
with open("input", encoding="utf-8") as f:
    for line in f.readlines():
        game_id = re.match(r"Game\s*(\d+)", line)
        blues = set(map(int, re.findall(r"(\d+) blue", line)))
        reds = set(map(int, re.findall(r"(\d+) red", line)))
        greens = set(map(int, re.findall(r"(\d+) green", line)))
        if max(blues) > max_blue or max(reds) > max_red or max(greens) > max_green:
            continue
        sums += int(game_id.groups(1)[0])

print(f"The sum of the IDs of all possible games is: {sums}")
