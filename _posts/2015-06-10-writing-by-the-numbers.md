---
layout: post
title: Insight Project: Writing by the Numbers
---

Four in five Americans want to write a book ['at some point in their lives'](http://www.nytimes.com/2002/09/28/opinion/think-you-have-a-book-in-you-think-again.html). But before tackling a novel-length project, they're advised to learn tradecraft by writing short stories.

But how to write better short stories?

Statistics can help.

These files explain the data cleansing, exploratory analysis, preprocessing and feature engineering used to explore these stories.

1.  Perl files

  ..* [pull prompts from reddit](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/00-redditScrape.pl)

  ..* [pull comments from reddit](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/01-commentScrape.pl)

  ..* [clean prompts, convert to CSV](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/02-promptJsonToCsv.pl)

  ..* [clean comments, convert to CSV](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/03-commentParse.pl)

2.  R files

  ..* [clean prompts, build features](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/analysis-0-promptLevel.R)

  ..* [clean comments, build features](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/analysis-1-commentLevel.R)

..* [data analysis and exploration](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/analysis-4-dataRunning.R)

3.  Python files (copies of R files)

  ..* [clean prompts, build features](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/writing_0_prompt_level.ipynb)

  ..* [clean comments, build features](https://github.com/icsulam/icsulam.github.io/blob/master/pdf/writing_1_comment_level.ipynb)


As a warning: github didn't want to store the complete pull from reddit. Email me if you're interested in getting the data!

As always:

Questions?
Comments?
Concerns?

I'd love to hear them.

