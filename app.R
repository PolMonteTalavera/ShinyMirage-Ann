library(shiny)
library(config)

app_config <- config::get(file = "config.yml")

ui <- fluidPage(
  titlePanel(app_config$app_name),

  sidebarLayout(
    sidebarPanel(
      img(src = app_config$logo, height = "80px"),
      br(),
      br(),

      strong("App version:"),
      textOutput("version"),
      br(),
      br(),

      downloadButton("download_report", "Download report")
    ),

    mainPanel(
      h3("Welcome to shinyMirage"),
      p(
        "This is a simple test application for exploring multi-client GitHub workflow strategies."
      )
    )
  )
)

server <- function(input, output, session) {
  output$version <- renderText({
    app_config$version
  })

  output$download_report <- downloadHandler(
    filename = function() {
      basename(app_config$report)
    },
    content = function(file) {
      file.copy(app_config$report, file)
    }
  )
}

shinyApp(ui = ui, server = server)
