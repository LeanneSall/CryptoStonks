# CryptoStonks

## Description 
Mock trading app that allows users to "buy" and "sell" cryptocurrencies and have them create a fake portfolio.

## Technologies
* Flutter/Dart
* Firebase

## Installation Instructions
Clone repo

## Links
https://www.coingecko.com/en/api

## Milestones
Written by Phil Weier for SSD

#### Milestone 1
* Authentication (Register, Login, Logout)
* Consume a Stock Price API (like finnhub.io and/or alphavantage.co)
* Search and display the current stock price for a given symbol
* User Interface
  * Register/Login Screen
  * Search/Quote Screen
  * Navigation link to Log Out

#### Milestone 2
* Create and consume a user “portfolio” API (single currency)
* Create a user’s “Cash” (each user to start with $50,000)
* Perform a “market buy”
  * Create a record for {user, symbol, quotePrice, numShares}
  * Update Cash by subtracting quotePrice x numShares
* Perform a “market sell” (same as a buy but numShares should be negative and thus Cash should increase)
* User Interface
  * Buy/Sell Links on the Search/Quote Screen
  * Buy/Sell Screen 

#### Milestone 3

* Display “Portfolio Positions” (each position is the sum of the numShares for a given user and symbol, the average price per share, the current price per share, and the profit/loss which is the difference between the average price multiplied by shares held and current price multiplied by shares held).
* Display “Portfolio Value” = Cash plus the sums of each position currentPrice multiplied by shares held)
* User Interface
  * Portfolio Screen (Display Cash, List of Positions…with Buy/Sell Links, and Portfolio Value)
  * Navigation links to view Portfolio or Search/Quote Screen

#### Milestone 4

* Add “Stock Watchlist”
* User Interface
  * Add an icon by stock symbols on the Search/Quote Screen to add/remove from watchlist.
  * Display the watched symbols on the Search/Quote Screen when not displaying a search result.
  * Link to search result screen for a stock when user clicks on a symbol in the Portfolio Screen or the Watchlist.

#### Milestone 5
* Add performance Charts (price over time) Line chart on the
* User Interface
  * Line chart on Portfolio screen to display Portfolio Value over time (Week, Month, 3-Month, 6-Month, 12-Month, All Time)
  * Line chart on Search/Quote Screen for search result

