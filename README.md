# Stock Market Prediction: Apple Inc. (AAPL)

This Shiny application predicts stock prices for Apple Inc. (AAPL) using historical data from Yahoo Finance. It calculates moving averages and provides a 10-day forecast of adjusted closing prices.

## Features

- **Fetch Historical Data**: Click the "Fetch Data" button to retrieve the latest stock prices.
- **Visualizations**: 
  - Displays the adjusted closing price along with 50-day and 200-day simple moving averages.
  - Provides a 10-day forecast of adjusted closing prices.

## Requirements

Ensure you have the following R packages installed:

- shiny
- quantmod
- TTR
- ggplot2
- forecast

You can install the required packages by running the following commands in R:

```r
if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny")
if (!requireNamespace("quantmod", quietly = TRUE)) install.packages("quantmod")
if (!requireNamespace("TTR", quietly = TRUE)) install.packages("TTR")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("forecast", quietly = TRUE)) install.packages("forecast")
