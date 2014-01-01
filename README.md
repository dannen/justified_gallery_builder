justified_gallery_builder
=========================

A perl script to build an index.html file for CLI use of Justified Gallery.

usage:

cd path_to_build_index_in
~/justified_gallery_builder.pl

requirements: 

justified_resize:
https://github.com/dannen/justified_resize/

Justfied Gallery:
http://miromannino.com/projects/justified-gallery/


Justified_gallery_builder is a simple, non-object-oriented script to build a basic index.html file that conforms properly to the Justified Gallery ( http://miromannino.com/projects/justified-gallery/ ) code.  It is intended to quickly mock-up a gallery inside a directory of image files.


For better results, I suggest you use my all_mtime script on the  image directory prior to executing justified_gallery_builder.

all_mtime:
https://github.com/dannen/all_mtime

Question:

How the heck do I make this work from scratch?

Answer:

login to your favorite unix host which already has apache configured and running.

<pre>
mkdir test
cd test

git clone https://github.com/miromannino/Justified-Gallery.git

mv Justified-Gallery/examples/jquery .
mv Justified-Gallery/examples/jquery-colorbox .
mv Justified-Gallery/js .
mv Justified-Gallery/css .

git clone https://github.com/dannen/all_mtime.git
git clone https://github.com/dannen/justified_resize.git
git clone https://github.com/dannen/justified_gallery_builder.git


mkdir images
cp ~/sourceofimages/* ./images

cd images
../all_mtime/all_mtime.pl
../justified_resize/justified_resize.pl
../justified_gallery_builder/justified_gallery_builder.pl
</pre>

open a web browser and point it at http://yourfavoriteunixhost/pathto/images

It should look like the results of example.html here: 

	http://fnord.org/justified_gallery_builder/example/after/example.html

note:
 * You will consume a lot of diskspace with these tools as they make several copies of your original images.
