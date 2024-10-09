//%attributes = {}
var $pattern; $target : Text
var $result : Collection
var $rgx : cs:C1710.regex


// Mark:-Options
$rgx:=cs:C1710.regex.new("Hello world, the world is wonderful but the world is in danger"; "WORLD")
ASSERT:C1129($rgx.match())

$rgx.caseSensitve:=True:C214
ASSERT:C1129(Not:C34($rgx.match()))

$rgx.dotMatchNewLine:=True:C214
ASSERT:C1129(Not:C34($rgx.match()))

$rgx.treatTargetAsOneLine:=True:C214
ASSERT:C1129(Not:C34($rgx.match()))

$rgx.allowSpaceAndComments:=True:C214
ASSERT:C1129(Not:C34($rgx.match()))

$rgx.caseSensitve:=False:C215
$rgx.dotMatchNewLine:=False:C215
$rgx.treatTargetAsOneLine:=False:C215
$rgx.allowSpaceAndComments:=False:C215
ASSERT:C1129($rgx.match())

// Mark:-match()
$rgx:=cs:C1710.regex.new("Hello world, the world is wonderful but the world is in danger"; "world")

// Test first occurrence
If ($rgx.match())
	
	ASSERT:C1129($rgx.count=1)
	ASSERT:C1129($rgx.group()="world")
	ASSERT:C1129($rgx.start()=7)
	ASSERT:C1129($rgx.length()=5)
	ASSERT:C1129($rgx.end()=13)
	
End if 

// Starts search at 10th character
If ($rgx.match(10))
	
	ASSERT:C1129($rgx.count=1)
	ASSERT:C1129($rgx.group()="world")
	ASSERT:C1129($rgx.start()=18)
	ASSERT:C1129($rgx.length()=5)
	ASSERT:C1129($rgx.end()=24)
	
End if 

// Retrieves all occurrences
If ($rgx.match(True:C214))
	
	ASSERT:C1129($rgx.count=3)
	
	ASSERT:C1129($rgx.group()="world")
	ASSERT:C1129($rgx.start()=7)
	ASSERT:C1129($rgx.length()=5)
	ASSERT:C1129($rgx.end()=13)
	
	ASSERT:C1129($rgx.group(1)="world")
	ASSERT:C1129($rgx.start(1)=7)
	ASSERT:C1129($rgx.length(1)=5)
	ASSERT:C1129($rgx.end(1)=13)
	
	ASSERT:C1129($rgx.group(2)="world")
	ASSERT:C1129($rgx.start(2)=18)
	ASSERT:C1129($rgx.length(2)=5)
	ASSERT:C1129($rgx.end(2)=24)
	
	ASSERT:C1129($rgx.group(3)="world")
	ASSERT:C1129($rgx.start(3)=45)
	ASSERT:C1129($rgx.length(3)=5)
	ASSERT:C1129($rgx.end(3)=51)
	
End if 

// Starts search at 10th character & retrieves all next occurences
If ($rgx.match(10; True:C214))
	
	ASSERT:C1129($rgx.count=2)
	
	ASSERT:C1129($rgx.group(1)="world")
	ASSERT:C1129($rgx.start(1)=18)
	ASSERT:C1129($rgx.length(1)=5)
	ASSERT:C1129($rgx.end(1)=24)
	
	ASSERT:C1129($rgx.group(2)="world")
	ASSERT:C1129($rgx.start(2)=45)
	ASSERT:C1129($rgx.length(2)=5)
	ASSERT:C1129($rgx.end(2)=51)
	
End if 

$rgx.pattern:="^Hello world$"

If ($rgx.match())
	
	ASSERT:C1129($rgx.count=1)
	ASSERT:C1129($rgx.group()="Hello world")
	ASSERT:C1129($rgx.start()=1)
	ASSERT:C1129($rgx.length()=11)
	ASSERT:C1129($rgx.end()=12)
	
End if 

$rgx.target:="fields[10]"
$rgx.pattern:="(?m-si)^([^\\[]+)\\[(\\d+)]\\s*$"

If ($rgx.match())
	
	ASSERT:C1129($rgx.count=3)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2]))
	
End if 

// First occurence
$rgx.setTarget("fields[10] fields[11]").setPattern("(?mi-s)(\\w+)\\[(\\d+)]")

