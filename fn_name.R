
#Names for levels could be an argument
fn_name <- function(data, opacity = 0.7, PC = T, spacing = 0.01,
                    x_labels = unique(data$level_name)){
  
  #limit the max possible spacing? 
  if(spacing > 0.49){
    spacing <- 0.01
    print('Spacing parameter too high, and set to 0.01 (default value)')
  }
  
  data$cs1 <- NA
  data$cs2 <- NA
  data$pc_cs1 <- NA
  data$pc_cs2 <- NA
  for(i in 2:4){
    #aux <- data[data$level==i,]
    totl <- sum(data[data$level==i,]$N)
    
    data[data$level==i,]$cs2 <- cumsum(data[data$level==i,]$N)
    data[data$level==i,]$cs1 <- c(0,data[data$level==i,]$cs2[1:6])
    #If we have the same number of factors for each level
    
    data[data$level==i,]$pc_cs1 <- data[data$level==i,]$cs1 /totl
    data[data$level==i,]$pc_cs2 <- data[data$level==i,]$cs2 /totl
  }
  data
  data[data$level==1,]$cs1[1] <- 0
  data[data$level==1,]$cs2[1] <- data[data$level==1,]$N[1]
  #
  data[data$level==1,]$pc_cs1[1] <- 0
  data[data$level==1,]$pc_cs2[1] <- 1#?
  
  # ggplot(data) + theme_classic() + labs(fill = '') +
  #   geom_rect(aes(xmin = level - (0.5 - abs(spacing)), 
  #                 xmax = level + (0.5 - abs(spacing)),
  #                 ymin = cs1, ymax = cs2, fill = name),
  #             alpha = .72) + 
  #   scale_x_continuous(breaks = seq(1,4),
  #                      labels = c('Priority\npopulation',
  #                                 'Motivation',
  #                                 'Access',
  #                                 'Effective\nuse')) 
  
  if(PC == F){
    pl <-   ggplot(data) + theme_classic() + labs(fill = '') +
      geom_rect(aes(xmin = level - (0.5 - abs(spacing)), xmax = level + (0.5 - abs(spacing)),
                    ymin = cs1, ymax = cs2, fill = name),
                alpha = opacity) + 
      scale_x_continuous(breaks = seq(1,4),
                         labels = x_labels#c('Priority\npopulation',
                                  #  'Motivation',
                                  #  'Access',
                                  #  'Effective\nuse')
                         ) 
  }else{
    pl <- ggplot(data) + theme_classic() +
      geom_rect(aes(xmin = level - (0.5 - abs(spacing)), xmax = level + (0.5 - abs(spacing)),
                    ymin = 100*pc_cs1, ymax = 100*pc_cs2,
                    fill = name), alpha = opacity) + 
      ylab('Percentage of population (%)') + 
      labs(fill = '') +
      scale_x_continuous(breaks = seq(1,4),
                         labels = x_labels#c('Priority population',
                                  #  'Motivation',
                                  #  'Access',
                                  #  'Effective use')
                         )  
  }
  

  return(pl)
}
