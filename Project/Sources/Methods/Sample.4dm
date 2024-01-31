//%attributes = {}
var $result; $t : Text
var $match : Boolean
var $c : Collection
var $regex : cs:C1710.regex

$regex:=cs:C1710.regex.new("Hello world, the world is wonderful but the world is in danger"; "Hello (world)")

$match:=$regex.match()  // = True

$c:=$regex.extract()  // = [ "Hello world", "world" ]
$c:=$regex.extract(1)  // = [ "world"]

$result:=$regex.substitute("Vincent")  // = "Vincent, the world is wonderful but the world is in danger"

$t:="$html = '\n<div>\n<p style=\"color:blue;\">color is blue</p><p>size is "\
+"<span style=\"font-size:200%;\">huge</span></p>\n<p>material is "\
+"wood</p>\n</div>\n'"
$result:=$regex.stripTags($t)  // = $html = ' color is blue size is huge material is wood '

$result:=$regex.stripTags("<p>Test paragraph.</p><!-- Comment --> <a href=\"#fragment\">Other text</a>")  // = "Test paragraph. Other text"