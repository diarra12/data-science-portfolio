This project explores the Diamonds dataset, which contains information on 54,000 diamonds sold in the U.S. Using pandas, numpy, and matplotlib, the notebook performs data cleaning, descriptive statistics, filtering, sorting, handling categorical variables, transformations, and visualizations.

PROJECT OVERVIEW:
My analysis focuses on 5 key columns: 
  - price (sale price in USD)
  - carat (weight of diamond)
  - cut (quality of cut Fair to Ideal)
  - color (tint level J to D)
  - clarity (internal defect rating I1 to IF)

PART ONE: Loading and Exploring the Dataset
  - Read tab-delimited file
  - Displayed head, shape, and descriptive statistics

PART TWO: Filtering and Sorting
  - Finding the most expensive and least expensive diamonds
  - Finding the largest diamonds by cut type

PART THREE: Working with Categorical Variables
  - Defining the ordered levels
  - Converting columns to ordered categorical types
  - Created color palettes for graphing

PART FOUR: Category Counts
  - Counted the diamonds by their cut, color, and clarity

PART FIVE: Scatterplots
  - Analyzed price vs carat
  - Analyzed price vs carat by colored clarity
  - Created subplots for each clarity level

PART SIX: Log Transformations
  - Add ln_price and ln_carat
  - Histograms of original vs log variables

PART SEVEN: Scatterplot of Transformed Variables
  - Log price vs log carat
  - Relationship becomes approximately linear

PARTS EIGHT-TEN: Grouping and Bar Charts
  - Mean price and carat by cut, color, and clarity
  - Visualized with bar charts

_________________________________________________________________________________________________

KEY INSIGHTS:
  - Higher quality diamonds tend to be smaller, which lowers their average price
  - Carat size has a stronger impact on price than cut, color, or clarity
  - Log transformations reveal the linear relationship between price and carat

_____________________________________________________________________________________________________

NOTEBOOK LINK:
