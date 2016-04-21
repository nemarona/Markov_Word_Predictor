library(shiny)

load("M2-model-10pc.RData")
source("appfuns.R")

ui <- fluidPage(
    titlePanel("Markov Word Predictor"),
    sidebarLayout(
        sidebarPanel(
            h3("Welcome!"),
            p("Markov word predictor by Eduardo Rodríguez."),
            p("Capstone Project for the Data Science Specialization at Coursera.")
        ),
        
        mainPanel(
            textInput(inputId = "text", "Start typing here:", width = "90%",
                      placeholder = "Give me love, give me peace on"),
            submitButton("Predict!"),
            hr(),
            p("Next word prediction:",
              strong(textOutput(outputId = "pred", inline = TRUE)))
        )
    )
)

server <- function(input, output) {
    output$pred <- renderText({
        ent <- preProcess(input$text)
        input.words <- ninvert(n, ent)
        predictMn(input.words, n, m, states, Xhat, lambda, Q)
    })
}

shinyApp(ui = ui, server = server)
