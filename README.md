<!-- MARKDOWN LINKS & IMAGES -->
[release-shield]: https://img.shields.io/github/v/release/vdelachaux/Regex-with-classes?include_prereleases
[release-url]: https://github.com/vdelachaux/Regex-with-classes/releases/latest
[license-shield]: https://img.shields.io/github/license/vdelachaux/Regex-with-classes
[build-shield]: https://github.com/vdelachaux/Regex-with-classes/actions/workflows/build.yml/badge.svg
[build-url]: https://github.com/vdelachaux/Regex-with-classes/actions/workflows/build.yml

<!--BADGES-->
![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)
<br>
[![release][release-shield]][release-url]
[![license][license-shield]](LICENSE)
<img src="https://img.shields.io/github/downloads/vdelachaux/Regex-with-classes/total"/>

# Regex-with-Classes

The goal of this class is to reduce the complexity of code to use Regex in 4D.

The complete class documentation is available [here](Documentation/Classes/regex.md) and is also displayed in the Explorer documentation panel.     



The [***test_regex***](Project/Sources/Methods/test_regex.4dm) method will help you learn how to use it.

This class will be augmented according to my needs but I strongly encouraged you to enrich this project through [pull request](https://github.com/vdelachaux/Regex-with-Classes/pulls). This can only benefit the [4D developer community](https://discuss.4d.com)

`Enjoy the 4th dimension`

> 📌 This code is an evolution of the [regex](https://github.com/vdelachaux/regex.4dbase) component.

## Code sample

```4d
var $regex : cs.regex
$regex:=cs.regex.new("Hello world, the world is wonderful but the world is in danger"; "Hello (world)")

var $match : Boolean
$match:=$regex.match()  // = True

var $c : Collection
$c:=$regex.extract()  // = [ "Hello world", "world" ]
$c:=$regex.extract(1)  // = [ "world"]

var $result : Text
$result:=$regex.substitute("Vincent")  // = "Vincent, the world is wonderful but the world is in danger"
```
