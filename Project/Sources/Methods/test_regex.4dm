//%attributes = {}
var $pattern; $target : Text
var $result : Collection
var $regex : cs:C1710.regex

// Mark:-match()
$regex:=cs:C1710.regex.new("Hello world, the world is wonderful but the world is in danger"; "world")

If ($regex.match())  //Test first occurrence
	
	ASSERT:C1129($regex.matches.length=1)
	ASSERT:C1129($regex.matches[0].data="world")
	ASSERT:C1129($regex.matches[0].position=7)
	ASSERT:C1129($regex.matches[0].length=5)
	
End if 

If ($regex.match(10))  // Starts search at 10th character
	
	ASSERT:C1129($regex.matches.length=1)
	ASSERT:C1129($regex.matches[0].data="world")
	ASSERT:C1129($regex.matches[0].position=18)
	ASSERT:C1129($regex.matches[0].length=5)
	
End if 

If ($regex.match(True:C214))  // Retrieves all occurrences
	
	ASSERT:C1129($regex.matches.length=3)
	ASSERT:C1129($regex.matches[0].data="world")
	ASSERT:C1129($regex.matches[0].position=7)
	ASSERT:C1129($regex.matches[0].length=5)
	
	ASSERT:C1129($regex.matches[1].data="world")
	ASSERT:C1129($regex.matches[1].position=18)
	ASSERT:C1129($regex.matches[1].length=5)
	
	ASSERT:C1129($regex.matches[2].data="world")
	ASSERT:C1129($regex.matches[2].position=45)
	ASSERT:C1129($regex.matches[2].length=5)
	
End if 

If ($regex.match(10; True:C214))  // Starts search at 10th character & retrieves all next occurences
	
	ASSERT:C1129($regex.matches.length=2)
	ASSERT:C1129($regex.matches[0].data="world")
	ASSERT:C1129($regex.matches[0].position=18)
	ASSERT:C1129($regex.matches[0].length=5)
	
	ASSERT:C1129($regex.matches[1].data="world")
	ASSERT:C1129($regex.matches[1].position=45)
	ASSERT:C1129($regex.matches[1].length=5)
	
End if 

$regex.pattern:="^Hello world$"

If ($regex.match())
	
	ASSERT:C1129($regex.matches.length=1)
	ASSERT:C1129($regex.matches[0].data="Hello world")
	ASSERT:C1129($regex.matches[0].position=1)
	ASSERT:C1129($regex.matches[0].length=11)
	
End if 

$regex.target:="fields[10]"
$regex.pattern:="(?m-si)^([^\\[]+)\\[(\\d+)]\\s*$"

If ($regex.match())
	
	ASSERT:C1129($regex.matches.length=3)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2)))
	
End if 

// First occurence
$regex.setTarget("fields[10] fields[11]").setPattern("(?mi-s)(\\w+)\\[(\\d+)]")

If ($regex.match())
	
	ASSERT:C1129($regex.matches.length=3)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2)))
	
End if 

If ($regex.match(1))
	
	ASSERT:C1129($regex.matches.length=3)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2)))
	
End if 

If ($regex.match(1; False:C215))
	
	ASSERT:C1129($regex.matches.length=3)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2)))
	
End if 

If ($regex.match(False:C215))
	
	ASSERT:C1129($regex.matches.length=3)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2)))
	
End if 

// All occurences
If ($regex.match(True:C214))
	
	ASSERT:C1129($regex.matches.length=6)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10"; "fields[11]"; "fields"; "11")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8; 12; 12; 19)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2; 10; 6; 2)))
	
End if 

If ($regex.match(1; True:C214))
	
	ASSERT:C1129($regex.matches.length=6)
	ASSERT:C1129($regex.matches.extract("data").equal(New collection:C1472("fields[10]"; "fields"; "10"; "fields[11]"; "fields"; "11")))
	ASSERT:C1129($regex.matches.extract("position").equal(New collection:C1472(1; 1; 8; 12; 12; 19)))
	ASSERT:C1129($regex.matches.extract("length").equal(New collection:C1472(10; 6; 2; 10; 6; 2)))
	
End if 

// Mark:-Pattern error
$regex.pattern:="(\\w+\\[(\\d+)]"
ASSERT:C1129(Not:C34($regex.match()))
ASSERT:C1129($regex.matches.length=0)
ASSERT:C1129($regex.lastError.code=304)
ASSERT:C1129($regex.lastError.method="regex.match")
ASSERT:C1129($regex.lastError.desc=("Error while parsing pattern \""+$regex.pattern+"\""))

