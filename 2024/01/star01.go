package main

import (
	"bufio"
	"os"
	"sort"
	"strconv"
	"strings"
)

func panic_on_err(e error) {
	if e != nil {
		panic(e)
	}
}

func abs(x int) int {
	if x >= 0 {
		return x
	}
	return -x
}

func solve() int {
	file, err := os.Open("input")
	panic_on_err(err)
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var left []int
	var right []int
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), "   ")
		lval, err := strconv.Atoi(line[0])
		panic_on_err(err)
		rval, err := strconv.Atoi(line[1])
		panic_on_err(err)
		left = append(left, int(lval))
		right = append(right, int(rval))
	}
	panic_on_err(scanner.Err())
	sort.Ints(left)
	sort.Ints(right)
	distance := 0
	for i := 0; i < len(left); i++ {
		distance += abs(left[i] - right[i])
	}
	return distance
}

func main() {
	result := solve()
	println("Result:", result)
}
