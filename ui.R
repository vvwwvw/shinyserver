if(!require(shiny)){install.packages("shiny");library(shiny)}
if(!require(shinydashboard)){install.packages("shinydashboard");library(shinydashboard)}
if(!require(data.table)){install.packages("data.table");library(data.table)}




# dashboard title
header <- dashboardHeader(
  title = "GLTC_state"
)

sidebar <- dashboardSidebar(
  collapsed = TRUE,
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green")
  )
)

body <- dashboardBody(
  tabItem(tabName = "dashboard",
          fluidPage(
            fluidRow(
              column(width = 2,
                     box(width = NULL,
                         status = "warning",
                         selectInput(inputId = "room",
                                     # width = 3,
                                     label = "roomNumber",
                                     choices = sort(unique(final_list$room))), #/selectInput
                         # selectInput(inputId = "side1",
                         #             label = "sideNumber",
                         #             choices = NULL), #/selectInput
                         shiny::tableOutput("data"),
                         actionButton("refresh", "Refresh now"),
                         p(class = "text-muted",
                           br(),
                           "Source data updates every 30 seconds.")
                     )#/box
              ),#/colnum
              column(width = 10,
                     box(width = NULL,
                         # plotOutput("plot2", height = 800)
                         plotOutput("plot",height = 1000))
                
              ),#/colnum
              
            ),#/fluidRow
          )#/fluidPage
  )#/tabitem
)#/dashboardBody

ui <- dashboardPage(
  header,
  sidebar,
  # dashboardSidebar(disable = TRUE),
  body
)

shinyApp(ui, server)

