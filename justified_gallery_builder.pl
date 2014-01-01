#!/usr/bin/perl
unlink "index.html";

$table = 0;
$pwd = `pwd`;
$thumbdir = "resized";
$targeturl = "http://fnord.org/justified_gallery_builder";

chomp $pwd;
print "Running in: $pwd\n";

opendir (DIR,$pwd);

foreach $picture (sort readdir DIR ) {
        $dirnames{$picture}++;
}
close DIR;

open (INDEX, ">index.html");
$pwd = `pwd`;
chomp $pwd;
$id = (split (/\//, $pwd) ) [-1];


print INDEX <<EOF;

<!DOCTYPE html>
<head>
<title>$id</title>

<script type='text/javascript' src='$targeturl/jquery/jquery-1.8.2.min.js'></script>
<link rel='stylesheet' href='$targeturl/jquery-colorbox/colorbox.css' type='text/css' media='screen' />
<script type='text/javascript' src='$targeturl/jquery-colorbox/jquery.colorbox-min.js'></script>
<link rel='stylesheet' href='$targeturl/css/jquery.justifiedgallery.css' type='text/css' media='all' />
<script type='text/javascript' src='$targeturl/js/jquery.justifiedgallery.js'></script>
</head>

<style type="text/css">
        body {font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; background: black}
        .example-description { margin: 20px 0 20px 0;}
        h1 { }
        h2 {font-size: 20px; margin-top: 80px; }
        h3 {font-size: 15px; margin-top: 0px; }
        pre {
                -webkit-box-shadow: inset 0px 0px 4px 1px #E6E6E6;
                -moz-box-shadow: inset 0px 0px 4px 1px #e6e6e6;
                box-shadow: inset 0px 0px 4px 1px #E6E6E6;
                border: 1px solid #FFF;
                padding: 0.5em;
                font-size: 12px;
                line-height: 22px;
                color: #333;
                margin-bottom: 1.5em;
                overflow-x: auto;
        }
</style>

EOF

#print INDEX "<body bgcolor=#000000 text=white link=white vlink=red alink=red>\n";
print INDEX "<body>\n\n";

opendir (THUMBDIR,"$pwd/$thumbdir");

foreach $thumbnail ( sort readdir THUMBDIR) {
        if ($thumbnail =~ /_t.jpg/) {
                $thumbnames{$thumbnail}++;
        }
}
close THUMBDIR;

print INDEX "<div id=\"$id\">\n";

foreach $thumbnail (sort keys %thumbnames) {
        ($picname,$null) = split (/_t.jpg/,$thumbnail);
        ($filename,$suffix) = split (/\./,$picname);
        $b_picname = join "",$picname,"_b.jpg";
        #print "$b_picname\n";

        #if ($table == 7) {
        #       $table = 0;
        #       print INDEX "</div>";
        #}

                $table++;
                print INDEX "\t<a href=\"$thumbdir/$b_picname\" title=\"$table\" rel=\"fnord\">\n";
                print INDEX "\t\t<img alt=\"$table\" src=\"$thumbdir/$thumbnail\" />\n";
                print INDEX "\t</a>\n";

}


print INDEX "</div>\n";

# justified gallery options
print INDEX "<script type=\"text/javascript\">\n";
print INDEX "\t\$(\"#$id\").justifiedGallery({\n";
#print INDEX "\t\t\'rowHeight\':213,\n";
#print INDEX "\t\t\'rowHeight\':80,\n";
#print INDEX "\t\t\'justifyLastRow\':false,\n";
#print INDEX "\t\t\'fixedHeight\':true,\n";
#print INDEX "\t\t\'captions\':true,\n";
#print INDEX "\t\t\'margins\':15,\n";
print INDEX "\t\t\'onComplete\': function(gal) {\n";
print INDEX "\t\t\t\$(gal).find(\"a\").colorbox({\n";
#print INDEX "\t\t\t\tmaxWidth:\"80%\",\n";
#print INDEX "\t\t\t\tmaxHeight:\"80%\",\n";
print INDEX "\t\t\t\topacity:0.8,\n";
print INDEX "\t\t\t\ttransition:\"elastic\",\n";
print INDEX "\t\t\t\tcurrent:\"\"\n";
print INDEX "\t\t\t\});\n";
print INDEX "\t\t\}\n";
print INDEX "\t});\n";
print INDEX "</script>\n";
print INDEX "</body>\n";
print INDEX "</html>\n";


close INDEX;

system ("chmod 755 .");
system ("chmod 644 *.jpg");
