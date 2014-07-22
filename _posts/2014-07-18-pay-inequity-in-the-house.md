---
layout: post
title: Pay Inequity in the House
---
<div id="container1" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

While [congressional Republicans](http://www.huffingtonpost.com/2014/04/08/equal-pay-republcans_n_5111730.html) have been skeptical of the existence and causes of the gender wage gap, a significant gap exists in the compensation of female Republican staffers.

Although Democratic staffers are paid equally (women earn 99 cents on the dollar), female Republican staffers only earn 88 cents for every dollar earned by their male colleagues.

Over the past several months, a [number](http://www.theatlantic.com/business/archive/2013/05/the-biggest-myth-about-the-gender-wage-gap/276367/) of [political commentators](http://www.bloombergview.com/articles/2012-08-13/don-t-blame-discrimination-for-gender-wage-gap) have been [skeptical of the existence](http://www.nationalreview.com/agenda/369972/what-president-misses-gender-gap-reihan-salam) (and causes) of the gender wage gap.

The criticism, of course, has been loudest from Congress, where Rep Lynn Jenkins called Democrats' use of the issue 'condescending', Sen Mitch McConnell made a [comment](http://thinkprogress.org/home/2014/04/08/3424354/mcconnell-equal-pay-blowing-kisses/) about the issue 'blow[ing] kisses to their powerful pals on the left', and House Majority Leader Eric Cantor (R-VA) pointed out that the White House had its own pay [gap](http://www.nytimes.com/2014/04/08/us/politics/as-obama-spotlights-gender-gap-in-wages-his-own-payroll-draws-scrutiny.html).

A quick review of the literature indicates that the pay gap is [real](http://www.bls.gov/cps/cpsaat39.pdf), [large](http://web.stanford.edu/group/scspi/_media/pdf/key_issues/gender_research.pdf), and likely due to [discrimination](http://www.aauw.org/research/graduating-to-a-pay-gap/). For a quick review, see [thinkprogress](http://thinkprogress.org/economy/2014/04/08/3424043/gender-wage-gap-myth/). There are certainly [methodological](http://www.politifact.com/truth-o-meter/statements/2014/jan/29/barack-obama/barack-obama-state-union-says-women-make-77-cents-/) issues with the <em>exact</em> size of the gap, but the basic claim is most certainly accurate.

<strong>So I wondered... how large is the pay gap among congressional staffers?  Are there differences in how Republicans and Democrats pay their staffers?</strong>

I was able to collect information on employee compensation from the [the House Expenditures data](http://disbursements.house.gov/archive.shtml) going back to 2009. Because I'm interested in how House Representatives pay their staff, I'll exclude staffers that work for institutions in Congress (like committee / leadership staffers).

## Overall Breakdown
From 2009-2014 I have data on 59,165 staffers. Of these, 52% are women.

<table style="text-align:center"><tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left">year</td><td>men</td><td>women</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left">2009</td><td>4452</td><td>5179</td></tr>
<tr><td style="text-align:left">2010</td><td>5031</td><td>5878</td></tr>
<tr><td style="text-align:left">2011</td><td>5191</td><td>5540</td></tr>
<tr><td style="text-align:left">2012</td><td>4977</td><td>5366</td></tr>
<tr><td style="text-align:left">2013</td><td>4846</td><td>5160</td></tr>
<tr><td style="text-align:left">2014</td><td>3652</td><td>3893</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr></table>

Overall, from 2010-2013 the average female staffer earned only 93 cents for every dollar made by male staffers.  (This is statistically indistinguishable from the [White House average](http://icsulam.github.io/2014/07/04/white-house-salary/) over the same time period of 92 cents on the dollar.)

So how do the two parties compare?

<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

While pay for female and male Democratic staffers is nearly identical ($148 vs $149, or just over 99 cents on the dollar)... Republican pay falls far behind. Female Republican staffers earn 88 cents for every dollar earned by male Republican staffers. The effect is so large that while male Republican staffers are better-paid than male Democratic staffers, overall Republicans spend less on staff.  (For the stats nerds: Democratic pay is statistically indistinguishable, but the effect of gender on Republicans pay is statistically significant.)

One objection might be that staffers work wildly different schedules on the Hill. Year-round staff might be expected to be compensated differently than staffers with wide-ranging schedules. Interestingly, this actually widens the gender gap: to 97 cents for year-round female Democratic and 84 cents for year round female Republican staffers... a remarkable 13 cent party-gender gap.

Similarly, looking at year-round staffers with medians instead of means (a bad idea - but more on this in a later post), female Democratic staffers earn a bit more than men - 1.02 cents on the dollar - while female Republican staffers continue to earn less - 91 cents on the dollar.

## Female Representatives
Overall, female members of the House of Representatives pay their staff more equally than their male counterparts. Women working for female representatives are at pay equity to their male counterparts.  Women working for male representatives, however, earn 93 cents on the dollar.

<div id="container2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

Breaking the data down by party, women do best working for Democratic female representatives, where they earn slightly more than men - 1.06 cents on the dollar. They do worst working for Republican women - 85 cents on the dollar.

## Thoughts
We get the Congress we pay for.

These results are unnerving, to say the least. Congress is - after all - constitutionally charged with responsibly running the country. And yet - while Democrats are able to compensate their staff equitably, their Republican counterparts are far behind.

Does this influence how they vote?  Who they listen to?  I'm definitely interested to find out.


### Caveats
A number of corrections had to be made to put the disclosure documents into a usable format. The data is [messy and incomplete](http://sunlightfoundation.com/blog/2011/03/24/update-house-disbursements-few-notes-how-use-data/). House rules allow members to disclose expenditures up to [three years later](http://disbursements.house.gov/faqs.shtml). Pay is listed quarterly, each job has its own date ranges, and one staffer can have multiple listings within a single quarter. Some names and positions were misspelled ("District Communiations") or misleading (what does "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" as a job entail?). As a result, tracking staffers across quarters and jobs to accurately asses their pay is complicated. In my next post, I'll go through how cleaning the data that effects this analysis.

As always:

Questions?
Comments?
Concerns?

I'd love to hear them.

<!--- first plot-->

<script type="text/javascript">
$(function () {
    $('#container1').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'House of Representatives: Gender Pay Gap'
        },
        subtitle: {
            text: 'Source: disbursements.house.gov'
        },
        xAxis: {
            categories: [
                'Overall',
                'Democrats',
                'Republicans'
            ]
        },
        yAxis: [{
            min: 0,
            title: {
                text: 'Daily Pay ($)'
            }
        }],
        legend: {
            shadow: false
        },
        tooltip: {
            shared: true
        },
        plotOptions: {
            column: {
                grouping: false,
                shadow: false,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Men',
            color: 'rgba(165,170,217,1)',
            data: [151, 149, 153],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: 0.3,
            pointPlacement: -0.2
        }, {
            name: 'Women',
            color: 'rgba(248,161,63,1)',
            data: [141, 148, 134],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: .3,
            pointPlacement: 0.2
        }, {
            name: 'Men - Full Year',
            color: 'rgba(126,86,134,.9)',
            data: [170, 164, 176],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: 0.4,
            pointPlacement: -0.2,
            visible: false
        }, {
            name: 'Women - Full Year',
            color: 'rgba(186,60,61,.9)',
            data: [154, 159, 148],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: .4,
            pointPlacement: 0.2,
            visible: false
        }]
    });
});
</script>

<!--- second plot-->
<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'House of Representatives: Gender Pay Gap'
        },
        subtitle: {
            text: 'Source: disbursements.house.gov'
        },
        xAxis: {
            categories: [
                'Overall',
                'Democrats',
                'Republicans'
            ]
        },
        yAxis: [{
            min: 0,
            title: {
                text: 'Daily Pay ($)'
            }
        }],
        legend: {
            shadow: false
        },
        tooltip: {
            shared: true
        },
        plotOptions: {
            column: {
                grouping: false,
                shadow: false,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Men',
            color: 'rgba(165,170,217,1)',
            data: [151, 149, 153],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: 0.3,
            pointPlacement: -0.2
        }, {
            name: 'Women',
            color: 'rgba(248,161,63,1)',
            data: [141, 148, 134],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: .3,
            pointPlacement: 0.2
        }, {
            name: 'Men - Full Year',
            color: 'rgba(126,86,134,.9)',
            data: [170, 164, 176],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: 0.4,
            pointPlacement: -0.2,
            visible: false
        }, {
            name: 'Women - Full Year',
            color: 'rgba(186,60,61,.9)',
            data: [154, 159, 148],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: .4,
            pointPlacement: 0.2,
            visible: false
        }]
    });
});
</script>

<!--- third plot-->
<script type="text/javascript">
$(function () {
    $('#container2').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'House of Representatives: Gender Pay Gap'
        },
        subtitle: {
            text: 'By Gender of Representative (employer)'
        },
        xAxis: {
            categories: [
                'Female Representatives',
                'Male Representatives',
                'Female Representatives (D)',
                'Male Representatives (D)',
                'Female Representatives (R)',
                'Male Representatives (R)'
            ]
        },
        yAxis: [{
            min: 0,
            title: {
                text: 'Daily Pay ($)'
            }
        }],
        legend: {
            shadow: false
        },
        tooltip: {
            shared: true
        },
        plotOptions: {
            column: {
                grouping: false,
                shadow: false,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Men',
            color: 'rgba(165,170,217,1)',
            data: [ 148, 151, 147, 150, 151, 153],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: 0.3,
            pointPlacement: -0.2
        }, {
            name: 'Women',
            color: 'rgba(248,161,63,1)',
            data: [ 149, 140, 156, 145, 129, 134],
            tooltip: {
                valuePrefix: '$'
            },
            pointPadding: .3,
            pointPlacement: 0.2
        }]
    });
});
</script>