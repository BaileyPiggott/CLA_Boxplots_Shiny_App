

# CLA data boxplots
#server logic

source("set_up.R") # load libraries and set up dataframes for each discipline



shinyServer(function(input, output) {
  
  output$claPlot <- renderPlot({
    
    if(input$discipline == 2){
      df <- rbind(psyc, fix)
      graph_title = "Psychology CLA Scores"
      prog_name = "Psychology"
      dummy <- dummy_4 %>% mutate(Subject = "PSYC") # missing 4th year
    }
    else if(input$discipline == 3){
      df <- rbind(dram, fix)
      graph_title = "Drama CLA Scores"
      prog_name = "Drama"
      dummy <- rbind(dummy_2, dummy_4) %>% mutate(Subject = "DRAM") # missing 2nd and 4th year
    }
    else if(input$discipline == 4){
      df <- rbind(eng, fix)
      graph_title = "Engineering CLA Scores"
      prog_name = "Engineering" 
      dummy <- fix# not missing any years
    } 
    else if(input$discipline == 5){
      df <- rbind(phys, fix)
      graph_title = "Physics CLA Scores"
      prog_name = "Physics"
      dummy <- rbind(dummy_2, dummy_4) %>% mutate(Subject = "PHYS") # missing 2nd and 4th year
    } 
    else{
      df <- fix # will be bound with queens after discipline specific sample sizes calculated
      graph_title = "CLA Scores"
      prog_name = "Queen's"
      dummy <- fix# not missing any years
    }
    
    
    #calculate sample sizes:
    #calculate sample sizes:
    n_1 <-  sum(with(df, class == 1 & score_total >= 1), na.rm = TRUE)     
    year1 <- paste0("First Year\nn = ", n_1, "   n = ", n_q_1) #text string for xlabel including sample size
    n_2 <-  sum(with(df, class == 2 & score_total >= 1), na.rm = TRUE)     
    year2 <- paste0("Second Year\nn = ", n_2, "   n = ", n_q_2) #text string for xlabel
    n_3 <-  sum(with(df, class == 3 & score_total >= 1), na.rm = TRUE)     
    year3 <- paste0("Third Year\nn = ", n_3, "   n = ", n_q_3) #text string for xlabel
    n_4 <-  sum(with(df, class == 4 & score_total >= 1), na.rm = TRUE)     
    year4 <- paste0("Fourth Year\nn = ", n_4, "   n = ", n_q_4) #text string for xlabel
    
    df <- rbind(df, queens, fix, dummy) # combine with all queens data
    
    
    ## plot description
    ggplot(
      data = df, 
      aes(x = as.factor(class), y = score_total, fill = Subject)
      ) +
      geom_hline(
        yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
        colour = "red", 
        linetype = 'dashed'
      ) +
      geom_boxplot(width = 0.5) +    
      coord_cartesian(xlim = c(0.5,5.9),ylim = c(600, 1650)) +
      scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
      scale_fill_manual(
        values =  c("darkgoldenrod1", "steelblue3"),
        labels = c(prog_name, "Queen's")
        )+
      theme(
        panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
        panel.background = element_rect("white"), #change background colour
        legend.position = "bottom", # position legend below graph
        legend.title = element_blank(), #remove legend title
        axis.title.x = element_blank(), # remove x axis title
        axis.text.x = element_text(size = 12), #size of x axis labels
        panel.grid.major.x = element_blank(), # remove vertical lines
        panel.grid.major.y = element_blank(), # remove horizontal lines
        panel.grid.minor.y = element_blank()
      ) +
      labs(title = graph_title, x = "Year", y = "Total CLA+ Score") +
      annotate( # add labels for CLA mastery levels
        "text", 
        fontface = "bold", 
        size = 4,
        alpha = c(0.5, 0.5,0.5,0.5,0.5, 0.8), # transparency (0-1)
        x = 5.2, y = c(900, 1030, 1164, 1300, 1430, 1530), 
        label = c("Below Basic", "Basic", "Proficient", "Accomplished", "Advanced", "CLA Mastery Levels"), 
        colour = "red"
      ) # end ggplot description  
    
    
  }#end plot expression
  ) #end render plot

  
}#end function
) #end shiny server

