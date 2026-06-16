# [reg]ULAR [ex]PRESSION

This class provides a convenient object-oriented API around 4D `Match regex`.

Core use cases:

- test a pattern with `match()`
- extract values with `extract()`
- replace values with `substitute()` (alias: `replace()`)

## Summary

This class uses the 4D command [Match regex](https://doc.4d.com/4Dv20/4D/20.5/Match-regex.301-7388377.en.html), based on ICU ([International Components for Unicode](https://icu.unicode.org)).

## Properties

| Property | Type | Description | Initial value | Read only |
| :-- | :--: | :-- | :--: | :--: |
| `target` | `Text` | Target text used by regex methods | `""` | |
| `pattern` | `Text` | Current pattern | `""` | |
| `success` | `Boolean` | Status of last operation | `True` | |
| `lastError` | `Object` | Last error object `{code, method, desc}` | `Null` | yes |
| `errors` | `Collection` | Error history since object creation | `[]` | |
| `matches` | `Collection` | Last operation match metadata | `[]` | yes |
| `searchTime` | `Integer` | Last operation execution time (ms) | `0` | |

## Options

| Property | Type | Description | Default |
| :-- | :--: | :-- | :--: |
| `caseSensitve` | `Boolean` | If `True`, search is case-sensitive (`(?-i)`) | `False` |
| `caseSensitive` | `Boolean` | Alias of `caseSensitve` (corrected spelling) | `False` |
| `treatTargetAsOneLine` | `Boolean` | If `True`, `^` and `$` also match line boundaries (`(?-m)`) | `False` |
| `dotMatchNewLine` | `Boolean` | If `True`, dot matches new line (`(?s)`) | `False` |
| `allowSpaceAndComments` | `Boolean` | If `True`, enables free-spacing/comments (`(?x)`) | `False` |

## Setters

These methods return the same `cs.regex` instance, so they can be chained.

- `.setTarget(target) : cs.regex`
- `.setPattern(pattern : Text) : cs.regex`
- `.setOptions(options : Integer) : cs.regex`
- `.loadPattern(id : Text {;file : 4D.File}) : cs.regex`

`setTarget()` accepts:

- `Text`
- `Blob` (decoded as UTF-8)
- `4D.File` (file content is loaded)

## Main regex methods

- `.match({start : Integer}{;all : Boolean}) : Boolean`
- `.extract({groups}) : Collection`
- `.substitute({replacement : Text}) : Text`
- `.replace({replacement : Text}) : Text` (alias)
- `.LookingAt({pattern : Text}) : Boolean`
- `.lookingAt(target : Text; {pattern : Text}) : Boolean`
- `.start({index : Integer}) : Integer`
- `.end({index : Integer}) : Integer`
- `.length({index : Integer}) : Integer`
- `.group({index : Integer}) : Text`
- `.addslashes(in : Text) : Text`
- `.escape(in : Text) : Text` (alias)

### `matches` object format

`matches` is populated by `match()`, `extract()` and `substitute()`.

For backward compatibility, match objects expose both naming styles:

- `{index, data, position, length}`
- `{index, data, pos, len}`

The first element of each group corresponds to the full match, followed by capture groups.

## Helpers / shortcuts

- `.StripTags({allow}) : Text`
- `.stripTags(target : Text; {allow}) : Text`
- `.TrimLeading({char : Text}) : Text`
- `.trimLeading(target : Text; {char : Text}) : Text`
- `.TrimTrailing({char : Text}) : Text`
- `.trimTrailing(target : Text; {char : Text}) : Text`
- `.Trim({char : Text}) : Text`
- `.trim(target : Text; {char : Text}) : Text`
- `.extractDates({target}{;pivotYear : Integer}) : Collection`
- `.extractMailsAdresses({target}{;domains : Collection}) : Collection`
- `.validateMail(target : Text) : Boolean`
- `.validateURL(target : Text) : Boolean`
- `.countWords(target : Text) : Integer`

## Constructor

```4d
cs.regex.new()
cs.regex.new("hello world")
cs.regex.new("hello world"; "[Hh]ello")
```

## `match()`

```4d
$rgx:=cs.regex.new("Hello world, the world is wonderful but the world is in danger"; "world")

$rgx.match()  // first match
$rgx.match(10)  // first match starting at char 10
$rgx.match(True)  // all matches
$rgx.match(10; True)  // all matches from char 10
```

## `extract()`

`groups` can be:

- integer: `1`
- text list: `"1 2"`
- collection: `[1;2]`

```4d
$regex:=cs.regex.new("hello world"; "(?m-si)([[:alnum:]]*)\\s([[:alnum:]]*)")

$regex.extract()        // ["hello world"; "hello"; "world"]
$regex.extract(1)       // ["hello"]
$regex.extract("1 2")  // ["hello"; "world"]
$regex.extract([1;2])   // ["hello"; "world"]
```

## `substitute()`

```4d
$regex:=cs.regex.new()\
   .setTarget("123helloWorld")\
   .setPattern("(?mi-s)^[^[:alpha:]]*([^$]*)$")\
   .substitute("\\1")
```

Notes:

- Backrefs use `\\0`, `\\1`, `\\2`, ...
- Empty/missing replacement removes matched text.
- Signature includes `count` and `position` parameters internally, but they are currently not applied.

## `addslashes()` / `escape()`

Escapes a minimal useful set of regex metacharacters:
`\\`, `*`, `+`, `?`, `|`, `{`, `[`, `(`, `)`, `^`, `$`, `.`, `#`, and spaces.

```4d
$rgx:=cs.regex.new("The animal [what kind?] was visible [by whom?] from the window.")
$rgx.pattern:=$rgx.escape("[")+"(.*?)]"
$rgx.match(True)
```

## `extractDates()`

Returns a collection of objects:

```json
{
  "string": "Text",
  "value": "Date",
  "day": "Integer",
  "month": "Integer",
  "year": "Integer",
  "separator": "Text",
  "valid": "Boolean"
}
```

Default pivot year is `30`.

## `extractMailsAdresses()`

Returns a collection of objects:

```json
{
  "address": "Text",
  "user": "Text",
  "domain": "Text",
  "topLeveldomain": "Text",
  "valid": "Boolean"
}
```

Note: method name keeps the historical typo `Adresses` for backward compatibility.

## `validateURL()`

Strict URL validation (`http`/`https`, host, optional port/path/query/fragment).

```4d
$rgx:=cs.regex.new()
ASSERT($rgx.validateURL("https://developer.4d.com"))
ASSERT(Not($rgx.validateURL("ftp://example.com")))
```

## `countWords()`

Counts words using a regex-based tokenizer.

```4d
$rgx:=cs.regex.new()
ASSERT($rgx.countWords("Hello 4D world")=3)
```
