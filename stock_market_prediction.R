# Install and load necessary packages
if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny")
if (!requireNamespace("quantmod", quietly = TRUE)) install.packages("quantmod")
if (!requireNamespace("TTR", quietly = TRUE)) install.packages("TTR")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("forecast", quietly = TRUE)) install.packages("forecast")

library(shiny)
library(quantmod)
library(ggplot2)
library(zoo)
library(forecast)
library(TTR)

# Define UI for the application
ui <- fluidPage(
  titlePanel("Stock Market Prediction: Apple Inc. (AAPL)", windowTitle = "Stock Market Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Controls"),
      actionButton("update", "Fetch Data", class = "btn-primary"),
      br(),
      br(),
      helpText("Click the button above to fetch the latest stock data and see the predictions.")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Stock Prices",
                 plotOutput("pricePlot", height = "400px")
        ),
        tabPanel("Forecast",
                 plotOutput("forecastPlot", height = "400px")
        )
      )
    )
  ),
  
  # Custom CSS for styling
  tags$head(
    tags$style(HTML("
            body {
                background-color: #f5f5f5;
                font-family: Arial, sans-serif;
            }
            h4 {
                color: #333;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }
            .tab-panel {
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .shiny-plot-output {
                border: 1px solid #ddd;
                background-color: #fff;
                border-radius: 4px;
            }
        "))
  )
)

# Define server logic
server <- function(input, output) {
  
  observeEvent(input$update, {
    # Fetch historical stock data for Apple Inc. (AAPL)
    getSymbols("AAPL", from = "2020-01-01", to = Sys.Date(), src = "yahoo")
    
    # Calculate Daily Returns
    AAPL_clean <- data.frame(Date = index(AAPL), AAPL.Adjusted = Ad(AAPL), AAPL.Volume = Vo(AAPL))
    AAPL_clean$Returns <- c(NA, diff(log(AAPL_clean$AAPL.Adjusted)))  # Daily returns
    AAPL_clean <- na.omit(AAPL_clean)  # Remove missing values
    
    # Calculate Moving Averages using TTR
    AAPL_clean$SMA_50 <- SMA(AAPL_clean$AAPL.Adjusted, n = 50)
    AAPL_clean$SMA_200 <- SMA(AAPL_clean$AAPL.Adjusted, n = 200)
    
    # Create the price plot
    output$pricePlot <- renderPlot({
      ggplot(data = AAPL_clean, aes(x = Date)) +
        geom_line(aes(y = AAPL.Adjusted), color = "blue", size = 1, alpha = 0.7) +
        geom_line(aes(y = SMA_50), color = "orange", size = 1, linetype = "dashed") +
        geom_line(aes(y = SMA_200), color = "red", size = 1, linetype = "dashed") +
        labs(title = "Apple Inc. Stock Price with Moving Averages",
             subtitle = "Blue: Adjusted Close Price | Orange: 50-Day MA | Red: 200-Day MA",
             x = "Date",
             y = "Price (USD)") +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5, size = 16),
              plot.subtitle = element_text(hjust = 0.5, size = 12))
    })
    
    # Fit ARIMA model on Adjusted Closing Prices
    model <- auto.arima(AAPL_clean$AAPL.Adjusted)
    
    # Forecast future values 
    forecast_values <- forecast(model, h = 10)  # Forecasting for 10 days
    
    # Create the forecast plot
    output$forecastPlot <- renderPlot({
      autoplot(forecast_values) +
        labs(title = "10-Day Forecast of AAPL Adjusted Closing Prices",
             x = "Date",
             y = "Price (USD)") +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5, size = 16))
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
