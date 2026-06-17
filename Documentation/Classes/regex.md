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

| Function | Action |
| :-- | :-- |
| `.setTarget(target) : cs.regex` | Sets the target text for next operations. Supports `Text`, `Blob` (UTF-8) and `4D.File`. |
| `.setPattern(pattern : Text) : cs.regex` | Sets the current regex pattern. |
| `.setOptions(options : Integer) : cs.regex` | Sets regex option flags in one call (bits 0..3). |
| `.loadPattern(id : Text {;file : 4D.File}) : cs.regex` | Loads a named pattern from XML and sets it as current pattern. |

`setTarget()` accepts:

- `Text`
- `Blob` (decoded as UTF-8)
- `4D.File` (file content is loaded)

## Main regex methods

| Function | Action |
| :-- | :-- |
| `.match({start : Integer}{;all : Boolean}) : Boolean` | Tests pattern against target and populates `matches`. Use `all=True` to collect all hits. |
| `.extract({groups}) : Collection` | Returns extracted match values (all groups or selected groups). |
| `.substitute({replacement : Text}{;count : Integer}{;position : Integer}) : Text` | Replaces matches in target and returns resulting text. |
| `.replace({replacement : Text}{;count : Integer}{;position : Integer}) : Text` | Alias of `.substitute()`. |
| `.LookingAt({pattern : Text}) : Boolean` | Tests whether pattern matches at the beginning of current target. |
| `.lookingAt(target : Text; {pattern : Text}) : Boolean` | Utility overload to test a provided target without reusing current one. |
| `.isMatch(pattern : Text) : Boolean` | Shortcut for matching a pattern against current target. |
| `.isMatch(target : Text; pattern : Text) : Boolean` | Shortcut for one-shot target+pattern match. |
| `.fullMatch({pattern : Text}) : Boolean` | Tests if entire target matches pattern (implicit ^ and $). |
| `.fullMatch(target : Text; pattern : Text) : Boolean` | One-shot full target match. |
| `.findAll({groups}) : Collection` | Returns all matches as collection, optionally extracting specific groups. |
| `.findAll(target : Text; pattern : Text {;groups}) : Collection` | One-shot find all with provided target/pattern. |
| `.replaceFirst(replacement : Text) : Text` | Replaces first match only. |
| `.replaceFirst(replacement : Text; target : Text; pattern : Text) : Text` | One-shot replace first. |
| `.replaceAll(replacement : Text) : Text` | Replaces all matches. |
| `.replaceAll(replacement : Text; target : Text; pattern : Text) : Text` | One-shot replace all. |
| `.start({index : Integer}) : Integer` | Returns start position (1-based) of nth match/capture. |
| `.end({index : Integer}) : Integer` | Returns first character position after nth match/capture. |
| `.length({index : Integer}) : Integer` | Returns length of nth match/capture. |
| `.group({index : Integer}) : Text` | Returns text of nth match/capture. |
| `.split({limit : Integer}) : Collection` | Splits current target using current pattern; optional limit controls max parts. |
| `.split(target : Text; pattern : Text {;limit : Integer}) : Collection` | One-shot split with provided target/pattern. |
| `.addslashes(in : Text) : Text` | Escapes regex metacharacters in input text. |
| `.escape(in : Text) : Text` | Alias of `.addslashes()`. |

### `matches` object format

`matches` is populated by `match()`, `extract()` and `substitute()`.

For backward compatibility, match objects expose both naming styles:

- `{index, data, position, length}`
- `{index, data, pos, len}`

The first element of each group corresponds to the full match, followed by capture groups.

## Helpers / shortcuts

| Function | Action |
| :-- | :-- |
| `.StripTags({allow}) : Text` | Removes HTML/XML/PHP tags from current target. |
| `.stripTags(target : Text; {allow}) : Text` | Removes tags from provided target text. |
| `.TrimLeading({char : Text}) : Text` | Trims leading occurrences from current target (default: whitespace). |
| `.trimLeading(target : Text; {char : Text}) : Text` | Trims leading occurrences from provided target (default: whitespace). |
| `.TrimTrailing({char : Text}) : Text` | Trims trailing occurrences from current target (default: whitespace). |
| `.trimTrailing(target : Text; {char : Text}) : Text` | Trims trailing occurrences from provided target (default: whitespace). |
| `.Trim({char : Text}) : Text` | Trims leading and trailing occurrences from current target (default: whitespace). |
| `.trim(target : Text; {char : Text}) : Text` | Trims leading and trailing occurrences from provided target (default: whitespace). |
| `.extractDates({target}{;pivotYear : Integer}) : Collection` | Extracts date-like values and returns parsed/validated objects. |
| `.extractMailsAdresses({target}{;domains : Collection}) : Collection` | Extracts likely email addresses and returns structured objects. |
| `.validateMail(target : Text) : Boolean` | Validates an email address against the class pattern. |
| `.validateURL(target : Text) : Boolean` | Validates an `http/https` URL with strict structure rules. |
| `.extractURLs({target : Text}) : Collection` | Extracts likely URLs and returns structured objects {url, protocol, host, port, path, valid}. |
| `.countWords(target : Text) : Integer` | Counts words in text using regex tokenization. |

### Compatibility note for trim helpers

4D now provides native string commands for this family:

- `Trim(aString)`
- `Trim start(aString)`
- `Trim end(aString)`

The class methods `.Trim()`, `.TrimLeading()` and `.TrimTrailing()` are kept for backward compatibility and fluent `cs.regex` usage.

Behavior check versus native 4D commands:

- Default behavior is aligned with native `Trim*`: they remove whitespace at string boundaries.
- Class methods add one extra capability: optional `char` lets you trim a specific literal character instead of generic whitespace.

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
- Optional `count` limits number of replacements.
- Optional `position` sets the start position (1-based) for replacement search.

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
