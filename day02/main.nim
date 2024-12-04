import std/[times, os, cmdline]
import strutils

var buffer = newSeq[int]() 
var argv: seq[string] = commandLineParams()

proc isReportSafe(s: seq[int]): bool = 
    var direction = s[0] - s[1]
    var index = 0
    
    if direction > 0:
        while (index < (len(s)-1)):
            if (s[index] > s[index + 1]) and
            ( abs(s[index] - s[index + 1]) <= 3 ):
                index += 1
            else:
                return false
        return true

    if direction < 0:
        while (index < (len(s)-1)):
            if (s[index] < s[index + 1]) and 
            ( abs(s[index] - s[index + 1]) <= 3 ):
                index += 1
            else:
                return false
        return true

proc withProblemDamper(s: seq[int]): bool =
    
    var index = 0
    var alt = newSeq[int]()
    
    while (index < len(s)):
        alt = s
        alt.delete(index)
        
        if isReportSafe(alt) == true:
            return true

        alt.setLen(0)
        index += 1
    
    return false


var total: int = 0
var total_with_pd: int = 0

let time = cputime()
for line in lines argv[0]:
    for i in line.split({' '}):
        buffer.add(parseInt(i))
    if isReportSafe(buffer) == true: 
        total += 1
    elif withProblemDamper(buffer) == true:
        total_with_pd += 1    
    buffer.setLen(0)

echo "Total safe report without problem damper: ", total
echo "Total safe reports with problem damper: ", (total+total_with_pd)
echo "Time taken: ", (cpuTime() - time) * 1000, "ms"
