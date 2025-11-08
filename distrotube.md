# Linux Administration
# DistroTube

## channel
## YouTube

### segment
### DistroTube

#### surface
#### Sed

##### https://youtu.be/D7aDAXWi5SM

###### Replace occurrences of a pattern with a substitute?

```sh
sed 's/<pattern>/<substitute>/g' <file>
```

###### Replace occurrences of a pattern with a substitute without case sensitivity?

```sh
sed 's/<pattern>/<substitute>/gi' <file>
```

###### Use extended regular expressions on sed?

```sh
sed -E 's/<pattern>/<substitute>/g' <file>
```

###### Capitalize occurrences of a pattern?

```sh
sed -E 's/(<pattern>)/\U\1/g' <file>
```

###### Combine multiple sed statements?

```sh
sed -e '<command>' -e '<command>' ... <file>
```

###### Write changes of sed command inplace?

```sh
sed -i '<command>' <file>
```

###### Use sed to print a range of lines?

```sh
sed -n '1,10p' <file>
```

This command is similar to what `head` does.

###### Print lines containing occurrences of a pattern?

```sh
sed -n '/<pattern>/p' <file>
```

This command is similar to what `grep` does.

###### Delete lines containing occurrences of a pattern?

```sh
sed '/<pattern>/d' <file>
```

###### Make a backup of the original file while in a sed command?

```sh
sed -i.bak '<command>' <file>
```

The `<file>.bak` holds unchanged content of the `<file>`.

###### Remove empty lines in a file?

```sh
sed '/^[[:space:]]*$/d" <file>
```

###### Add a line on top of a file?

```sh
sed -i '1i <line>' <file>
```

###### Write a line after a pattern match?

```sh
sed -i '/<pattern>/a <line>' <file>
```