If ($rgx.match())
	
	ASSERT:C1129($rgx.count=3)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2]))
	
End if 

If ($rgx.match(1))
	
	ASSERT:C1129($rgx.count=3)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2]))
	
End if 

If ($rgx.match(1; False:C215))
	
	ASSERT:C1129($rgx.count=3)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2]))
	
End if 

If ($rgx.match(False:C215))
	
	ASSERT:C1129($rgx.count=3)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2]))
	
End if 

// All occurences
If ($rgx.match(True:C214))
	
	ASSERT:C1129($rgx.count=6)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"; "fields[11]"; "fields"; "11"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8; 12; 12; 19]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2; 10; 6; 2]))
	
End if 

If ($rgx.match(1; True:C214))
	
	ASSERT:C1129($rgx.count=6)
	ASSERT:C1129($rgx.matches.extract("data").equal(["fields[10]"; "fields"; "10"; "fields[11]"; "fields"; "11"]))
	ASSERT:C1129($rgx.matches.extract("position").equal([1; 1; 8; 12; 12; 19]))
	ASSERT:C1129($rgx.matches.extract("length").equal([10; 6; 2; 10; 6; 2]))
	
End if 

// Mark:-Pattern error
$rgx.pattern:="(\\w+\\[(\\d+)]"
ASSERT:C1129(Not:C34($rgx.match()))
ASSERT:C1129($rgx.matches.length=0)
ASSERT:C1129($rgx.lastError.code=304)
ASSERT:C1129($rgx.lastError.method="regex.match")
ASSERT:C1129($rgx.lastError.desc=("U_REGEX_MISMATCHED_PAREN"))

// Mark:-lookingAt()
$rgx:=cs:C1710.regex.new("hello world"; "hello")
ASSERT:C1129($rgx.lookingAt())
$rgx.pattern:="world"
ASSERT:C1129(Not:C34($rgx.lookingAt()))

// Mark:-extract()
$rgx:=cs:C1710.regex.new("hello world"; "(?m-si)([[:alnum:]]*)\\s([[:alnum:]]*)")
$result:=$rgx.extract()
ASSERT:C1129($result.equal(["hello world"; "hello"; "world"]))
$result:=$rgx.extract("0")
ASSERT:C1129($result.equal(["hello world"]))
$result:=$rgx.extract(0)
ASSERT:C1129($result.equal(["hello world"]))
$result:=$rgx.extract(1)
ASSERT:C1129($result.equal(["hello"]))
$result:=$rgx.extract(2)
ASSERT:C1129($result.equal(["world"]))
$result:=$rgx.extract("1 2")
ASSERT:C1129($result.equal(["hello"; "world"]))
$result:=$rgx.extract([1; 2])
ASSERT:C1129($result.equal(["hello"; "world"]))

// Mark:-substitute()
$target:="[This pattern will look for a string of numbers separated by commas and replace "\
+"the final comma with \"and\". It will also trim excess spaces around the final "\
+"comma and after the final number.]\r\r1, 2, 3, 4, 5\r1, 2 , 3\r1, 2, 3, 4 , 5 "\
+"\n1,2"
$pattern:="(?mi-s)\\x20*,\\x20*(\\d+)\\x20*$"

$rgx:=cs:C1710.regex.new($target; $pattern)
ASSERT:C1129($rgx.substitute(" and \\1")=("[This pattern will look for a string of numbers separated by commas and replace "\
+"the final comma with \"and\". It will also trim excess spaces around the final "\
+"comma and after the final number.]\r\r1, 2, 3, 4 and 5\r1, 2 and 3\r1, 2, 3, 4 "\
+"and 5\n1 and 2"))

ASSERT:C1129($rgx.setTarget("hello world").setPattern("[^a-z0-9]").substitute("_")="hello_world")

$rgx.target:="123helloWorld"
$rgx.pattern:="(?mi-s)^[^[:alpha:]]*([^$]*)$"
ASSERT:C1129($rgx.substitute("\\1")="helloWorld")

