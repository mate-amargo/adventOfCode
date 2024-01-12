def find_number(line : str, col : int) -> int:
    num = ""
    for k in range(col, len(line)):
        if not line[k].isdigit():
            break
        num += line[k]
    return int(num)

with open("input", encoding="utf-8") as f:
    engine = f.read().splitlines()

suma = 0
rows = len(engine)
cols = len(engine[0])
for r, row in enumerate(engine):
    for c, char in enumerate(row):
        if char != '*':
            continue
        # scan 3x3
        numbers_coords = set(); numbers = []
        for m in range(max(0, r-1), min(rows, r+2)):
            for n in range(max(0, c-1), min(cols, c+2)):
                if not engine[m][n].isdigit():
                    continue
                # find begining of number
                while n > 0 and engine[m][n-1].isdigit():
                    n -= 1
                if (m,n) not in numbers_coords:
                    numbers.append(find_number(engine[m], n))
                numbers_coords.add((m,n))
        if len(numbers) == 2:
            suma += numbers[0]*numbers[1]

print(suma)
