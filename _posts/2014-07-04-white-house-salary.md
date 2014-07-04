---
layout: post
title: Wages and Gender - Equality in the White House
---

![placeholder](_assets/p1-00-intro2014.png "First Image")

The Obama administration has made bridging the gender pay gap a priority, passing the [Lilly Ledbetter Act](http://en.wikipedia.org/wiki/Lilly_Ledbetter_Fair_Pay_Act_of_2009) in 2009 and continuing to promote the [Paycheck Fairness Act](http://www.nytimes.com/2014/03/21/us/politics/obama-to-promote-expanded-economic-opportunities-for-women.html).

Yet, critics often point to the gender wage gap of White House staff as evidence of a bit of hypocrisy ([Washington Post](http://www.washingtonpost.com/blogs/post-politics/wp/2014/04/07/the-white-houses-own-wage-gender-gap/), [AEI report](http://www.aei-ideas.org/2014/02/february-20-is-white-house-equal-pay-day-the-date-in-2014-women-must-work-to-earn-what-men-earned-in-2013/), [Daily Mail](http://www.dailymail.co.uk/news/article-2128513/Women-paid-significantly-Obama-White-House-male-counterparts.html), [NY Times](http://www.nytimes.com/2014/04/08/us/politics/as-obama-spotlights-gender-gap-in-wages-his-own-payroll-draws-scrutiny.html?_r=0)).  For example, in 2013, female White House employees made 93 cents for every dollar earned by their male counterparts.

But where does this gender pay gap come from? And how does it compare to previous administrations / the country as a whole?

## The Overall Picture

First, a look at White House employees wages over the past decade:

![placeholder](/assets/p1-01-median2014.png)

Even adjusting for inflation, average (median) incomes for White House employees have increased over the past decade, from 52,000 in 2003 to 70,000 in 2013. Most of this pay increase came in 2009, when the incoming Obama team was paid an average of 10k more than their Bush counterparts.

![ThirdGraph](/assets/p1-02-income2014.png)

These pay increases haven't been evenly distributed across all employees. Most of the pay increase went to the bottom half of White House employees (top 2 panels).  While the top 75% of employees did initially receive a pay bump when Obama entered office in 2009, their pay has since decreased back to roughly Bush administration levels (adjusting for inflation).

This has resulted in a slight increase in income equality among White House employees, as measured by the [Gini coefficient](http://en.wikipedia.org/wiki/Gini_coefficient).

## But back to gender...

Sadly, the White House doesn't include the gender (or race!) of its employees when providing salary information. Instead, I used the [Social Security Administration's baby names data](http://www.ssa.gov/oact/babynames/limits.html) to automatically code the gender of individuals based on their first name. For each name, I looked up the gender ratio of infants born with that name from 1975-1995. Most names sorted on clear gender lines (Mary-Ann, Mark,...). I hand coded the remaining ~3% of individuals with ambiguous / uncommon names (like [Kalpenn](http://en.wikipedia.org/wiki/Kal_Penn)).

![FourthGraph](/assets/p1-03-gender2014.png)

From this, women are almost exactly half (50.8%) of all White House employees.

Unfortunately, their pay isn't as equal. Currently (2014), women make 90 cents for every dollar that men do. This is better than the [national average](http://www.iwpr.org/publications/pubs/the-gender-wage-gap-2012/) of 77 cents on the dollar. The gender pay gap is also about half the size under Obama as it was under Bush. During the Bush White House, women made from 73-82 cents on the dollar.

But do men and women at equivalent roles earn equivalent salaries?

The trouble is measuring 'equivalent roles'.

Many positions only occur for one year, like "Director of Lessons Learned" (2006). Often, promotions are accompanied by added titles, for example, the Director of White House Operations (75k) was promoted to Director of White House Operations and Advisor for Management and Administration (85k). Effectively, for many jobs, there is no way to find an 'equivalent' to compare to.

Instead, positions can be grouped by a rough 'job title' (lawyer, director, deputy director,...).

![FifthGraph](/assets/p1-04-summaryPlot.png)

Within each position,  women make approximately the same as men. For 2014, in 9 of 13 job titles, women earn 91-106% of men in those positions. The four exceptions are Deputy Directors (88%), Associate Directors (120%), staff listed as 'senior' - like "Senior Policy Advisor" (112%), and lawyers (114%). Yet in three of these four positions, women make considerably more than men. So women are paid (roughly) the same as men working in equivalent roles.

The gender pay gap arises because women are less likely to hold top positions. For 2014, there are more men in the top four paying fields: 'Assistant to the President' (56% men), 'Deputy Assistant' (52% men), 'lawyers' (52% men), and 'Special Assistant to the President' 69% men).

Yet this is more balanced than at any point over the past decade.

## Conclusions?

Putting it all together (for the stats-minded: via regressions of income on gender, party, and job title), over the past decade, about 75% of the gender gap at the White House is due to women having lower-paying positions, and 25% is due to differences in pay within each position. This is true for both the Obama and Bush administrations.

Just to be painfully clear: another way of saying this is that women are under-represented in the highest (most influential?) jobs at the White House.

Questions?
Comments?
Concerns?

I'd love to hear them.


Data via [Socrata](https://opendata.socrata.com/) for 2009 - 2013 and the Washington Post for [2003 - 2008](http://www.washingtonpost.com/wp-srv/opinions/graphics/2008stafflistsalary.html).

NOTES:
* I'll update this when the 2014 data is released.
* If anyone has data from 1995-2002, I'd love to work with it. Unfortunately, my google-powers were not strong enough to locate them. 