$rgx.target:="Each of these lines ends with some white space. "\
+"This one ends with a space. \n\n"\
+"This one ends with a tab.\t\n\n"\
+"This one ends with some spaces.    \n\n"\
+"This one ends with some tabs.\t\t\t\n\n"\
+"This one ends with a mixture of spaces and tabs.  \t\t  \n\n"\
+"Since the pattern only matches trailing whitespace, we can replace it with nothing to get the result we want."
$rgx.pattern:="(?mi-s)[[:blank:]]+$"
ASSERT:C1129(Length:C16($rgx.substitute())=327)

// Mark:-escape()
ASSERT:C1129($rgx.escape("fields[10] fields[11]")="fields\\[10]\\sfields\\[11]")

$rgx:=cs:C1710.regex.new("The animal [what kind?] was visible [by whom?] from the window.")
$rgx.pattern:=$rgx.escape("[")+"(.*?)]"
If (Asserted:C1132($rgx.match(True:C214)))
	
	ASSERT:C1129($rgx.matches.length=4)
	ASSERT:C1129($rgx.matches[1].data="what kind?")
	ASSERT:C1129($rgx.matches[3].data="by whom?")
	
End if 

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

// Mark:-extractDates()
var $c : Collection
var $o : Object

$rgx:=cs:C1710.regex.new("8/8/58")
$c:=$rgx.extractDates()
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
$rgx.setTarget($target)
$c:=$rgx.extractDates()
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
By default, like 4D, the function uses 30 as the pivot year. For example :
    01/25/97 means January 25, 1997.
    01/25/30 means January 25, 1930.
    01/25/29 means January 25, 2029.
    01/25/07 means January 25, 2007.
*/
$rgx.setTarget("8/8/29")
$c:=$rgx.extractDates()
ASSERT:C1129($c[0].year=2029)


$rgx.setTarget("25/1/97")
$c:=$rgx.extractDates()
ASSERT:C1129($c[0].year=1997)
$rgx.setTarget("25/1/30")
$c:=$rgx.extractDates()
ASSERT:C1129($c[0].year=1930)
$rgx.setTarget("25/1/29")
$c:=$rgx.extractDates()
ASSERT:C1129($c[0].year=2029)
$rgx.setTarget("25/1/07")
$c:=$rgx.extractDates()
ASSERT:C1129($c[0].year=2007)

$rgx.setTarget("25-1-97")
$c:=$rgx.extractDates()
ASSERT:C1129($c[0].year=1997)
ASSERT:C1129($c[0].valid)

/*
You can specify the optional pivotYear parameter.
For example, with the pivot year set at 95:
    01/25/94 means January 25, 2094
    01/25/95 means January 25, 1995
*/
$rgx.setTarget("25/1/94")
$c:=$rgx.extractDates(95)
ASSERT:C1129($c[0].year=2094)
$rgx.setTarget("25/1/95")
$c:=$rgx.extractDates(95)
ASSERT:C1129($c[0].year=1995)

// Mark:-validateMail()
ASSERT:C1129(cs:C1710.regex.new("vincent@4d.com").validateMail())
ASSERT:C1129(Not:C34(cs:C1710.regex.new("hello@world").validateMail()))
//ASSERT(Not(cs.regex.new("a@b--9.com").validateMail()))
//ASSERT(Not(cs.regex.new("a@b9-.com").validateMail()))

// Mark:-extractMailsAdresses()
$rgx:=cs:C1710.regex.new("vincent@4d.com")
$c:=$rgx.extractMailsAdresses()
ASSERT:C1129($c.length=1)
$o:=$c[0]
ASSERT:C1129($o.address="vincent@4d.com")
ASSERT:C1129($o.user="vincent")
ASSERT:C1129($o.domain="4d")
ASSERT:C1129($o.topLeveldomain=".com")
ASSERT:C1129($o.valid)

$target:="This is an imperfect pattern that will pick out likely e-mail addresses using "\
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
+"a@really.long.stinkin.domain.name."
$rgx:=cs:C1710.regex.new($target)
$c:=$rgx.extractMailsAdresses()
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
	
	ASSERT:C1129($o.valid)
	
End for each 

//$c:=$regex.extractMailsAdresses(["com"; "info"])


// Mark:-stripTags()
var $t : Text:="<p>Test paragraph.</p><!-- Comment --> <a href=\"#fragment\">Other text</a>"
$rgx:=cs:C1710.regex.new()
ASSERT:C1129($rgx.stripTags($t)="Test paragraph. Other text")

BEEP:C151