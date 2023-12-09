sums = 0
with open("input", encoding="utf-8") as f:
    for line in f.readlines():
        digits = list(filter(lambda x: x.isdigit(), line.strip()))
        sums += int(digits[0] + digits[-1])

print(f"The sum of all calibration values is: {sums}")
