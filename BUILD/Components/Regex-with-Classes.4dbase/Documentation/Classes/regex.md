# [reg]ULAR [ex]PRESSION
This class allows to perform, on string data, testing for a pattern match ([match](#match)), searching for a pattern match ([extract](#extract)), and replacing matched text ([substitute](#substitute)).

## Summary
This class use the **[Match regex](https://doc.4d.com/4Dv19/4D/19.1/Match-regex.301-5653300.en.html)** 4D Command based on ICU ([International Components for Unicode](https://icu.unicode.org)) library. 

> 📌 The regular expression patterns and behavior are based on Perl’s regular expressions.

### Properties

|Properties|Type| |Initial value|Read only|
|:---------|:----:|------|:------:|:------:|
|**target**|`Text`|The string data| "" |
|**pattern**|`Text`|The pattern to use for future operations| "" |
|**success**|`Boolean`|The status of the last operation|**True**|
|**lastError**|`Object`|The last error encountered: Object `{code:Integer,method:Text,desc:Text}`|**Null**|✔️
|**errors**|`Collection`|All errors since class inititialisation| [ ]|
|**matches**|`Collection`|The match list of the extracted segments during the last operation (see below)|**Null**|✔️
|**searchTime**|`Integer`|The time, in milliseconds, to execute the last regex function.|**0**|

### Functions
> 📌 The "setXXX" functions returns the original `cs.regex` object, so you can include one call after another (See [substitute ()](#substitute) example).

|Functions| |
|:--------|------|  
|.**setTarget** (target) : `cs.regex`|Defines the string on which the next operations will be performed.<br/>`target` can be a `Text`, a `Blob` or a `4D.File`.
|.**setPattern** (pattern : `Text`) : `cs.regex`|Defines the pattern to use for future operations.
|.**[match](#match)** () : `Boolean`|Returns **True** if the pattern matches the string.
|.**[extract](#extract)** ({group}) : `Collection`|Returns the list of texts extracted based on the pattern definition
|.**[substitute](#substitute)** ({replacement: `Text`}) : `Text`|Returns the result of the replacement in the target string
|.**lookingAt**() : `Boolean`| Returns **True** if the pattern against the target string matches at the start of the string.
|.**start** ({index : `Integer`}) : `Integer`| Returns the position of the start of the nth matched region in the target string.\*
|.**end** ({index : `Integer`}) : `Integer`| Returns the position of the first character following the text matched by the nth capture group.\*
|.**length** ({index : `Integer`}) : `Integer`| Return the length of the nth match.\*
|.**group** ({index : `Integer`}) : `Text`| Return the text that was matched by the nth capture group.\*
|.**[escape](escape)** (`Text`) : `Text`| Escapes a minimal set of characters.

\* First match if `index` is omitted. Only availbale after `match()`, `extract()` or `substitute()`

> 📌 The `match()`, `extract()` & `substitute()` functions populates the `matches` property.     
> The first element of the collection contain the whole pattern match, and the others matched subpatterns, if any.     
> Each element is described in an object with its order number ("index"), its value ("data"), its position ("pos") and its length ("len").

### Built-in shortcuts

|Functions| |
|:--------|------|  
|.**[validateMail](validateMail)** (email : `Text`) : `Boolean`| Validate an e-mail address
|.**[stripTags](stripTags)** (in : `Text`) : `Text`|Returns a string with all HTML and PHP tags removed. Equivalent of PHP `strip_tags`)
|.**[extractDates](extractDates)** () : `Collection`| Extracts & validate dates from a string.
|.**[extractMailsAdresses](extractMailsAdresses)** () : `Collection `| Extracts emails from a text.

## 🔸 cs.regex.new()

The class constructor `cs.regex.new()` can be called without parameters to create an empty regex object.    

```4d
cs.regex.new()
```

The constructor also accepts two optional parameters, which allows you to create a regex object and fill in the target and pattern in one operation.    

```4d
cs.regex.new("hello world")   // Fills the target 
cs.regex.new("hello world"; "[Hh]ello")   // Fills the target and the pattern
```
The target parameter can be a text value, a blob or a 4D.File. In the last case, the contents of the file are loaded from disk and used to fill the target property.

## 🔹<a name="match">match ()</a>

> .**match** () : `Boolean`    
> .**match** ({start : `Integer`} {;} {all : `Boolean`}) : `Boolean`

Matches a regular expression against the target text and returns **True** if the pattern matches the target text.

You can pass `start` to specify the position at which the search will begin.    
You can pass `all` = **True** to get all results.    
Both parameters are optional and can be passed alone or together.    
>📌 If `start` is passed and `all` is **True**, the capture starts at the desired position and subsequent hits are returned if any.

```4d
$rgx:=cs.regex.new("Hello world, the world is wonderful but the world is in danger"; "world")
```
## 🔹<a name="extract">extract ()</a>

> .**extract** () : `Collection`  
> .**extract**(groups: `Integer`) : `Collection`    
> .**extract**(groups: `Text`) : `Collection`    
> .**extract**(groups: `Collection`) : `Collection`    

Extracts all matches of a regular expression against the target text and returns the pattern matches values.

Parameter `group` specifies the group(s) to be extracted, it can be a text, an integer or a collection.

* If it is not specified, the whole pattern matches is extracted first (element 0) then all the sub-pattern matches if the pattern contains grouping parentheses.  
* If the pattern contains grouping parentheses, the `group` parameter can be a list of group numbers to be extracted.  
* Accepted types for `groups` can be text (text separated by spaces if there is more than one group), a collection of texts or a collection of integers. 
   
> For example, by specifing "1 2", all matches of the first and second sub-pattern will be extracted (others are ignored).  

```4d
$regex:=cs.regex.new("hello world"; "(?m-si)([[:alnum:]]*)\\s([[:alnum:]]*)")
$result:=$regex.extract()   // → ["hello world"; "hello"; "world"]
$result:=$regex.extract("0")   // → ["hello world"]
$result:=$regex.extract("1 2")   // → ["hello"; "world"]
$result:=$regex.extract(0)   // → ["hello world"]
$result:=$regex.extract(1)   // → ["hello"]
$result:=$regex.extract(2)   // → ["world"]
$result:=$regex.extract([1; 2])   // → ["hello"; "world"]
```  

## 🔹<a name="substitute">substitute ()</a>
  
> .**substitute** ({replacement: `Text`}) : `Text`    
> .**substitute** () : `Text`  

Substitutes all matches of a regular expression in the target text with a replacement string.

* The `replacement` string may contain group references in the `\digit` form. Each backref is substituted by the corresponding sub-pattern match ( `\0` is the whole pattern match, `\1` the first group, `\2` the second etc.).
* If the `replacement` string is omitted (or is an empty string), the matches values are deleted.   
* Other special character sequences can be used in the replacement string: See [ICU User Guide](https://unicode-org.github.io/icu/userguide/strings/regexp.html)

```4d
$regex:=cs.regex.new()\
   .setTarget("123helloWorld")\
   .setPattern("(?mi-s)^[^[:alpha:]]*([^$]*)$")\
   .substitute("\\1")   // → "helloWorld" 
```

## 🔹<a name="escape"> escape ()</a>

> .**escape**( in: `Text` ) : `Text` 

Escapes a minimal set of characters `\, *, +, ?, |, {, [, (, ), ^, $, ., #, and white spaces` by replacing them with their escape codes. This tells the regular expression engine that it must interpret these characters literally, and not as metacharacters.

For example, consider a regular expression designed to extract comments delimited by opening and closing square brackets. The pattern will be ` [(.*?)] `. Note that the opening square bracket which will be interpreted as the start of a character class. We must therefore escape this character, but not the next opening parenthesis that open a capture sequence.

```4d
$rgx:=cs.regex.new("The animal [what kind?] was visible [by whom?] from the window.")
```

Without escapement, the result would have been as follows:

```
$rgx:=cs.regex.new("The animal [what kind?] was visible [by whom?] from the window.")
// $rgx.matches[1].data = "?"
```

The function escapes the left bracket `[` and the opening brace `{`, but not their corresponding closing characters `]` and `}`. In most cases, it is not necessary to escape them. If a closing bracket or brace is not preceded by its corresponding opening character, the regular expression engine interprets it literally.


## 🔹<a name="extractDates">extractDates ()</a>

> .**extractDates**() : `Collection`    
> .**extractDates**( target: `Text` ) : `Collection`    
> .**extractDates**( pivotYear: `Integer` ) : `Collection`    
> .**extractDates** (target: `Text` ; pivotYear: `Integer` ) : `Collection`

Extracts & validate dates from a string.

{
  value: Date,        // The date value
```
By default, like 4D, the function uses 30 as the pivot year. For example:

```4d
cs.regex.new("8/8/29").extractDates[0].year  // return 2029
```

```4d
cs.regex.new("01/25/94"; 95).extractDates[0].year  // return 2094
```

## 🔹<a name="extractMailsAdresses">extractMailsAdresses ()</a>

> .**extractMailsAdresses**() : `Collection`    
> .**extractMailsAdresses**( target: `Text` ) : `Collection`    

Extracts emails from a text.

```json
```