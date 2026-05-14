
#, PC = T

fn_name2 <- function(data1, data2, opacity = 0.7, spacing = 0.01,
                    x_labels = unique(data1$level_name), text_sz = 5, 
                    dataset_names = c("","")){
  
  #limit the max possible spacing? 
  if(spacing > 0.49){
    spacing <- 0.01
    print('Spacing parameter too high, and set to 0.01 (default value)')
  }
  
  data1$cs1 <- NA
  data1$cs2 <- NA
  data1$pc_cs1 <- NA
  data1$pc_cs2 <- NA
  for(i in 2:4){
    #aux <- data1[data1$level==i,]
    totl <- sum(data1[data1$level==i,]$N)
    
    data1[data1$level==i,]$cs2 <- cumsum(data1[data1$level==i,]$N)
    data1[data1$level==i,]$cs1 <- c(0,data1[data1$level==i,]$cs2[1:6])
    #If we have the same number of factors for each level
    
    data1[data1$level==i,]$pc_cs1 <- data1[data1$level==i,]$cs1 /totl
    data1[data1$level==i,]$pc_cs2 <- data1[data1$level==i,]$cs2 /totl
  }
  data1
  data1[data1$level==1,]$cs1[1] <- 0
  data1[data1$level==1,]$cs2[1] <- data1[data1$level==1,]$N[1]
  #
  data1[data1$level==1,]$pc_cs1[1] <- 0
  data1[data1$level==1,]$pc_cs2[1] <- 1#?
  
  ##################################################
  
  data2$cs1 <- NA
  data2$cs2 <- NA
  data2$pc_cs1 <- NA
  data2$pc_cs2 <- NA
  for(i in 2:4){
    #aux <- data2[data2$level==i,]
    totl <- sum(data2[data2$level==i,]$N)
    
    data2[data2$level==i,]$cs2 <- cumsum(data2[data2$level==i,]$N)
    data2[data2$level==i,]$cs1 <- c(0,data2[data2$level==i,]$cs2[1:6])
    #If we have the same number of factors for each level
    
    data2[data2$level==i,]$pc_cs1 <- data2[data2$level==i,]$cs1 /totl
    data2[data2$level==i,]$pc_cs2 <- data2[data2$level==i,]$cs2 /totl
  }
  data2
  data2[data2$level==1,]$cs1[1] <- 0
  data2[data2$level==1,]$cs2[1] <- data2[data2$level==1,]$N[1]
  #
  data2[data2$level==1,]$pc_cs1[1] <- 0
  data2[data2$level==1,]$pc_cs2[1] <- 1#?
  
  if(PC == T){
    pl <- ggplot() + theme_classic() +
      geom_rect(data = data1, aes(xmin = level - (0.5 - abs(spacing)), xmax = level - abs(spacing),
                    ymin = 100*pc_cs1, ymax = 100*pc_cs2,
                    fill = name), alpha = opacity) + 
      geom_rect(data = data2, aes(xmin = level + abs(spacing), xmax = level + (0.5 - abs(spacing)),
                                  ymin = 100*pc_cs1, ymax = 100*pc_cs2,
                                  fill = name), alpha = 0.6*opacity, color = 'black') + 
      ylab('Percentage of population (%)') + 
      labs(fill = '') +
      scale_x_continuous(breaks = seq(1,4),
                         labels = x_labels#c('Priority population',
                         #  'Motivation',
                         #  'Access',
                         #  'Effective use')
      ) + annotate('text', x = 0.5*(1 - (0.5 - abs(spacing)) + 1 - abs(spacing)),
                   y = 50, angle = 90, label = dataset_names[1], color = 'white', size = text_sz) +
      annotate('text', x = 0.5*(1 + abs(spacing) + 1 + (0.5 - abs(spacing))),
          y = 50, angle = 90, label = dataset_names[2], color = 'white', size = text_sz) 
  }
  return(pl)
}
