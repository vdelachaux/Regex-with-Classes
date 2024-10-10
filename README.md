<!-- MARKDOWN LINKS & IMAGES -->
[release-shield]: https://img.shields.io/github/v/release/vdelachaux/Regex-with-classes?include_prereleases
[release-url]: https://github.com/vdelachaux/Regex-with-classes/releases/latest
[license-shield]: https://img.shields.io/github/license/vdelachaux/Regex-with-classes
[build-shield]: https://github.com/vdelachaux/Regex-with-classes/actions/workflows/build.yml/badge.svg
[build-url]: https://github.com/vdelachaux/Regex-with-classes/actions/workflows/build.yml

<!--BADGES-->
![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)  ![Static Badge](https://img.shields.io/badge/rgx-blue)
<br>
[![release][release-shield]][release-url]
[![license][license-shield]](LICENSE)
<img src="https://img.shields.io/github/downloads/vdelachaux/Regex-with-classes/total"/>

# Regex-with-Classes

The goal of this class is to reduce the complexity of code to use [Regex](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://en.wikipedia.org/wiki/Regular_expression&ved=2ahUKEwj49OCo2oOJAxWmaqQEHdRhIZoQFnoECAkQAQ&usg=AOvVaw1UpX3CvTAA_-Exd80mQacg) in 4D.

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

## Documentation

The complete class documentation is available [here](Documentation/Classes/regex.md) and is also displayed in the Explorer documentation panel.     


The [***test_regex***](Project/Sources/Methods/test_regex.4dm) method will help you learn how to use it.

# Installation

## ![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components) ![Static Badge](https://img.shields.io/badge/rgx-blue)

This repository is compatible with the [Project dependencies](https://developer.4d.com/docs/Project/components#monitoring-project-dependencies) feature. So you can simply integrate this component into your project by selecting `Design` > `Project dependencies` and adding `vdelachaux/regex-with-classes` as the repository address in the dedicated dialog box. **This way, you can benefit from updates over time**.

The published namespace is "**rgx**", so the class instantiation in your project will therefore be:

```4d
$regex:=cs.rgx.regex.new()
```

## Copy of the class

Copy into your database folder:

* The `regex.4dm` file from this repository to the `~/Project/Sources/Classes/` folder
* The `regex.md` file from this repository to the `~/Documentation/Classes/` folder

The class instantiation will therefore be:

```4d
$regex:=cs.regex.new()
```
⚠️ In this case, you'll need to check the repository regularly for updates, subscribe to it to receive update notifications, or clone it. You'll then need to transfer the changes to your project.

# Contributing
This class will be augmented according to _my needs_ but I strongly encouraged you to enrich this project through [pull request](https://github.com/vdelachaux/Regex-with-Classes/pulls). This can only benefit the [4D developer community](https://discuss.4d.com)


> 📌 This code is an evolution of the [regex](https://github.com/vdelachaux/regex.4dbase) component.

# References

## 4D documentation
* [Match regex](https://doc.4d.com/4Dv20/4D/20.5/Match-regex.301-7388377.en.html)
* [Declaring components stored on GitHub](https://developer.4d.com/docs/Project/components#declaring-components-stored-on-github)
* [Monitoring Project Dependencies](https://developer.4d.com/docs/Project/components#monitoring-project-dependencies)

## Regex documentation

* [ICU Regular Expressions](https://unicode-org.github.io/icu/userguide/strings/regexp.html)
* [Mastering Regular Expressions](https://www.oreilly.com/library/view/mastering-regular-expressions/0596528124/)
* [Wikipedia](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://en.wikipedia.org/wiki/Regular_expression&ved=2ahUKEwj49OCo2oOJAxWmaqQEHdRhIZoQFnoECAkQAQ&usg=AOvVaw1UpX3CvTAA_-Exd80mQacg)

## Tools

* [RegexLab](https://github.com/AJARProject/AJ_Tools_Regex) component
* macOS [RegExRX](https://apps.apple.com/fr/app/regexrx/id498370702?l=en-GB&mt=12). An application I use regularly to test my Regex. It allows you to copy them, once finalized in a format compatible with 4D's code editor, and even to copy the FR or US code like this:

```4d
ARRAY LONGINT($rxPositions;0)
ARRAY LONGINT($rxLengths;0)
$rxPattern:="(?mi-s)world"
$rxMatch:=Match regex($rxPattern;$sourceText;1;$rxPositions;$rxLengths)
```

#  

`Enjoy the 4th dimension`
