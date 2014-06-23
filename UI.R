shinyUI(
  fluidPage(
    titlePanel("Regression Engine")                     ,
    sidebarLayout(
      sidebarPanel(h3("List of Variables"),
                   uiOutput("DropList"),
                   uiOutput("GroupedCheckbox"),
                   radioButtons("radio", label = h3("Analyze data"),
                                choices = list("Summary" = 1, "Display Sample" = 2,
                                               "Regression" = 3,
                                               "Display Table"=4),selected = 4)           
                               )
                              ,
      mainPanel(h3("Regression Inputs"),
                fileInput("file", label = h4("File input")),
                checkboxInput("chkbox", label = "Include Header", value = TRUE),
                tableOutput('text1'),
                textOutput('text2'),
                plotOutput('plot')
                )
        )
    )
) 
  