#Author: Brandon Perez
#Purpose: Homework 4

library(tidyverse)

myFile <- file.choose()
finance <- read.csv(myFile, header = TRUE, stringsAsFactors = FALSE)
colnames(finance)

#clean up the column names so they are easier to work with
finance <- finance %>% rename(
  date = Date,
  index = Stock.Index,
  open = Open.Price,
  close = Close.Price,
  high = Daily.High,
  low = Daily.Low,
  volume = Trading.Volume,
  gdp = GDP.Growth....,
  inflation = Inflation.Rate....,
  unemployment = Unemployment.Rate....,
  interest = Interest.Rate....,
  confidence = Consumer.Confidence.Index,
  oil = Crude.Oil.Price..USD.per.Barrel.,
  gold = Gold.Price..USD.per.Ounce.
)

finance$date <- as.Date(finance$date)


#Sub-question 1: Did the three indices move the same way over the years, or did they go their own paths?
ggplot(finance, aes(x = date, y = close, color = index)) +
  geom_line() +
  labs(title = "Closing Price Over Time by Stock Index",
       x = "Date", y = "Closing Price", color = "Stock Index") +
  theme_minimal()


#Sub-question 2: Does trading more actually line up with a higher price, and is it different for each index?
#(high-dimensional plot: x, y, color, and size = four variables)
ggplot(finance, aes(x = volume, y = close, color = index, size = interest)) +
  geom_point(alpha = .4) +
  labs(title = "Trading Volume vs Closing Price",
       x = "Trading Volume", y = "Closing Price",
       color = "Stock Index", size = "Interest Rate (%)") +
  theme_minimal()


#Sub-question 3: How do things like inflation, unemployment, and GDP sit together, and does that change depending on the index?
#(high-dimensional plot: x, y, color, size, and facet = five variables)
ggplot(finance, aes(x = inflation, y = unemployment, color = gdp, size = oil)) +
  geom_point(alpha = .5) +
  facet_wrap(~ index) +
  scale_color_viridis_c() +
  labs(title = "Inflation vs Unemployment by Stock Index",
       x = "Inflation Rate (%)", y = "Unemployment Rate (%)",
       color = "GDP Growth (%)", size = "Oil Price") +
  theme_minimal()


#Sub-question 4: Where do most of the closing prices land for each index, and are some priced higher than others?ggplot(finance, aes(x = close, fill = index)) +
  geom_histogram(bins = 30, color = "white") +
  facet_wrap(~ index) +
  labs(title = "Distribution of Closing Price by Stock Index",
       x = "Closing Price", y = "Count", fill = "Stock Index") +
  theme_minimal()
