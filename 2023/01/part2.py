spelled = {
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
}


def translate(string: str) -> str:
    """
    takes a string and replaces the spelled numbers with digits
    Caveat: to avoid removing potential matches with overlaping letters
    we keep the first and last letters of the spelled number too,
    for example:
    "eightwothree" -> "e8t2ot3e"
    without that trick, we would get "eigh23"
    """
    for k, v in spelled.items():
        string = string.replace(k, k[0] + v + k[-1])
    return string


sums = 0
with open("input", encoding="utf-8") as f:
    for line in f.readlines():
        digits = list(filter(lambda x: x.isdigit(), translate(line.strip())))
        sums += int(digits[0] + digits[-1])

print(f"The sums of all calibration values is: {sums}")
