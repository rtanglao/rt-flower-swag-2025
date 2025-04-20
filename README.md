# 2025-04-19-p1 download the originals

* `ORIGINALS` is in `.gitignore` to prevent uploading 3.3GB to github :-)

```bash
mkdir ORIGINALS
cd ORIGINALS
../backup-originals.rb ../photoset-72177720324904746-metadata.csv
```

# 2025-04-19-p1 write a script to get a flickr set

```bash
# The following creates photoset-72177720324904746-metadata.csv
./backup-photoset-by-id.rb 72177720324904746
```
