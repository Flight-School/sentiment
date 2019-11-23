# sentiment

`sentiment` is a command-line utility that
evaluates the emotional sentiment of natural language text.

```terminal
$ echo "With a comfortable fit, great sound, and awesome noise canceling, these are the best AirPods ever." | sentiment
1.0

$ echo "No wireless, less space than a Nomad. Lame." | sentiment
-0.8
```

---

For more information about natural language processing,
check out Chapter 7 of the
[Flight School Guide to Swift Strings](https://flight.school/books/strings).

---

## Requirements

- macOS 10.15+

## Installation

Install `sentiment` with [Homebrew](https://brew.sh) using the following command:

```terminal
$ brew install flight-school/formulae/sentiment
```

## Usage

Text can be read from either standard input or file arguments,
and named entities are written to standard output on separate lines.

### Reading from Piped Standard Input

```terminal
$ echo "It was a good day." | sentiment
0.4

```

### Reading from Standard Input Interactively

```terminal
$ sentiment
Great!
1.0
```

### Reading from a File

```terminal
$ head -n 1 anna_karenina.txt
Happy families are all alike; every unhappy family is unhappy in its own way.

$ sentiment anna_karenina.txt
-0.400151

```

> **Note**: `sentiment` can take a long time for large documents.

```terminal
$ time sentiment anna-karenina.txt
-0.400151
       33.44 real        61.84 user         4.62 sys

```

## Advanced Usage

`sentiment` can be used with `ls`, `find` and other Unix commands
to analyze the sentiment of multiple files at once.

### Performing Sentiment Analysis for Multiple Files

```terminal
$ find . -iname '*.txt' -exec \
    sh -c 'printf "%s\t%s\n" {} $(sentiment {})' \;
./positive.txt	1.0
./somewhat-negative.txt	-0.5
./neutral.txt	0.0

```

## Additional Details

If the command is able to determine an emotional sentiment for the provided text,
it writes a number between `-1.0` (negative) and `1.0` (positive)
to standard output (`0.0` indicates neutral or unknown sentiment).
The resulting number has an unlocalized format
consisting of an optional leading minus sign `-` (U+002D HYPHEN-MINUS)
followed by a decimal point `.` (U+002E FULL STOP)
and between one and six decimal digits `0` – `9` (U+0030 – U+0039):

```regexp
^-?[01]\.\d{1,6}$
```

`sentiment` uses
[`NLTagger`](https://developer.apple.com/documentation/naturallanguage/nltagger)
with the
[`sentimentScore`](https://developer.apple.com/documentation/naturallanguage/nltagscheme/3113856-sentimentscore)
tag scheme.
The overall sentiment of a text input is calculated from
the average sentiment of each paragraph.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
