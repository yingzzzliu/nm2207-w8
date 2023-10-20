library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Choose your coffee!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      radioButtons("coffee",
                   "Coffee Type:", 
                   choices = c("Americano", 
                               "Latte", 
                               "Frappe"),
                   selected = "Latte")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Coffee Image ----
      imageOutput("coffeeImage"),
      
      # Output: Edited Paragraph ----
      verbatimTextOutput("editedParagraph")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  output$coffeeImage <- renderImage({
    coffee_type <- input$coffee
    
    # Define file path for each coffee type
    if (coffee_type == "Americano") {
      filepath <- "C:/Users/angel/OneDrive/Documents/NM2207/WEEK 8/www/americano.jpg"
    } else if (coffee_type == "Latte") {
      filepath <- "C:/Users/angel/OneDrive/Documents/NM2207/WEEK 8/www/frappe.jpg"
    } else if (coffee_type == "Frappe") {
      filepath <- "C:/Users/angel/OneDrive/Documents/NM2207/WEEK 8/www/latte.jpg"
    }
    
    list(src = filepath, contentType = "image/jpeg", width = 400, height = 350)
  }, deleteFile = FALSE)
  
  output$editedParagraph <- renderText({
    coffee_type <- input$coffee
    
    if (coffee_type == "Americano") {
      "A Café Americano, or what we just call an Americano, 
      combines freshly pulled shots of espresso with hot water to achieve the size of a standard cup of brewed coffee."
    } else if (coffee_type == "Latte") {
      "A latte will be made up of one or two shots of espresso, 
      steamed milk and a final, thin layer of frothed milk on top."
    } else if (coffee_type == "Frappe") {
      "A frappe is an iced beverage that has been blended to produce 
      a tasty, refreshing drink. It's served cold, usually has whipped cream, 
      and can also have other toppings."
    }
  })
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
