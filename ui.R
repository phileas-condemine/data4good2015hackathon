library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define the overall UI
shinyUI(fluidPage(
  titlePanel("graphes"),
  fluidRow(
    
    column(3, wellPanel(
      selectInput("table", "table:", multiple = FALSE,
                  choices=names(dt_aida_pri)),
      submitButton("Submit to update variables list")
      )),
    
    column(3, wellPanel(
      # This outputs the dynamic UI component
      uiOutput("ui")
    )),
    
    column(3, wellPanel(
      selectInput("viz", "Type of graph:", multiple = FALSE,
                    choices=c("barplot","points"))
    )),

# Create a spot for the barplot
    column(12,mainPanel(
      plotOutput("phonePlot")  
    ))
  )
))

