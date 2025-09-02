visualise_cascade2 <- function(data, pop_label = 1,
                              plot_label = ' ', 
                              plot_title = ' ', #y_axis = 'both',
                              colour_scheme = -1, second_colour = 'grey57',
                              order_reasons = 'auto',
                              space_y_PC =66.67,
                              #buffer_x = 0, buffer_y = 0,
                              #reason_descr = 0,
                              #descr_prop = 0.4,
                              #label_buffer = -1,
                              font_size1= 4, font_size2 = 3.4,
                              verbose = F){
  
  l <- length(unique(data$level))
  if(length(colour_scheme) != l & length(colour_scheme) > 1){
    print('Check the colour scheme provided.')
  }
  
  csc <- scales::hue_pal()(l)
  #}else{
  if(length(colour_scheme) == l){
    csc <- colour_scheme
  }else{
    if(verbose==T){
      print('No user-defined colour scheme detected')
    }
  }
  if(verbose==T){
    print(csc)
  }
  
  #check data types are OK
  data$level <- as.integer(data$level)
  data$N <- as.integer(data$N)
  data$in_Q <- as.integer(data$in_Q)
  
  mx <- max(data[data$in_Q==1,]$N)
  epsilon <- 0.025 #could be a user-defined argument. But needs to be small!!
  
  # justification for y axis?
  hj <- 0.5/(1 + (space_y_PC/100))#max(0, 0.5*(1 - 0.5*(space_y_PC/100)))
  if(verbose==T){
    print(paste0('h_just for y axis title: ',hj))
  }
  
  #base plot
  p1 <- ggplot() + #geom_hline(yintercept = mx,
                #color = 'grey73',linewidth = 0.1) +
    annotate('segment', x = 0.5, xend = l + 0.5, y = mx, color = 'grey73') +
    geom_rect(data = data[data$in_Q==1,], 
                        aes(xmin = level - 0.5, 
                            xmax = level + 0.5,
                            ymin = 0, ymax = mx*(1+space_y_PC/100)), 
                        fill = NA, color = 'grey73',
                        linewidth = 0.1) +
    geom_rect(data = data[data$in_Q==1,], 
                             aes(xmin = level - 0.5, xmax = level + 0.5,
                                 ymin = 0, ymax = N, 
                                 fill = factor(level))) + 
    theme_classic() + 
    theme(axis.ticks.x = element_blank(), 
            axis.text.x = element_blank(),
            legend.position = 'none',
          axis.title.y = element_text(hjust = hj)) + 
    xlab(plot_label) + ylab('Study population (%)') + 
    scale_fill_manual(values = csc) + 
    geom_text(data = data[data$in_Q==1,], 
        aes(y = mx*(1+(space_y_PC + 5)/100), #0.1*(data[data$level==1,]$N),
          x = level, 
          label = paste0(reason, ' (n=',N,')')), 
            color = 'grey11', size = font_size1) + 
    scale_y_continuous(breaks = c(0,0.25*mx,0.5*mx,0.75*mx, mx),
                       labels = c(seq(0,100,25)))
  
  if(plot_title!=' '){
    p1 <- p1 + ggtitle(plot_title)
  }
  
  lu <- unique(data$level)
  l <- length(lu)
  dx <- data.frame()
  
  for(i in 2:l){
    
    aux <- data[data$level==lu[i] & data$in_Q==0,] #are these always in an order?
    no <- dim(aux)[1]
    if(order_reasons=='AZ'){
      aux <- aux[order(aux$reason),]
    }
    
    if(order_reasons=='ascend'){
      aux <- aux[order(aux$N),]
    }
    
    if(order_reasons=='descend'){
      aux <- aux[order(-aux$N),]
    }
    aux$order <- seq(1,no)
    if(verbose==T){
      print(aux)
    }
    
    base <- data[data$level==lu[i] & data$in_Q==1,]$N
    if(verbose==T){
      print(base)
    }
    
    for(j in 1:no){
      x1 <- i - 0.5 + (j-1)/no + epsilon
      x2 <- i - 0.5 + (j)/no - epsilon
      y1 <- base
      y2 <- base + aux[aux$order==j,]$N 
      
      txt <- aux[aux$order==j,]$reason
      txt_loc_x <- (x1 + x2)/2
      txt_loc_y <- mx*( 1 + 0.5*space_y_PC/100 )
      
      N_label = aux[aux$order==j,]$N#paste0('N=',aux[aux$order==j,]$N)#as.character(aux[aux$order==j,]$N)#
      N_pos_x <- (x1 + x2)/2
      #N_pos_y <- base + 0.2*aux[aux$order==j,]$N #+ 25 # may need modifying
      N_pos_y <- base + (aux[aux$order==j,]$N) + mx/50 #i.e. raise by a proportion of max N
      
      dx <- rbind(dx, data.frame('sx1' = x1, 'sx2' = x2, 'sy1' = y1, "sy2" = y2,
                                 'text' = txt, 'text_loc_x' = txt_loc_x, 'text_loc_y' = txt_loc_y,
                                 'N_lab' = N_label, 'N_pos_x' = N_pos_x, 'N_pos_y' = N_pos_y))
      #p1 <- p1 + geom_rect(aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = 'black', alpha = .7)
    }
    
  }
  
  size1 <- font_size1
  size2 <- font_size2
  
  p2 <- p1 + geom_rect(data = dx, aes(xmin = sx1, xmax = sx2, ymin = sy1, ymax = sy2),
                       fill = second_colour[1]) + #, color = 'darkred' 
    geom_text(angle = 90, data = dx, aes(x = text_loc_x, y = text_loc_y, label = text),
              vjust = 0.5, hjust = 0.5, size = size2, color = 'grey19') + 
    geom_text(color = 'grey37', data = dx, 
              aes(x = N_pos_x, y = N_pos_y, label = N_lab), 
              vjust = 0, size = size2)
  
   return(p2) 
}
# Are multiple y-axes here too fiddly? 

