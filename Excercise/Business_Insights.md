# Business Insights

## IPL Data Analysis Using Python

### Executive Summary

This project analyzes IPL match-level and ball-by-ball data from **2008 through 2020**.

The dataset contains:

- **816 matches**
- **193,468 ball-by-ball records**

The analysis examines season activity, scoring, toss behavior, match outcomes, and player performance.

---

# 1. Season Activity

The number of matches varied by season.

The highest match counts in the analyzed data were:

- 2013: 76 matches
- 2012: 74 matches
- 2011: 73 matches

Several later seasons in the dataset contain 60 matches.

### Business Insight

Match volume should be considered when comparing season-level totals.

A season with more matches naturally has more opportunities to accumulate runs and other match-level statistics.

---

# 2. Run Scoring Across Seasons

The notebook joins match and ball-by-ball data to calculate total runs by season.

For example:

| Season | Matches | Total Runs |
|---|---:|---:|
| 2008 | 58 | 17,937 |
| 2009 | 57 | 16,320 |
| 2010 | 60 | 18,864 |
| 2011 | 73 | 21,154 |

The notebook also calculates **runs scored per match** to provide a normalized comparison between seasons.

### Business Insight

Runs per match is more useful for comparing scoring intensity across seasons with different numbers of matches than total runs alone.

---

# 3. Toss Analysis

The project analyzes toss winners and toss decisions across seasons.

It also compares the toss winner with the eventual match winner.

### Business Insight

The toss is an important match-context variable and can be explored alongside the final result.

However, the notebook's analysis is descriptive; it does not establish that winning the toss causes a team to win the match.

---

# 4. Match Result Patterns

Among the analyzed matches with a recorded result:

- **435** were won by wickets
- **364** were won by runs
- **13** were ties

### Business Insight

Both batting-first and chasing victories form substantial portions of the analyzed match outcomes.

The distribution provides useful context for understanding how IPL matches were commonly decided during the 2008–2020 period.

---

# 5. Venue Analysis

The notebook examines venues associated with different result types.

For matches not decided by runs, the most frequently represented venue in the notebook's analysis is **Eden Gardens**.

For matches not decided by wickets, the most frequently represented venue is **Feroz Shah Kotla**.

### Business Insight

Venue-level analysis can help identify differences in match-result patterns across grounds.

These observations should be interpreted descriptively because venue conditions, team composition, season, and match context can all affect outcomes.

---

# 6. Player Performance

The ball-by-ball analysis identifies the top 10 run scorers in the dataset.

The leading run totals are:

| Player | Runs |
|---|---:|
| V Kohli | 5,878 |
| SK Raina | 5,368 |
| DA Warner | 5,254 |
| RG Sharma | 5,230 |
| S Dhawan | 5,197 |

The remaining players in the top 10 include:

- AB de Villiers
- CH Gayle
- MS Dhoni
- RV Uthappa
- G Gambhir

### Business Insight

Long-term run accumulation highlights players with sustained batting output across the analyzed period.

However, total runs are influenced by number of seasons, matches, innings, and opportunities, so they should not be interpreted as a standalone measure of batting efficiency.

---

# 7. Player of the Match Analysis

The notebook calculates Player of the Match award frequencies.

### Business Insight

Player of the Match counts provide a descriptive measure of how frequently players were recognized as major contributors to individual match outcomes.

The metric is different from total runs because an award can reflect contributions from batting, bowling, fielding, or overall match impact.

---

# 8. Selected Player Analysis

The notebook includes a specific dismissal analysis for **V Kohli**.

This demonstrates how ball-by-ball data can be filtered to investigate an individual player's dismissal patterns.

### Business Insight

Ball-level data allows analysis at a much deeper level than match-level data alone.

Potential extensions include:

- Dismissal type by season
- Runs by venue
- Strike rate by phase
- Performance against specific teams
- Bowling matchup analysis

---

# 9. Business / Analytical Applications

Although this is a sports analytics project, the same analytical workflow demonstrates general Data Analyst skills:

### Performance Analysis

Track individual and team performance over time.

### Trend Analysis

Compare metrics across seasons.

### Segmentation

Break performance down by team, player, venue, or season.

### Normalization

Use metrics such as runs per match rather than relying only on raw totals.

### Event-Level Analytics

Use ball-by-ball data to move from high-level reporting to granular analysis.

---

# 10. Important Limitations

- The analysis covers IPL data through the **2020 season**.
- It should not be interpreted as a current IPL performance analysis.
- Total runs are affected by opportunities and number of matches played.
- Toss analysis is observational and does not establish causality.
- Venue patterns can be affected by team composition, season, scheduling, and match conditions.
- The project is exploratory rather than predictive.

---

# Conclusion

This project demonstrates an end-to-end sports analytics workflow using Python.

The analysis connects:

**Match Data → Season Trends → Scoring → Toss → Match Results → Player Performance → Ball-by-Ball Analysis**

It demonstrates practical skills in:

- Data cleaning
- Pandas
- GroupBy analysis
- Dataset merging
- Exploratory data analysis
- Visualization
- Performance analytics
- Business-style insight generation
