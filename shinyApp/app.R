# LifeCycle shiny app 
# Author: Sebastian Rauschert, PhD

# Load necessary libraries
library(shiny)
library(tidyverse)

#Placeholder app

ui <- fluidPage(
  
  # Application title
  titlePanel("Iris Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("variable1","Variable 1:",
                  c("Sepal Length" = "Sepal.Length",
                    "Sepal Width" = "Sepal.Width",
                    "Petal Length" = "Petal.Length",
                    "Petal Width" = "Petal.Width")
                  ),
      selectInput("variable2","Variable 2:",
                  c("Sepal Length" = "Sepal.Length",
                    "Sepal Width" = "Sepal.Width",
                    "Petal Length" = "Petal.Length",
                    "Petal Width" = "Petal.Width")
      ),
      selectInput("stratifyBy", "Colored by Species",
                  c("no", "yes")
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatter")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$scatter <- renderPlot({
    Variable1 <- input$variable1
    Variable2 <- input$variable2
    strata    <- input$stratifyBy
    # draw the histogram with the specified number of bins
    
    if(strata %in% "no"){
    ggplot(iris, aes_string(x=Variable1, y=Variable2)) +
      geom_point() +
      theme_minimal()
    }
    else{
      ggplot(iris, aes_string(x=Variable1, y=Variable2, col="Species")) +
        geom_point() +
        theme_minimal()
    }
                        
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
