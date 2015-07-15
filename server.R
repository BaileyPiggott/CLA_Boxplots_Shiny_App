

# CLA data boxplots
#server logic


source("set_up.R") # load libraries and set up dataframes for each discipline

shinyServer(function(input, output) {
  
  output$claPlot <- renderPlot({
    
    if(input$discipline == 2){
      df <- rbind(psyc, fix)
      graph_title = "Psychology CLA Scores"
    }
    else if(input$discipline == 3){
      df <- rbind(dram, fix)
      graph_title = "Drama CLA Scores"
    }
    else if(input$discipline == 4){
      df <- rbind(eng, fix)
      graph_title = "Engineering CLA Scores"
    } 
    else if(input$discipline == 5){
      df <- rbind(phys, fix)
      graph_title = "Physics CLA Scores"
    } 
    else{
      df <- queens
      graph_title = "CLA Scores"
    }
    
    
    #calculate sample sizes:
    n_1 <-  sum(with(df, class ==1 & score_total > 1), na.rm = TRUE)     
    year1 <- paste0("First Year\nn = ", n_1) #text string for xlabel including sample size
    
    n_2 <-  sum(with(df, class ==2 & score_total > 1), na.rm = TRUE)     
    year2 <- paste0("Second Year\nn = ", n_2) #text string for xlabel
    
    n_3 <-  sum(with(df, class ==3 & score_total > 1), na.rm = TRUE)     
    year3 <- paste0("Third Year\nn = ", n_3) #text string for xlabel
    
    n_4 <-  sum(with(df, class ==4 & score_total > 1), na.rm = TRUE)     
    year4 <- paste0("Fourth Year\nn = ", n_4) #text string for xlabel
    
    
    ## plot description
    ggplot(
      data = df, 
      aes(x = as.factor(class), y = score_total)
      ) +
      geom_hline(
        yintercept = c(963, 1097, 1232, 1367),  #boundaries for CLA mastery levels 
        colour = "red", 
        linetype = 'dashed'
      ) +
      stat_boxplot(geom = 'errorbar', stat_params = list(width = 0.3)) + # add perpendicular lines to whiskers
      geom_boxplot(
        width = 0.5
        ) + # geom_boxplot must be after stat_boxplot    
      coord_cartesian(xlim = c(0.5,5.9),ylim = c(600, 1600)) +
      scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
      theme(
        panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
        panel.grid.major.y = element_line("grey"), #change horizonatal line colour (from white)
        panel.background = element_rect("white"), #change background colour
        legend.position = "bottom", # position legend below graph
        legend.title = element_blank(), #remove legend title
        axis.title.x = element_blank(), # remove x axis title
        axis.text.x = element_text(size = 12) #size of x axis labels
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

