//%attributes = {}
var $regex : cs:C1710.regex
$regex:=cs:C1710.regex.new("Hello world, the world is wonderful but the world is in danger"; "Hello (world)")

var $match : Boolean
$match:=$regex.match()  // = True

var $c : Collection
$c:=$regex.extract()  // = [ "Hello world", "world" ]
$c:=$regex.extract(1)  // = [ "world"]

var $result : Text
$result:=$regex.substitute("Vincent")  // = "Vincent, the world is wonderful but the world is in danger"




