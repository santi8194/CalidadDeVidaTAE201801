library(shiny)
library(visNetwork)
function(input, output) { 
  output$network <- renderVisNetwork({
    dir <- input$directorio
    hogar <- sqldf(paste("select * from madres where DIRECTORIO =",dir, sep=" "), dbname = "CYCH2017", user = "")
    parejas <- sqldf(paste("select ORDEN, P6071S1 from madres where P6071 = 1.0 and DIRECTORIO =",dir, sep=" "), dbname = "CYCH2017", user = "")
    
    fromNodes <- parejas["ORDEN"]
    toNodes <- parejas["P6071S1"]
    
    # minimal example
    nodes <- data.frame(id = hogar["SECUENCIA_ENCUESTA"])
    edges <- data.frame(from = fromNodes["ORDEN"], to = toNodes["P6071S1"])
    
    visNetwork(nodes, edges)
  })
}