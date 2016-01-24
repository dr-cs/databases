# intro-databases
Jekyll source for website containing course materials for Introduction to Databases course

# Slides

Slides are written in Markdown and converted to Reveal.js HTML using [Pandoc](http://pandoc.org/) to  [produce the slides](http://pandoc.org/README.html#producing-slide-shows-with-pandoc)

```sh
$ cd slides
$ pandoc -s --mathjax -t revealjs -V theme=gt -V slideNumber=true -V progress=true -o database-concepts.html database-concepts.md

```
