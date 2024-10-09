[![language](https://img.shields.io/static/v1?label=language&message=4d&color=blue)](https://developer.4d.com/)
[![language](https://img.shields.io/github/languages/top/vdelachaux/Regex-with-Classes.svg)](https://developer.4d.com/)
![code-size](https://img.shields.io/github/languages/code-size/vdelachaux/Regex-with-Classes.svg)
[![license](https://img.shields.io/github/license/vdelachaux/Regex-with-Classes)](LICENSE)

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
