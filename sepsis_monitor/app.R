library(shiny)
library(tidyverse)
library(data.table)
library(lubridate)
library(googledrive)

file_link <- "https://drive.google.com/file/d/1pH0zGLKzuQz9KqixikuPythYqgINWWob/view?usp=sharing"
sepsis <- drive_read_string(file_link) %>%
  read_csv()


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Sepsis monitor"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           tableOutput("table_vitals")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$table_vitals <-renderTable({
      sepsis %>% filter(SepsisLabel==1) %>%
        
    })

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
