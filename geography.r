library(shiny)

# Define UI for data download app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Coffee Brewery"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Choose dataset ----
      selectInput("coffee", "Choose a coffee type:",
                  choices = c("Americano", "Latte", "Frappe")),
      
      # Button
      downloadButton("downloadData", "Brew it!")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Display selected coffee image ----
      h3("What you will get:"),
      imageOutput("selectedImage")
    )
    
  )
)

# Define server logic to display and download selected file ----
server <- function(input, output) {
  
  # Function to retrieve file path based on selected coffee type
  getFilePath <- reactive({
    coffee_type <- input$coffee
    
    switch(coffee_type,
           "Americano" = "C:/Users/angel/OneDrive/Documents/NM2207/WEEK 8/www/americano.jpg",  # Replace with actual file path
           "Latte" = "C:/Users/angel/OneDrive/Documents/NM2207/WEEK 8/www/latte.jpg",        # Replace with actual file path
           "Frappe" = "C:/Users/angel/OneDrive/Documents/NM2207/WEEK 8/www/frappe.jpg"       # Replace with actual file path
    )
  })
  
  # Render the selected coffee image
  output$selectedImage <- renderImage({
    list(src = getFilePath(), contentType = "image/jpeg", width = 400, height = 300)
  }, deleteFile = FALSE)
  
  # Download the selected coffee image
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$coffee, ".jpg", sep = "")
    },
    content = function(file) {
      file.copy(getFilePath(), file)
    }
  )
}

# Create Shiny app ----
shinyApp(ui, server)
