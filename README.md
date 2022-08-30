# Regex-with-Classes

The goal of this class is to reduce the complexity of code to use Regex in 4D.
<br/>This class will be augmented according to my needs but I strongly encouraged you to enrich this project through [pull request](https://github.com/vdelachaux/Regex-with-Classes/pulls). This can only benefit the [4D developer community](https://discuss.4d.com/search?q= regex).

See the [documentation](Documentation/Classes/regex.md) (also available via the Explorer's documentation panel) or the method [***test_regex***](Project/Sources/Methods/test_regex.4dm) to learn how to use it.

> 📌 This code is an evolution of the [regex](https://github.com/vdelachaux/regex.4dbase) component.

`Enjoy the 4th dimension`

## Code sample

```4d
var $regex : cs.regex$regex:=cs.regex.new("Hello world, the world is wonderful but the world is in danger"; "Hello (world)")var $match : Boolean$match:=$regex.match()  // = Truevar $c : Collection$c:=$regex.extract()  // = [ "Hello world", "world" ]$c:=$regex.extract(1)  // = [ "world"]var $result : Text$result:=$regex.substitute("Vincent")  // = "Vincent, the world is wonderful but the world is in danger"
```
