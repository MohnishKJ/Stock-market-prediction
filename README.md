# StockSense: Apple Inc. (AAPL) 📈

Shiny app that predicts Apple (AAPL) stock prices using historical data from Yahoo Finance.

## 🚀 What it does
- Fetches live historical stock data with one click
- Calculates 50-day and 200-day simple moving averages
- Forecasts adjusted closing prices for the next 10 days
- Visualizes price trends and forecasts on interactive charts

## ⚙️ How it works
- Pulls historical AAPL data from Yahoo Finance using quantmod
- Computes moving averages with TTR
- Builds a time series forecast model using the forecast package
- Renders plots and forecasts through a Shiny dashboard

## 🛠️ Tech Stack
- R
- Shiny
- quantmod
- TTR
- ggplot2
- forecast

## 📦 Setup
Install required packages:
```r
if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny")
if (!requireNamespace("quantmod", quietly = TRUE)) install.packages("quantmod")
if (!requireNamespace("TTR", quietly = TRUE)) install.packages("TTR")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("forecast", quietly = TRUE)) install.packages("forecast")
```

## 💡 Use case
Built to track AAPL price trends and get a short-term forecast without manually plotting moving averages each time.
