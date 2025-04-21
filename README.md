# 2025-04-20-p4 Make the art of where collage legs with 20696 randomly arranged files 
* patch size is 32px x 32px
* Each leg of an Art of Where tights is 3325px x 6358 px (see [Art of Where's Design Guidelines](https://artofwhere.com/info/design-guidelines))
* 3325/32 = 104 patches wide 6358/32 = 199 patches high
* 104 * 199 = 20696
* [leftleg-files.txt](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/leftleg-files.txt)
* [rightleg-files.txt](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/rightleg-files.txt)
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
* [create32px-32px-random-patches.rb](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/create32px-32px-random-patches.rb) is a Ruby script that creates the 32 pixel by 32 pixel patches
  
```bash
mkdir 32X32PATCHES
cd !$
 ../create32px-32px-random-patches.rb ../ORIGINALS/originals.txt 20696 2> stderr.txt &
ls -1 | wc -l
   20661
```  
# 2025-04-20-p1 get a full list of the originals
* Apparently `realpath` is macOS and/or BSD specific :-) oops
```bash
cd ORIGINALS
realpath *.jpg > originals.txt
```
# 2025-04-19-p2 download the originals
* `ORIGINALS` is in `.gitignore` to prevent uploading 3.3GB of files to github :-)

```bash
mkdir ORIGINALS
cd ORIGINALS
../backup-originals.rb ../photoset-72177720324904746-metadata.csv
```

# 2025-04-19-p1 write a script to get a flickr set
* The [backup-photoset-by-id.rb](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/backup-photoset-by-id.rb) Ruby script creates [photoset-72177720324904746-metadata.csv](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/photoset-72177720324904746-metadata.csv)
```bash
./backup-photoset-by-id.rb 72177720324904746
```
