library(shiny)
library(datasets)
library(ggplot2)

data(mtcars)
mtcars <- mtcars
colnames(mtcars)

shinyUI(fluidPage(
  
  titlePanel(h1("Analysis of the mtcars dataset", align="center")),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("This little app allows a regression analysis of the mtcars dataset.
               Choose axis and type of regression.
               Picking certain options enables control over new parameters.
               Play around and have fun.
               (Disclaimer: I found out that the app does not work in all OS/browser settings,
               e.g. Firefox on Kubuntu.
               This is not my app's fault, but shinyppas.io's fault. Sorry.)"),
      selectInput("xaxis",
                  label = "Choose an x-axis:",
                  choices = list( "Miles/(US) gallon" = "mpg",
                                  "Number of cylinders" = "cyl",
                                  "Displacement (cu.in.)" = "disp",
                                  "Gross horsepower" = "hp",
                                  "Rear axle ratio" = "drat",
                                  "Weight (lb/1000)" = "wt",
                                  "1/4 mile time" = "qsec",
                                  "V/S" = "vs",
                                  "Transmission (0 = automatic, 1 = manual)" = "am",
                                  "Number of forward gears" = "gear",
                                  "Number of carburetors" = "carb" ),
                  selected = "wt"),
      selectInput("yaxis",
                  label = "Choose an y-axis:",
                  choices = list( "Miles/(US) gallon" = "mpg",
                                  "Number of cylinders" = "cyl",
                                  "Displacement (cu.in.)" = "disp",
                                  "Gross horsepower" = "hp",
                                  "Rear axle ratio" = "drat",
                                  "Weight (lb/1000)" = "wt",
                                  "1/4 mile time" = "qsec",
                                  "V/S" = "vs",
                                  "Transmission (0 = automatic, 1 = manual)" = "am",
                                  "Number of forward gears" = "gear",
                                  "Number of carburetors" = "carb" ),
                  selected = "mpg"),
#       checkboxGroupInput("analysistype",
#                          label = "Choose a type of analysis:",
#                          choices = list( "Linear Regression" = "lm",
#                                          "Loess Smoothing" = "loess")
#       ),
      checkboxInput("lm", label = "Linear Regression"),
      conditionalPanel(
        condition = "input.lm == true",
        checkboxInput("lm_se", label = "Conf. interv. Lin. Regr.")
      ),
      checkboxInput("loess", label = "Loess Smoothing"),
      conditionalPanel(
        condition = "input.loess == true",
        checkboxInput("loess_se", label = "Conf. interv. Loess")
      ),
      conditionalPanel(
        condition = "input.loess == true",
        sliderInput("smooth_degree",
                    label = "Choose the degree of smoothing:",
                    min = 0.1, max = 3, value = 0.75)
      ),
      conditionalPanel(
        condition = "input.loess_se == true && input.loess == true || input.lm == true && input.lm_se == true",
        sliderInput("conflevel",
                    label = "Choose the confidence intervals:",
                    min = 0.1, max = 1, value = 0.95)
      )

#       sliderInput("griddotnumber",
#                   label = "Choose the number of grid points:",
#                   min = 5, max = 100, value = c(50L)),
#       sliderInput("kernbandwidth",
#                   label = "Wähle den Glättungsgrad:",
#                   min = 0.001, max = 1.5, value = c(1), step = c(0.001))
    ),
    
    mainPanel(
      plotOutput("plot")
    )
    
  )

))
