library(shiny)
library(ggplot2)
# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define a server for the Shiny app
shinyServer(function(input, output) {
  output$ui <- renderUI({
    if (is.null(input$table))
      return()
    
    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    selectInput("region", "region:", multiple = FALSE,
                choices=colnames(dt_aida_pri[[input$table]]))
  })
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    if (is.null(input$region)||is.null(input$table)||!(input$region%in%colnames(dt_aida_pri[[input$table]]))){
      print(input$region%in%colnames(dt_aida_pri[[input$table]]))
      return()
    }
    # Render a barplot
    else {
    if (input$viz=="barplot"){
#       print(input$region%in%colnames(dt_aida_pri[[input$table]]))
      temp=dt_aida_pri[[c(input$table)]]
      temp=temp[,list("number"=.N),by=c(input$region)]
      variable=colnames(temp)[1]
      setnames(temp,colnames(temp),c("V1","V2"))
      print(temp)
      g<-NULL
      g<-ggplot(data=temp,aes(x=V1,y=V2))+
        geom_bar(stat = "identity")
  #       ggtitle(label = paste(input$region))+
  #       ylab(input$viz)+
  #       xlab(variable)
      plot(g)
    }
  }
})
})