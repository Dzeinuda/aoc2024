import std/streams
import std/assertions
import std/algorithm
import std/cmdline
import std/sequtils
import std/times
import strutils

var argv: seq[string] = commandLineParams()
var strm = newFileStream(argv[0], fmRead)
var line = ""

var left_list = newSeq[int]()
var right_list = newSeq[int]()

if not isNil(strm):
    while strm.readLine(line):
        var le = line.split({' '})
        left_list.add(parseInt(le[0]))
        right_list.add(parseInt(le[len(le) - 1]))
    strm.close()

left_list.sort()
right_list.sort()

proc calc_total_distance(ll: seq[int], rl: seq[int]): int =
    var total_dist = 0
    var index = 0

    for i in ll.items():
        total_dist += abs(i - rl[index])
        index += 1
    return total_dist

proc calc_similarity_score(ll: seq[int], rl: seq[int]): int =
    var sim_score = 0
    for i in ll.items():
        sim_score += (i * count(rl, i))
    return sim_score

const time = cpuTime()
echo "Total Distance: ", calc_total_distance(left_list, right_list)
echo "Similarity Score: ", calc_similarity_score(left_list, right_list)
echo "Took time: ", (cpuTime() - time) * 1000, " ms"


