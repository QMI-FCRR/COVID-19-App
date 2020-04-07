
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
library(shinyjqui)

ui <- dashboardPage(title = "COVID-19",
                    dashboardHeader(disable = TRUE),
                    dashboardSidebar(disable = TRUE),
                    dashboardBody(
                        useShinyjs(),
                        tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
                        div(class = "section1",
                            div(id = "titlebar",
                                div(id = "title",
                                    img(src = "title2.png", style = "width:100%;")
                                )
                            ),
                            div(id = "how-it-works-small",
                                h2("#How It Works", style = "font-weight:bold;margin-top:0px;transform: rotateZ(90deg);width: 141px;font-size: 22px;position: absolute;top: 85px;left: -10px;")
                            ),
                            div(id = "how-it-works-lrg", class = "hidden",
                                div(id = "directions", style = "font-size: 16px; color: black;",
                                    h2("#How It Works", style = "font-weight:bold; margin-top:0px; color: white;"),
                                    p("Physicist Henry Reich posted a Youtube clip describing how we can tell if we are flattening an exponential curve.
                                    He simply suggested that we could create a graph of the total number of confirmed cases against the total number of new
                                    cases. The curve starts to flatten when the number of new cases does not “keep up” with the total number of cases. This \
                                    is an indication that the curve is flattening. He also suggested graphing on a log scale, because log scales will make
                                    exponential growth appear linear and we humans understand straight lines better than curving lines. We think this is a
                                    great idea."),
                                    
                                    p("The second fortuitous thing that happened is that the New York Times has been collating data on cases across all 50 states
                                    and has made their data available to the public ( Go NYT!) on github. What we have done is written a shiny app that pulls
                                    data from the NYT github and creates graphs for any state you select. PLEASE NOTE. These data usually have a lag of one day
                                    between when the state reports it’s data and the NYT dataset is populated."),
                                    
                                    p("What are you looking for in these graphs? Well, what you want to see is the bottom line (new cases) trending away from the
                                    top line (total cases). This implies that the new cases are slowing down relative to the total cases – and the curve is flattening.
                                    You should also note that what is graphed is a three-day rolling average. Which means that each point is actually the average
                                    of the two previous points plus that days point. The graph for each state also starts after the 10th COVID19 case was recorded."),
                                    
                                    p("One thing (of many) to note. If your state doesn’t have a continuous line for new cases it’s because no new cases were reported
                                    for three straight days. The log of zero is not defined (because math)."),
                                    
                                    p("We highly recommend watching Henry’s youtube clip linked below. He discusses his reasoning as well as clearly discusses the limitation of this approach.
                                    Final note. These graphs are NOT based on any models. Just the raw reported data from NYT."),
                                    
                                    a("Youtube link", href = "https://www.youtube.com/watch?v=54XLXg4fYsc&feature=youtu.be&fbclid=IwAR248u5ddJliakbue2jRan32nrDUxoGOE06iAwwwJw2AOj6M4NIa8H4ZBys"),
                                    br(),
                                    a("Data from the New York Times.", href = "https://github.com/nytimes/covid-19-data")
                                    )
                                
                            ),
                            div(id = "graph-container",
                                div(id = "graph",
                                    br(),
                                    div(h1("Choose a State:", style = "margin-top: 0px;"), style = "width: 90%; margin: auto; color: white;"),
                                    div(style = "width: 90%; margin: auto;",
                                    selectInput("state_input", label = NULL, choices = state.name, width = "30%")
                                    ),
                                    div(id = "graph1", style = "width: 90%; margin-left: 5%;",
                                        plotOutput("graphic"),
                                        img(src = "legend.png", style = "width: 15%; float: left; margin-top: 15%;")
                                    ),
                                    div( style = "width: 90%; margin-left: 5%; color: white; float: left;",
                                      p("Note: The data are graphed on a log scale and each data point represents a rolling average of three days.", style = "margin-bottom: 0px;"),
                                      p("Source: New York Times COVID-19 github.")
                                    )
                                ),
                                
                            ),
                            div(id = "angle-1"),
                            div(id = "angle-2"),

                        )
                                    
                    )
)
