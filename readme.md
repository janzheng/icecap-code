
## Compiling + Uploading Data Dictionaries

Give upload.sh execute permissions `chmod +x upload.sh`,
then run `./upload.sh` or do the following:



1. Compiles each CSV from Cue files
2. Combines CSVs into `icecream-dict.csv`
3. Pushes the data dictionary to server — make sure you have backups! This will overwrite everything.

```
./cue export icecream-1.cue -e encoded -o text:icecream-1.csv -f
./cue export icecream-2.cue -e encoded -o text:icecream-2.csv -f
./cue export icecream-3.cue -e encoded -o text:icecream-3.csv -f
./cue export icecream-4.cue -e encoded -o text:icecream-4.csv -f
./cue export icecream-5b.cue -e encoded -o text:icecream-5b.csv -f

cat icecream-5b.csv > icecream-dict.csv && tail -n +3 -q icecream-4.csv icecream-3.csv icecream-2.csv icecream-1.csv >> icecream-dict.csv

curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "token=INSERT_REDCAP_TOKEN&content=metadata&format=csv&type=flat&overwriteBehavior=normal&data=$(cat icecream-dict.csv)" https://redcap.sydney.edu.au/api/
```

### Exporting Data Dictionary:
```
curl -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: application/json" -X POST --data "token=INSERT_REDCAP_TOKEN&content=metadata&format=csv&returnFormat=csv" https://redcap.sydney.edu.au/api/ -o icecream-dict-backup.csv
```



## Running in to problems

- This code is written on a very old version of cue (0.4.0) and has to be run on it: https://github.com/cue-lang/cue/releases?q=0.4.0&expanded=true
- Field ID is missing (e.g. icecream_id) — REDCap tracks field ids and that might be messed up; use the official uploader to fix it and then you can go back to uploading via API