# intro-databases
Jekyll source for website containing course materials for Introduction to Databases course

# Slides

Slides are written in Markdown and converted to Reveal.js HTML using [Pandoc](http://pandoc.org/) to  [produce the slides](http://pandoc.org/README.html#producing-slide-shows-with-pandoc)

```sh
$ cd slides
$ pandoc -s --mathjax -t revealjs -V theme=gt -V slideNumber=true -V progress=true -o database-concepts.html database-concepts.md

```

To generate all the slides:

```sh
$ for file in `ls *.md`; do pandoc -s --mathjax -t revealjs -V theme=gt -V slideNumber=true -V progress=true -o $(basename $file .md).html $file; done
```

# ER Diagrams

To the extent possible, I store data in plain text files. It's possible to create ER diagrams using Graphviz.

```sh
dot -Tsvg -o humane-society.svg humane-society.dot
```