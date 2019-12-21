# find commands

## find files print size and full path to the file; then sort the list
```shell
$find . -type f -printf "%s\t%p\n" | sort -n
```

## 100k file size
```shell
$ find . -size +102400 -type f
```

## find 10k file size
```shell
$ find . -size +10240 -type f
```

## find files modified 3 days old or less
```shell
$ find . -type f -mtime -3 -exec ls -l {} \;
```

## fine files created 1 days old or less
```shell
$ find . -type f -ctime -1 -exec ls -l {} \;
```

## find dot directories
```shell
$ find . -type d -iname ".*" -ls
```

## find files with spaces
```shell
$ find . -type f -exec egrep -l " +$" {} \;
```

## find java src files and convert them from dos2unix
```shell
$ find . -type f -name "*.java" -exec dos2unix {} \;
```
## find with depth
```shell
$ find .  -mindepth 1 -maxdepth 1 -type d
```
