######################################################################
## FileName: ui.R
## Author: sarigela
## Date: 17th Dec 2014.

## Description:  This page shows the MPG prediction of car based on some
##      feature inputs that the user enters.
##      INPUT: Required entires of the car are
##          1)  Weight of the car, 
##          2)  1/4 th Mile time,
##          3)  Transmission Type.
##      
##      OUTPUT:
##          Predicted Mile Per Gallon for this car.
##
##      Static Output: Prediction RMSE is probably between the error ranges.
##          1) Root Mean Square Error of Testing set.
##          2) Root Mean Square Error of Trainng set.
##
##      Computations performed on this page:
##          1) Setting the min and max values for Weight Slider.
##          2) Setting the min and max values for QSec Slider.
##
######################################################################

library(shiny)
data(mtcars)
shinyUI(pageWithSidebar(
    headerPanel("Car Miles Per Gallon Calculator"),
    sidebarPanel(
        h4 ("Documentation Link:"),
        p("",a("Click here to see documentation",href="Documentation.html")),
        h3 ("Enter Car features:"),
        sliderInput('inputwt', 'Weight (lbs/1000)',min = floor(min(mtcars$wt)), 
                    max = ceiling(max(mtcars$wt)), value = floor(min(mtcars$wt)), step = 0.05),
        sliderInput('inputqsec', ' Q-Sec (or) 1/4th mile time (secs)',min = floor(min(mtcars$qsec)), 
                    max = ceiling(max(mtcars$qsec)), value = floor(min(mtcars$qsec)), step = 0.05),
         selectInput('inputam', "Transmission Type", c ("Automatic", "Manual") )
         
        ),
    mainPanel(
        h3 ('Car feature selected'),
        h4 ('Weigt of car in lbs'),
        verbatimTextOutput("owt"),
        h4('Q-Sec of car'),
        verbatimTextOutput("oqsec"),
        h4('Transmission Type'),
        verbatimTextOutput("oam"),
        h4("."),
        h4("============="),
        h3 ("MPG Prediction"),
        h4("============="),
        h4("Miles per Gallon for this car"),
        verbatimTextOutput("ompg"),
        h4("============="),
        h4("Root Mean Square Error for this prediction model is in between the below two values:"),
        h5("RMSE for Training Set:"),
        verbatimTextOutput("ormse1"),
        h5("RMSE for Test Set:"), verbatimTextOutput("ormse2")
        )
    ))
