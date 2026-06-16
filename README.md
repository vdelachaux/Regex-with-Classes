# Regex-with-Classes

[![release](https://img.shields.io/github/v/release/vdelachaux/Regex-with-classes?include_prereleases)](https://github.com/vdelachaux/Regex-with-classes/releases/latest)
[![license](https://img.shields.io/github/license/vdelachaux/Regex-with-classes)](LICENSE)

`Regex-with-Classes` simplifies regular expression usage in 4D with a class-based API.

## What you get

- fluent setup: `setTarget()`, `setPattern()`, `setOptions()`
- core regex operations: `match()`, `extract()`, `substitute()`
- helper methods: `stripTags`, trim helpers, mail/date extraction, URL validation
- error tracking: `success`, `lastError`, `errors`

## Quick start

```4d
var $regex : cs.regex
$regex:=cs.regex.new("Hello world, the world is wonderful but the world is in danger"; "Hello (world)")

var $match : Boolean
$match:=$regex.match()  // True

var $c : Collection
$c:=$regex.extract()   // ["Hello world"; "world"]
$c:=$regex.extract(1)  // ["world"]

var $result : Text
$result:=$regex.substitute("Vincent")
// "Vincent, the world is wonderful but the world is in danger"
```

## Compatibility

- component usage through 4D Project Dependencies
- regex engine behavior follows ICU/4D `Match regex`
- `caseSensitve` is kept for compatibility, and `caseSensitive` is available as an alias

## Installation

### Preferred: Project Dependencies (`rgx` namespace)

Add `vdelachaux/regex-with-classes` in `Design > Project dependencies`.

Then instantiate with:

```4d
$regex:=cs.rgx.regex.new()
```

### Alternative: copy class files (`cs` namespace)

Copy:

- `Project/Sources/Classes/regex.4dm` to your `~/Project/Sources/Classes/`
- `Documentation/Classes/regex.md` to your `~/Documentation/Classes/`

Then instantiate with:

```4d
$regex:=cs.regex.new()
```

## Documentation and tests

- Full class documentation: [Documentation/Classes/regex.md](Documentation/Classes/regex.md)
- Usage examples/tests: [Project/Sources/Methods/test_regex.4dm](Project/Sources/Methods/test_regex.4dm)

## Error handling example

```4d
var $rgx : cs.regex
$rgx:=cs.regex.new("abc"; "(unclosed")

If (Not($rgx.match()))
  // inspect details from 4D/ICU
  ALERT("Regex error: "+$rgx.lastError.desc)
End if
```

## Contributing

Pull requests are welcome:

- [Open PRs](https://github.com/vdelachaux/Regex-with-Classes/pulls)
- [4D community](https://discuss.4d.com)

This project is an evolution of [regex.4dbase](https://github.com/vdelachaux/regex.4dbase).

## References

### 4D

- [Match regex](https://doc.4d.com/4Dv20/4D/20.5/Match-regex.301-7388377.en.html)
- [Declaring components stored on GitHub](https://developer.4d.com/docs/Project/components#declaring-components-stored-on-github)
- [Monitoring Project Dependencies](https://developer.4d.com/docs/Project/components#monitoring-project-dependencies)

### Regex

- [ICU Regular Expressions](https://unicode-org.github.io/icu/userguide/strings/regexp.html)
- [Mastering Regular Expressions](https://www.oreilly.com/library/view/mastering-regular-expressions/0596528124/)
- [Wikipedia: Regular expression](https://en.wikipedia.org/wiki/Regular_expression)

### Tools

- [RegexLab](https://github.com/AJARProject/AJ_Tools_Regex)
- macOS [RegExRX](https://apps.apple.com/fr/app/regexrx/id498370702?l=en-GB&mt=12)
