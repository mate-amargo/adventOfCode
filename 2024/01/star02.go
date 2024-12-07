package main

import (
	"bufio"
	"os"
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
	var left_count = make(map[int]int)
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), "   ")
		lval, err := strconv.Atoi(line[0])
		panic_on_err(err)
		left = append(left, lval)
		_, exists_lval := left_count[lval]
		if !exists_lval {
			left_count[lval] = 0
		}
		rval, err := strconv.Atoi(line[1])
		panic_on_err(err)
		_, exists_rval := left_count[rval]
		if exists_rval {
			left_count[rval] += 1
		} else {
			left_count[rval] = 1
		}
	}
	panic_on_err(scanner.Err())
	similarity := 0
	for _, x := range left {
		similarity += (x * left_count[x])
	}
	return similarity
}

func main() {
	result := solve()
	println("Result:", result)
}
