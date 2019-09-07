header <- dashboardHeader(title = "Japan Hostel")

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
            text = "hostel price",
            tabName = "hostel_tab1",
            icon = icon("chart-bar")
        ),
        menuItem(
            text = "hostel rating",
            tabName = "hostel_tab2",
            icon = icon("percent")
        ),
        menuItem(
            text = "hostel value",
            tabName = "hostel_tab3",
            icon = icon("star")
        ),
        menuItem(
            text = "hostel_map",
            tabName = "hostel_tab4",
            icon = icon("map-marked-alt")
        )
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "hostel_tab1",
            fluidRow(
                infoBoxOutput("infobox1",width = 6),
                infoBoxOutput("infobox2", width = 6)
            ),
            fluidPage(fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "City",
                        label = "Select City to see the Price",
                        choices = selectcity
                    )
                )
            ),
            column(width = 12,
                   plotlyOutput("hostel1"))
            )
        ),
        tabItem(
            tabName = "hostel_tab2",
            fluidPage(
                fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "City1",
                        label = "Select City to see the Rating",
                        choices = selectcity
                    )
                )
            ),
            column(width = 12,
                   plotlyOutput("hostel2")))
        ),
        tabItem(
            tabName = "hostel_tab3",
            fluidPage(
                fluidRow(
                    column(
                        width = 4,
                        selectInput(
                            inputId = "rating.band1",
                            label = "Select Rating",
                            choices = selectrating
                        )
                    )
                ),
                column(width = 12,
                       plotlyOutput("hostel3"))
            )
        ),
        tabItem(
            tabName = "hostel_tab4",
            fluidPage(
                fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "rating.band2",
                        label = "Select Rating",
                        choices = selectrating
                    )
                )
            ),
            column(width = 12,
                   leafletOutput("hostel4")))
        )
    )
)

dashboardPage(
    header = header,
    body = body,
    sidebar = sidebar,
    skin = "black"
)