// Mark:-extract()
$regex:=cs:C1710.regex.new("hello world"; "(?m-si)([[:alnum:]]*)\\s([[:alnum:]]*)")
$result:=$regex.extract()
ASSERT:C1129($result.equal(New collection:C1472("hello world"; "hello"; "world")))
$result:=$regex.extract("0")
ASSERT:C1129($result.equal(New collection:C1472("hello world")))
$result:=$regex.extract(0)
ASSERT:C1129($result.equal(New collection:C1472("hello world")))
$result:=$regex.extract(1)
ASSERT:C1129($result.equal(New collection:C1472("hello")))
$result:=$regex.extract(2)
ASSERT:C1129($result.equal(New collection:C1472("world")))
$result:=$regex.extract("1 2")
ASSERT:C1129($result.equal(New collection:C1472("hello"; "world")))
$result:=$regex.extract(New collection:C1472(1; 2))
ASSERT:C1129($result.equal(New collection:C1472("hello"; "world")))

// Mark:-substitute()
$target:="[This pattern will look for a string of numbers separated by commas and replace "\
+"the final comma with \"and\". It will also trim excess spaces around the final "\
+"comma and after the final number.]\r\r1, 2, 3, 4, 5\r1, 2 , 3\r1, 2, 3, 4 , 5 "\
+"\n1,2"
$pattern:="(?mi-s)\\x20*,\\x20*(\\d+)\\x20*$"

$regex:=cs:C1710.regex.new($target; $pattern)
ASSERT:C1129($regex.substitute(" and \\1")=("[This pattern will look for a string of numbers separated by commas and replace "\
+"the final comma with \"and\". It will also trim excess spaces around the final "\
+"comma and after the final number.]\r\r1, 2, 3, 4 and 5\r1, 2 and 3\r1, 2, 3, 4 "\
+"and 5\n1 and 2"))

ASSERT:C1129($regex.setTarget("hello world").setPattern("[^a-z0-9]").substitute("_")="hello_world")

$regex.target:="123helloWorld"
$regex.pattern:="(?mi-s)^[^[:alpha:]]*([^$]*)$"
ASSERT:C1129($regex.substitute("\\1")="helloWorld")

$regex.target:="Each of these lines ends with some white space. "\
+"This one ends with a space. \n\n"\
+"This one ends with a tab.\t\n\n"\
+"This one ends with some spaces.    \n\n"\
+"This one ends with some tabs.\t\t\t\n\n"\
+"This one ends with a mixture of spaces and tabs.  \t\t  \n\n"\
+"Since the pattern only matches trailing whitespace, we can replace it with nothing to get the result we want."
$regex.pattern:="(?mi-s)[[:blank:]]+$"
ASSERT:C1129(Length:C16($regex.substitute())=327)

// Mark:-countWords()
/*
$target:="This pattern will count the words in a string. \"Words\" are defined as any run "\
+"of letters or numbers, optionally containing a single apostrophe. For example, "\
+"\"don't\" is a word, but \"don''t\" counts as two words. Words that start or end "\
+"with an apostrophe (or any punctuation) are fine too, like 'tis or Stans'. A "\
+"word with close-curled apostrophe is counted the same as an apostrophe, like "\
+"\"don’t\" but not an open-curled apostrophe like \"doesn‘t\" (two words "\
+"there).\r\rSingle letter words like \"a\" will be properly counted. Runs of "\
+"punctuation like \"#$%&$#\" are ignored.\r\rIn the end, if you look at the "\
+"bottom of this window, you'll see that this little blurb has 118 words."

$regex:=cs.regex.new()

ASSERT($regex.countWords($target)=118; "Expected: 118")
*/

// Mark:-dates()
var $c : Collection
var $o : Object

$regex:=cs:C1710.regex.new("8/8/58")
$c:=$regex.extractDates()
ASSERT:C1129($c.length=1)
$o:=$c[0]
ASSERT:C1129($o.valid)
ASSERT:C1129($o.string="8/8/58")
ASSERT:C1129($o.day=8)
ASSERT:C1129($o.month=8)
ASSERT:C1129($o.year=1958)

var $today : Date:=Current date:C33
var $tomorrow : Date:=Current date:C33+1

$target:="This pattern does not rely on a date being on its own line so it will pick them "\
+"out from sentences like, \"I'm going to the vet on "+String:C10($today)+"\" or \"I have an "\
+"appointment on "+String:C10($tomorrow)+"\"."
$regex.setTarget($target)
$c:=$regex.extractDates()
ASSERT:C1129($c.length=2)

$o:=$c[0]
ASSERT:C1129($o.valid)
ASSERT:C1129($o.string=String:C10($today))
ASSERT:C1129($o.day=Day of:C23($today))
ASSERT:C1129($o.month=Month of:C24($today))
ASSERT:C1129($o.year=Year of:C25($today))

$o:=$c[1]
ASSERT:C1129($o.valid)
ASSERT:C1129($o.string=String:C10($tomorrow))
ASSERT:C1129($o.day=Day of:C23($tomorrow))
ASSERT:C1129($o.month=Month of:C24($tomorrow))
ASSERT:C1129($o.year=Year of:C25($tomorrow))


