import std/cmdline
import std/re
import strutils

# Part one.
proc cleanData(data: string): seq[string] = 
    return findAll(data, re"mul\(\d{1,3},\d{1,3}\)")

proc evalData(data: seq[string]): int =
    var total: int = 0
    for instruction in data:
        var tmp_eval = newSeq[int]()
        for num in findAll(instruction, re"\d{1,3}"):
            tmp_eval.add(parseInt(num))
        total += (tmp_eval[0] * tmp_eval[1])
    return total

# Part two.
# This idea, did not work, but I'm unsure as to why.
proc removeDont(data: string): string =  
    return replace(
        replace(data, re"don't\(\).*?(?=do\(\))", ""), 
        re"don't\(\).*", "")

# Inspiration from https://www.reddit.com/r/adventofcode/comments/1h5obsr/2024_day_3_regular_expressions_go_brrr/
proc parseData(data: string): seq[string] = 
    let pattern: Regex = re"mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)"
    return findAll(data, pattern)

# Yuck.
proc evalParsedData(data: seq[string]): int = 
    var total: int = 0
    var enabled: bool = true
    for instruction in data:
        if instruction == "do()":
            enabled = true
        elif instruction == "don't()":
            enabled = false
        else:
            if enabled == true:
                var tmp_eval = newSeq[int]()
                for num in findAll(instruction, re"\d{1,3}"):
                    tmp_eval.add(parseInt(num))
                total += (tmp_eval[0] * tmp_eval[1])
    return total



let argv: seq[string] = commandLineParams()
let data = readFile(argv[0])

echo evalData(cleanData(data))
echo evalData(cleanData(removeDont(data)))
echo evalParsedData(parseData(data))
