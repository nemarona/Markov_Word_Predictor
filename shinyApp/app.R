library(shiny)

load("M2-model-10pc.RData")
source("appfuns.R")

ui <- fluidPage(
    titlePanel("Markov Word Predictor"),
    fluidRow(
        column(
            width = 4,
            wellPanel(
                h3("Welcome!"),
                p("Markov Word Predictor by",
                  # Use raw HTML to avoid either period in hyperlink or space before period
                  HTML('<a href="https://www.linkedin.com/in/eduardo-rodríguez-b2752289/en">Eduardo Rodríguez</a>.')),
                p("This",
                  a(href = "http://shiny.rstudio.com/", "Shiny"),
                  "app predicts the next word you will type."),
                p("I built this app as the Capstone Project for the",
                  a(href = "https://www.coursera.org/specializations/jhu-data-science",
                    "Data Science Specialization"),
                  "at Coursera.")
            )
        ),
        column(
            width = 8,
            textInput(inputId = "text", "Start typing here:", width = "100%",
                      placeholder = "Give me love, give me peace on"),
            submitButton("Predict"),
            hr(),
            p("Next word prediction:",
              strong(textOutput(outputId = "pred", inline = TRUE)))
        )
    ),
    hr(),
    fluidRow(
        column(
            width = 4,
            align = "center",
            a(href = "https://github.com/nemarona/Markov_Word_Predictor",
              "Code on GitHub")
        ),
        column(
            width = 4,
            align = "center",
            a(href = "http://rpubs.com/nemarona/Markov_Word_Predictor",
              "5-slide presentation")
        ),
        column(
            width = 4,
            align = "center",
            a(href = "mailto:eduarodriguez@gmail.com", "Contact me")
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
