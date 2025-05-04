# 2025-05-03-p4 Make go Make Custom Back of tshirt with 64 by 64 pixel patches

```bash
find 64X64PATCHES -name '*.png' -print | shuf | head -n 2679 > back-go-custom-files.txt
magick montage @back-go-custom-files.txt -tile 47x57 -geometry "64x64+0+0" \
vancouver-flowers-2025-64x64-patches-go-custom-back.png
```
# 2025-05-03-p3 Go Make Custom back of tshirt using 64 pixel by 64 pixel patches 
* 10 inch by 12 inch at 300 dots per inch  = 3000 pixels by 3600 pixels
* 3000 pixels / 64 pixels = approximately 47 patches wide
* 3600 pixels / 64 pixels = approximately 57 patches height
* 47 * 57 = 2679 patches but we'll make 2800 just for fun
* add 64X64PATCHES to .gitignore and turn  off spotlight indexing in macOS
```bash
mkdir 64X64PATCHES
cd !$
 ../create64px-64px-random-patches.rb ../ORIGINALS/originals.txt 2800 2> stderr.txt &
```

# 2025-05-03-p2 Make go Make Custom Front of tshirt with 128 by 128 pixel patches

```bash
find 128X128PATCHES -name '*.png' -print | shuf | head -n 696 > front-go-custom-files.txt
magick montage @front-go-custom-files.txt -tile 24x29 -geometry "128x128+0+0" \
vancouver-flowers-2025-128x128-patches-go-custom-front.png
```

# 2025-05-03-p1 Go Make Custom front of tshirt using 128 pixel by 128 pixel patches 
* 10 inch by 12 inch at 300 dots per inch  = 3000 pixels by 3600 pixels
* 3000 pixels / 128 pixels = approximately 24 patches wide
* 3600 pixels / 128 pixels = approximately 29 patches height
* 24 * 29 = 696 patches but we'll make 1000 just for fun
* add 128X128PATCHES to .gitignore and turn  off spotlight indexing in macOS
```bash
mkdir 128X128PATCHES
cd !$
 ../create128px-128px-random-patches.rb ../ORIGINALS/originals.txt 1000 2> stderr.txt &
```
# 2025-04-20-p5 Art of Where final leggings graphics
* Upload the following graphics to [art of where](https://artofwhere.com/)'s custom leggings web app and done :-)
    * [vancouver-flowers-2025-32x32-patches-leftleg.png](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/vancouver-flowers-2025-32x32-patches-leftleg.png)
    * [vancouver-flowers-2025-32x32-patches-rightleg.png](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/vancouver-flowers-2025-32x32-patches-rightleg.png)
# 2025-04-20-p4 Make the art of where collage legs with 20696 randomly arranged files 
* patch size is 32px x 32px
* Each leg of an Art of Where tights is 3325px x 6358 px (see [Art of Where's Design Guidelines](https://artofwhere.com/info/design-guidelines))
* 3325/32 = 104 patches wide 6358/32 = 199 patches high
* 104 * 199 = 20696
* [leftleg-files.txt](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/leftleg-files.txt)
* [rightleg-files.txt](https://github.com/rtanglao/rt-flower-swag-2025/blob/main/rightleg-files.txt)
* flickr set with the above left and right legs: [2025-04-20 Art of Where Tights from github rt-flower-swag](https://flic.kr/s/aHBqjC9JUq)

## 2025-04-20-p4 Flickr embed Left

<a data-flickr-embed="true" href="https://www.flickr.com/photos/roland/54465375744/in/album-72177720325249288/" title="vancouver-flowers-2025-32x32-patches-leftleg"><img src="https://live.staticflickr.com/65535/54465375744_39d646aaa4_w.jpg" width="209" height="400" alt="vancouver-flowers-2025-32x32-patches-leftleg"/></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

## 2025-04-20-p4 Flickr embed right

<a data-flickr-embed="true" href="https://www.flickr.com/photos/roland/54465375754/in/album-72177720325249288/" title="vancouver-flowers-2025-32x32-patches-rightleg"><img src="https://live.staticflickr.com/65535/54465375754_1ec6554b64_w.jpg" width="209" height="400" alt="vancouver-flowers-2025-32x32-patches-rightleg"/></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

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
