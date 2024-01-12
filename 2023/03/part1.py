with open("input", encoding="utf-8") as f:
    engine = f.read().splitlines()

numbers = set()
rows = len(engine)
cols = len(engine[0])
for r, row in enumerate(engine):
    for c, char in enumerate(row):
        if char in '0123456789.':
            continue
        # scan 3x3
        for m in range(max(0, r-1), min(rows, r+2)):
            for n in range(max(0, c-1), min(cols, c+2)):
                if not engine[m][n].isdigit():
                    continue
                # find begining of number
                while n > 0 and engine[m][n-1].isdigit():
                    n -= 1
                numbers.add((m, n))

suma = 0
for i, j in numbers:
    num = ""
    for k in range(j, cols):
        if not engine[i][k].isdigit():
            break
        num += engine[i][k]
    suma += int(num)

print(suma)
