# 2025-04-20-p4 Make the art of where collage legs with 20696 randomly arranged files 
* patch size is 32x32 3325/32 = 104 width 6358/32 = 199 height
* 104 * 199 = 20696
```bash
find 32X32PATCHES -name '*.png' -print | shuf | head -n 20696 > leftleg-files.txt
find 32X32PATCHES -name '*.png' -print | shuf | head -n 20696 > rightleg-files.txt
magick montage @leftleg-files.txt -tile 104x199 -geometry "32x32+0+0" \
vancouver-flowers-2025-32x32-patches-leftleg.png
magick montage @rightleg-files.txt -tile 104x199 -geometry "32x32+0+0" \
vancouver-flowers-2025-32x32-patches-rightleg.png
```
# 2025-04-20-p3 Make 20696-20661 = 35 more patches but let's do 100 more just for fun
```bash
cd 32X32PATCHES
../create32px-32px-random-patches.rb ../ORIGINALS/originals.txt 100 2> one-hundred-more-stderr.txt &
ls -1 | wc -l
   20762
```
# 2025-04-20-p2 Create 32x32 patches 
* 16 x 16 pixel was too abstract :-)
* leggings	3325px x 6358px for one leg
* 3325/32 = 104, 6358/32 = 199
* 104*199 = 20696 patches :-)
  
```bash
mkdir 32X32PATCHES
cd !$
 ../create32px-32px-random-patches.rb ../ORIGINALS/originals.txt 20696 2> stderr.txt &
ls -1 | wc -l
   20661
```  
# 2025-04-20-p1 get a full list of the originals
```bash
cd ORIGINALS
realpath *.jpg > originals.txt
```
# 2025-04-19-p2 download the originals
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
