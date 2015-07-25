library(shiny)
library(ggplot2)

############### FUNCTIONS

list_contains <- function(list,string){
  if(length(list)==0){
    return(FALSE)
  }
  for(i in 1:length(list)){
    if(list[[i]]==string){
      return(TRUE)
    }
  }
  return(FALSE)
}

############### DATA-IMPORT

data(mtcars)
mtcars <- mtcars

textframe <- data.frame( "mpg" = "Miles/(US) gallon",
                         "cyl" = "Number of cylinders",
                         "disp" = "Displacement (cu.in.)",
                         "hp" = "Gross horsepower",
                         "drat" = "Rear axle ratio",
                         "wt" = "Weight (lb/1000)",
                         "qsec" = "1/4 mile time",
                         "vs" = "V/S",
                         "am" = "Transmission (0 = automatic, 1 = manual)",
                         "gear" = "Number of forward gears",
                         "carb" = "Number of carburetors",
                         stringsAsFactors = F)

############### SHINY

shinyServer(function(input, output){
   
  output$plot <- renderPlot({
    
    gg <- ggplot(mtcars, aes_string(x=input$xaxis, y=input$yaxis)) +
      geom_point() +
      scale_colour_manual(values = color(), guide = FALSE) +
      labs(x = textframe[[input$xaxis]], y = textframe[[input$yaxis]])
    ant <- input$analysistype
    if(input$lm==T){
      gg <- gg + geom_smooth(method="lm",
                             color="red",
                             se=input$lm_se,
                             level=as.numeric(input$conflevel))
    }
    if(input$loess==T){
      gg <- gg + geom_smooth(method="loess",
                             se=input$loess_se,
                             level=as.numeric(input$conflevel),
                             span=as.numeric(input$smooth_degree))
    }
    gg
    
  })
  
  output$text <- renderText(input$conflevel)
  
#   output$loess_se <- reactive({
#     list_contains(input$analysistype,"loess")
#   })
#   
#   output$lm_se <- reactive({
#     list_contains(input$analysistype,"lm")
#   })  
  
  ###############

})