/*
By default, 4D uses 30 as pivot year. For example:
    01/25/97 means January 25, 1997.
    01/25/30 means January 25, 1930.
    01/25/29 means January 25, 2029.
    01/25/07 means January 25, 2007.
*/
$regex.setTarget("8/8/29")
$c:=$regex.extractDates()
ASSERT:C1129($c[0].year=2029)

$regex.setTarget("25/1/97")
$c:=$regex.extractDates()
ASSERT:C1129($c[0].year=1997)
$regex.setTarget("25/1/30")
$c:=$regex.extractDates()
ASSERT:C1129($c[0].year=1930)
$regex.setTarget("25/1/29")
$c:=$regex.extractDates()
ASSERT:C1129($c[0].year=2029)
$regex.setTarget("25/1/07")
$c:=$regex.extractDates()
ASSERT:C1129($c[0].year=2007)

/*
You can specify the optional pivotYear parameter.
For example, with the pivot year set at 95:
    01/25/94 means January 25, 2094
    01/25/95 means January 25, 1995
*/
$regex.setTarget("25/1/94")
$c:=$regex.extractDates(95)
ASSERT:C1129($c[0].year=2094)
$regex.setTarget("25/1/95")
$c:=$regex.extractDates(95)
ASSERT:C1129($c[0].year=1995)

// Mark:-emails()
$regex:=cs:C1710.regex.new("vincent@4d.com")
$c:=$regex.extractMailsAdresses()
ASSERT:C1129($c.length=1)
$o:=$c[0]
ASSERT:C1129($o.address="vincent@4d.com")
ASSERT:C1129($o.user="vincent")
ASSERT:C1129($o.domain="4d")
ASSERT:C1129($o.topLeveldomain=".com")
ASSERT:C1129($o.valid)

ASSERT:C1129($regex.setTarget($o.address).validateMail())

$regex.setTarget("This is an imperfect pattern that will pick out likely e-mail addresses using "\
+"the most common symbols, but will miss unusual addresses. It assumes first "\
+"that address will start with a letter or number that is not proceeded by one of "\
+"the other acceptable symbols like \"%+__$.-\", e.g., a@b.com or 9a@b.com. It "\
+"also assumes that those acceptable symbols can come before the \"@\", but never "\
+"two of those in a row. Thus a_b@c.com is acceptable but not a_-b@c.com. Finally, "\
+"every symbol must be followed up by a letter or number like a.b.c@d.com, but not "\
+"a.@c.com. After the \"@\", there must be a letter or number like "\
+"\"someone@27bslash6.com\". After that, there can either be a letter or number, "\
+"or a symbol like \"._-\". Again, any symbol must be followed by a letter or "\
+"number, like a@b9-8.com but not a@b--9.com or a@b9-.com. Finally, the address "\
+"will end with a period followed by a top-level domain of 2-6 letters. This will "\
+"include such addresses as a@b.info and a@b.museum, but not a@b.company. It does "\
+"not verify the top-level domain, of course, so an address like a@b.aol.spam "\
+"would get through. To counter this, replace the last part of the pattern "\
+"(\"\\.[a-z]{2,6}\\b\") with a list of acceptable domains like "\
+"this: \\.(?:com|net|org|gov|biz|info|jobs|tv|film| ... ) Of course, the "\
+"danger is that you will miss one since there are so many now. Note, by the "\
+"way, that multiple subdomains are not a problem, like "\
+"a@really.long.stinkin.domain.name.")
$c:=$regex.extractMailsAdresses()
ASSERT:C1129($c.length=10)
ASSERT:C1129($c[0].address="a@b.com")
ASSERT:C1129($c[1].address="9a@b.com")
ASSERT:C1129($c[2].address="a_b@c.com")
ASSERT:C1129($c[3].address="a.b.c@d.com")
ASSERT:C1129($c[4].address="someone@27bslash6.com")
ASSERT:C1129($c[5].address="a@b9-8.com")
ASSERT:C1129($c[6].address="a@b.info")
ASSERT:C1129($c[7].address="a@b.museum")
ASSERT:C1129($c[8].address="a@b.aol.spam")
ASSERT:C1129($c[9].address="a@really.long.stinkin.domain.name")

For each ($o; $c)
	
	ASSERT:C1129($regex.validateMail($o.address))
	
End for each 

// Mark:-stripTags()
var $t : Text:="<p>Test paragraph.</p><!-- Comment --> <a href=\"#fragment\">Other text</a>"
var $rgx : cs:C1710.regex:=cs:C1710.regex.new()
ASSERT:C1129($rgx.stripTags($t)="Test paragraph. Other text")

BEEP:C151