library(shiny)
library(visNetwork)
function(input, output) { 
  output$network <- renderVisNetwork({
    dir <- input$LLAVEHOG
    query <- paste("SELECT * FROM madres WHERE LLAVEHOG = '",dir,sep="")
    query <- paste(query,"\'",sep="")
    hogar <- sqldf(query, dbname = "CYCH2017", user = "")
    fromNodes <- c()
    toNodes <- c()
    Sex = c()
    label = c()
    
    
    for (row in 1:nrow(hogar)) {
      label = c(label, row)
      sexo <- hogar[row, 'P6020']
      relacion <- hogar[row, 'P6051']
      padre <- hogar[row, 'P6081']
      madre <- hogar[row, 'P6083']
      conyuge <- hogar[row, 'P6071']
      estadocivil <- hogar[row, 'P5502']
      
      if (hogar[row,"P6071"] == 1) {
        fromNodes <- c(fromNodes,row)
        toNodes <- c(toNodes,hogar[row,"P6071S1"])
      }
      if(sexo == 1){
        if (estadocivil == 5){
          Sex = c(Sex, 'lightgreen')
        } else{
          Sex = c(Sex, 'pink')
        }
      } else{
        Sex = c(Sex, 'skyblue')
      }
    }
    
    # minimal example
    nodes <- data.frame(id = 1:nrow(hogar),
                        color = Sex,
                        label = label)
    edges <- data.frame(from = fromNodes, to = toNodes)
    
    visNetwork(nodes, edges)
  })
}