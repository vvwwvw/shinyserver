if(!require(shiny)){install.packages("shiny");library(shiny)}
if(!require(shinydashboard)){install.packages("shinydashboard");library(shinydashboard)}
if(!require(data.table)){install.packages("data.table");library(data.table)}
if(!require(data.table)){install.packages("dplyr");library(dplyr)}



server <- 
  function(input, output, session) {
    
    room_select <- reactive({
      filter(final_list, room == input$room)
    })
    
    observeEvent(room_select(),{
      choices <- unique(room_select()$side) %>% sort
      updateSelectInput(inputId = "side1", choices = choices)
    })


    output$data <-
      renderTable({
        req(input$room) #알아보기..
        a <- room_select()
        a$dan <- as.factor(a$dan)
        
        
        a1 <- a %>% filter(type == "empty",단명 == "개인") %>%  group_by(dan, .drop=FALSE) %>% summarise(개인=n())
        a2 <- a %>% filter(type == "empty",단명 == "부부") %>%  group_by(dan, .drop=FALSE) %>% summarise(부부=n())
        merge(a1,a2,by = "dan")
    })
    
    
    output$plot <- renderPlot({
      
      side_count <- room_select() %>% select(side) %>% unlist() %>% unique() %>% sort()
      side_max <- side_count %>% max()
      
      p1 <- lapply(side_count, function(i){
        ggplot(room_select() %>% filter(side == i),
               aes(x = col,
                   y = dan,
                   fill = color)) +
          geom_tile(colour = "black",
                    width = 0.85, 
                    height = 0.85, 
                    size = 0.2) +
          scale_fill_manual(values = room_select() %>% filter(side == i) %>% select(color) %>% unlist() %>% unique() %>% sort()) +
          coord_fixed(ratio = 0.9) + #x축 y축 비율
          ggtitle(paste0(input$room, "호실-", i,"면", "/",side_max)) + #제목
          theme(legend.position = "none",
                panel.background = element_blank(),
                legend.background = element_blank(),
                text = element_text(size = 7,family = "notosanskr")) +
          scale_y_continuous(expand = c(0,0), breaks = seq(0,9,by = 1)) +
          scale_x_continuous(expand = c(0,0), breaks = seq(0,30,by = 1)) +
          labs(x = NULL, y = NULL) #축 삭
        
      })
      grid.arrange(
        grobs = p1,
        ncol = 3,
        nrow = 6)
    })


  } 