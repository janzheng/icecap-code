#!/bin/bash
./cue export icecream-1.cue -e encoded -o text:icecream-1.csv -f
./cue export icecream-2.cue -e encoded -o text:icecream-2.csv -f
./cue export icecream-3.cue -e encoded -o text:icecream-3.csv -f
./cue export icecream-4.cue -e encoded -o text:icecream-4.csv -f
./cue export icecream-5b.cue -e encoded -o text:icecream-5b.csv -f

cat icecream-5b.csv > icecream-dict.csv && tail -n +3 -q icecream-4.csv icecream-3.csv icecream-2.csv icecream-1.csv >> icecream-dict.csv

curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "token=INSERT_REDCAP_TOKEN&content=metadata&format=csv&type=flat&overwriteBehavior=normal&data=$(cat icecream-dict.csv)" https://redcap.sydney.edu.au/api/
