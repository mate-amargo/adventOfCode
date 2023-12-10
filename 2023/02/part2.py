import re

sums = 0
with open("input", encoding="utf-8") as f:
    for line in f.readlines():
        blues = max(set(map(int, re.findall(r"(\d+) blue", line))))
        reds = max(set(map(int, re.findall(r"(\d+) red", line))))
        greens = max(set(map(int, re.findall(r"(\d+) green", line))))
        sums += blues * reds * greens

print(f"The sum of the powers of the sets is: {sums}")
