######################################################################
##  FileName: server.R
##  Author: sarigela
##  Date: 17th Dec 2014.
##
##  Description: The server side code the computes MPG prediction.
##
##      'mtcars' data set is used to create a 'LM' model based on the
##      predictors - weight, qsec and transmission type.  An offline
##      computation is already performed to determine the best fit model.
##      Based on that the best model is mpg ~ am:wt + am:qsec. 
##      The R^2 = 0.8946 which means the model captures 89.5% variance, 
##      proving this model to be the best model.
##
##  Computations Performed in this page:
##      1) Conversion of car weight from lb/1000 into actual lbs.
##      2) Data partion of mtcars data into Training and Test sets.
##      3) Root Mean square errors for test and training sets.
##      4) Linear model creation.
##      5) Using the LM model to predict the mpg based on input values.
##
##
######################################################################
library(shiny)
data(mtcars)
mtcars$am <- as.factor(mtcars$am)   # Converting Trasmission to Factor
levels(mtcars$am) <- c("Automatic", "Manual")

# install.packages("caret")
library(caret)
intrain <- createDataPartition(y=mtcars$mpg, p = 0.7, list = FALSE)
training <- mtcars[intrain,]
testing <- mtcars[-intrain, ]

# Computed offline different models for wt, am, qsec and finalized that the best model is below
fit1 <- lm(mpg ~ am:wt + am:qsec, data = training)
pred1 <- predict(fit1, testing)

# Root Mean Square Error Calculation
rmse1 <- round(sqrt(sum(fit1$fitted-training$mpg)^2),2)
rmse2 <- round(sqrt(sum(pred1-testing$mpg)^2),2)

predictMPG <- function (wt1, am1, qsec1)
{
    newdata <- data.frame(wt=wt1, am=am1, qsec = qsec1)
    res <-round(predict(fit1, newdata)[[1]], 2)
    res
}

shinyServer(
    function(input, output){
        output$owt <- renderPrint({input$inputwt} * 1000)
        output$oqsec <- renderPrint({input$inputqsec})
        output$oam <- renderPrint({input$inputam})        
        output$ompg <- renderPrint({predictMPG(input$inputwt, input$inputam, input$inputqsec)})
        output$ormse1 <- renderPrint({rmse1})
        output$ormse2 <- renderPrint({rmse2})
        
    }
    )
