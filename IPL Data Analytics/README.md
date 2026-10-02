# IPL Data Analysis Using Python

## Project Overview

This project performs exploratory analysis of Indian Premier League (IPL) match and ball-by-ball data using **Python, Pandas, Matplotlib, and Seaborn**.

The analysis covers IPL seasons from **2008 to 2020** and examines match volume, scoring patterns, toss behavior, match results, and player performance.

## Dataset

Two datasets are used:

1. IPL match-level data
2. IPL ball-by-ball data

The notebook contains:

- **816 matches**
- **193,468 ball-by-ball records**

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Analysis |
| Pandas | Data manipulation |
| NumPy | Numerical analysis |
| Matplotlib | Visualization |
| Seaborn | Statistical visualization |
| Jupyter Notebook | Analysis workflow |

## Project Structure

```text
IPL Data/
└── python/
    └── IPL Data Analysis using Python.ipynb
```

## Analysis Performed

### Match Analysis

The notebook examines:

- Number of matches
- Cities
- Teams
- Venues
- Seasons
- Match results

### Season Analysis

The analysis calculates the number of matches played in each season.

| Season | Matches |
|---|---:|
| 2008 | 58 |
| 2009 | 57 |
| 2010 | 60 |
| 2011 | 73 |
| 2012 | 74 |
| 2013 | 76 |
| 2014 | 60 |
| 2015 | 59 |
| 2016 | 60 |
| 2017 | 59 |
| 2018 | 60 |
| 2019 | 60 |
| 2020 | 60 |

### Run Analysis

Ball-by-ball data is joined with season information to calculate total runs by season and runs scored per match.

### Toss Analysis

The notebook analyzes:

- Toss wins by team
- Toss decisions across seasons
- Relationship between toss winner and match winner

### Match Result Analysis

Observed match result categories include:

| Result | Matches |
|---|---:|
| Wickets | 435 |
| Runs | 364 |
| Tie | 13 |

The notebook also explores venues and winning teams associated with run and wicket victories.

### Player Analysis

The notebook analyzes:

- Player dismissal patterns
- Top run scorers
- Player of the Match awards

The top 10 run scorers identified in the notebook are:

| Rank | Player | Runs |
|---|---|---:|
| 1 | V Kohli | 5,878 |
| 2 | SK Raina | 5,368 |
| 3 | DA Warner | 5,254 |
| 4 | RG Sharma | 5,230 |
| 5 | S Dhawan | 5,197 |
| 6 | AB de Villiers | 4,849 |
| 7 | CH Gayle | 4,772 |
| 8 | MS Dhoni | 4,632 |
| 9 | RV Uthappa | 4,607 |
| 10 | G Gambhir | 4,217 |

## Key Analytical Questions

1. How did the number of matches vary by season?
2. How did total scoring vary across seasons?
3. How did runs per match change over time?
4. Which teams won the most tosses?
5. How did toss decisions vary across seasons?
6. How were matches distributed between run and wicket victories?
7. Which players accumulated the most runs in the analyzed data?
8. Which players received the most Player of the Match awards?
9. What dismissal patterns can be observed for selected players?

## Data Quality

The notebook performs missing-value checks for both match-level and ball-by-ball datasets.

The match dataset contains some missing values in fields such as:

- City
- Player of the Match
- Winner
- Result
- Result Margin
- Method

The ball-by-ball dataset contains expected missing values in fields such as dismissal, fielder, and extras-related columns where those events did not occur.

## Important Limitation

The analysis covers data through the **2020 IPL season**. It should not be interpreted as a current IPL performance analysis.

The project is exploratory and descriptive rather than a predictive model.

## Skills Demonstrated

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Exploratory Data Analysis
- Data Cleaning
- Data Transformation
- GroupBy analysis
- Data Visualization
- Sports Analytics
