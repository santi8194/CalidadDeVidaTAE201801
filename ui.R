library(shiny)
library(visNetwork)
library(sqldf)

# create an empty database.
# can skip this step if database already exists.
# sqldf("attach CYCH2017 as new")
# # or: cat(file = "testingdb")
# 
# read into table called iris in the testingdb sqlite database
#read.csv.sql("CYCH2017.csv", sql = "create table main.madres as select * from file",
#             dbname = "CYCH2017")

# look at first three lines
dirs <- sqldf("select distinct DIRECTORIO from madres", dbname = "CYCH2017", user = "")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      verticalLayout(
        selectInput("directorio", "Directorio:",
                    dirs)
        
      )
    ),
    mainPanel(
      verticalLayout(
        visNetworkOutput("network")
      )
    )
  )
)