visualise_cascade <- function(data, plot_label = ' ', 
                              plot_title = ' ',y_axis = 'both',
                              colour_scheme = -1, second_colour = 'grey57',
                              order_reasons = 'auto',
                              buffer_x = 0, buffer_y = 0,
                              reason_descr = 0,
                              descr_prop = 0.4,
                              label_buffer = -1,
                              font_size1= 5.1, font_size2 = 3.4,
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
  
  if(label_buffer==-1){
    label_buffer1 <- 0.025*max(data$N)
  }else{
    label_buffer1 <- label_buffer
  }
  
  #base plot
  p1 <- ggplot() + geom_rect(data = data[data$in_Q==1,], 
                             aes(xmin = level - 0.5, xmax = level + 0.5, ymin = 0, ymax = N, fill = factor(level))) + 
    theme_classic() + theme(axis.ticks.x = element_blank(), axis.text.x = element_blank(),
                            legend.position = 'none') + 
    xlab(plot_label) + ylab('Study population') + 
    scale_fill_manual(values = csc) + 
    geom_text(data = data[data$in_Q==1,], 
              aes(y = 0.4*min(data[data$in_Q==1,]$N), #0.1*(data[data$level==1,]$N),
              x = level, label = paste0('N = ',N)), 
              color = 'white', size = font_size1)
  
  if(plot_title!=' '){
    p1 <- p1 + ggtitle(plot_title)
  }
  
  if(reason_descr!=0){
    aux <- data[data$in_Q==1 & data$level>1,]
    da <- dim(aux)[1]
    aux$Nm1 <- NA
    aux$Nm1[1] <- max(data[data$in_Q==1,]$N)
    for(i in 2:da){
      aux$Nm1[i] <- aux$N[i-1]
    }
    #print(aux)
    p1 <- p1 + geom_rect(data = aux,
      aes(xmin = level - 0.5, xmax = level - 0.5 + descr_prop,
          ymin = N, ymax = Nm1), 
      fill = NA, color = 'grey22') + 
      geom_text(data = aux,
                aes(x = level - 0.5 + descr_prop*0.5, y = 0.5*(N + Nm1), 
                    label = reason), 
                color = 'darkred', size = font_size2)
  }
  
  lu <- unique(data$level)
  l <- length(lu)
  dx <- data.frame()
  
  if(reason_descr==0){
  
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
      x1 <- i - 0.5 + (j-1)/no
      x2 <- i - 0.5 + (j)/no
      y1 <- base
      y2 <- base + aux[aux$order==j,]$N 
      
      txt <- aux[aux$order==j,]$reason
      txt_loc <- (x1 + x2)/2
      txt_loc_y <- base + label_buffer1 + aux[aux$order==j,]$N 
      
      N_label = paste0('N=',aux[aux$order==j,]$N)#as.character(aux[aux$order==j,]$N)#
      N_pos_x <- txt_loc <- (x1 + x2)/2
      #N_pos_y <- base + 0.2*aux[aux$order==j,]$N #+ 25 # may need modifying
      N_pos_y <- base + 0.25*min(aux$N)
      
      dx <- rbind(dx, data.frame('sx1' = x1, 'sx2' = x2, 'sy1' = y1, "sy2" = y2,
                                 'text' = txt, 'text_loc' = txt_loc, 'text_loc_y' = txt_loc_y,
                                 'N_lab' = N_label, 'N_pos_x' = N_pos_x, 'N_pos_y' = N_pos_y))
      #p1 <- p1 + geom_rect(aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = 'black', alpha = .7)
    }
    
  }
  
  size1 <- font_size1
  size2 <- font_size2
  
  p2 <- p1 + geom_rect(data = dx, aes(xmin = sx1, xmax = sx2, ymin = sy1, ymax = sy2),
                       fill = second_colour[1]) + #, color = 'darkred' 
    geom_text(angle = 90, data = dx, aes(x = text_loc, y = text_loc_y, label = text),
              vjust = 0.5, hjust = 0, size = size2, color = 'grey19') + 
    geom_text(color = 'grey87', data = dx, 
              aes(x = N_pos_x, y = N_pos_y, label = N_lab), 
              vjust = 0, size = size2)
  }else{
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
        x1 <- i - 0.5 + descr_prop + (1-descr_prop)*(j-1)/no
        x2 <- i - 0.5 + descr_prop + (1-descr_prop)*(j)/no
        y1 <- base
        y2 <- base + aux[aux$order==j,]$N 
        
        txt <- aux[aux$order==j,]$reason
        txt_loc <- (x1 + x2)/2
        txt_loc_y <- base + label_buffer1 + aux[aux$order==j,]$N 
        
        N_label = paste0('N=',aux[aux$order==j,]$N)#as.character(aux[aux$order==j,]$N)#
        N_pos_x <- txt_loc <- (x1 + x2)/2
        #N_pos_y <- base + 0.2*aux[aux$order==j,]$N #+ 25 # may need modifying
        N_pos_y <- base + 0.25*min(aux$N)
        
        dx <- rbind(dx, data.frame('sx1' = x1, 'sx2' = x2, 'sy1' = y1, "sy2" = y2,
                                   'text' = txt, 'text_loc' = txt_loc, 'text_loc_y' = txt_loc_y,
                                   'N_lab' = N_label, 'N_pos_x' = N_pos_x, 'N_pos_y' = N_pos_y))
        #p1 <- p1 + geom_rect(aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = 'black', alpha = .7)
      }
      
    }
    
    size1 <- font_size1
    size2 <- font_size2
    
    p2 <- p1 + geom_rect(data = dx, aes(xmin = sx1, xmax = sx2, ymin = sy1, ymax = sy2),
                         fill = second_colour[1]) + #, color = 'darkred' 
      geom_text(angle = 90, data = dx, aes(x = text_loc, y = text_loc_y, label = text),
                vjust = 0.5, hjust = 0, size = size2, color = 'grey19') + 
      geom_text(color = 'grey87', data = dx, 
                aes(x = N_pos_x, y = N_pos_y, label = N_lab), 
                vjust = 0, size = size2)
  }
  
  if(y_axis=='both'){
    p2 <- p2 + 
      scale_x_continuous(limits = c(0.5, buffer_x + l + 0.5)) +
      scale_y_continuous(limits = c(0,buffer_y + df[df$level==1,]$N[1]),
                         sec.axis =
                           sec_axis(~ . * (100/df[df$level==1,]$N[1]),
                                    name = "Study population (%)",
                                    breaks = c(0,25,50,75,100)))
  }
  
  #this is default? So don't need to specify...
  #but useful if you have buffer_y > 0
  if(y_axis=='N'){
    p2 <- p2 + scale_y_continuous(limits = c(0,buffer_y + df[df$level==1,]$N[1])) + 
      scale_x_continuous(limits = c(0.5, buffer_x + l + 0.5))
  }
  
  if(y_axis=='PC'){
    #print('boom')
    p2 <- p2 + 
      scale_x_continuous(limits = c(0.5, buffer_x + l + 0.5)) +
    scale_y_continuous(limits = c(0,buffer_y + df[df$level==1,]$N[1]),
                       breaks = c(0,0.25*df[df$level==1,]$N[1],
                                  0.5*df[df$level==1,]$N[1],
                                  0.75*df[df$level==1,]$N[1],
                                  df[df$level==1,]$N[1]),
                       labels = c("0%",'25%','50%','75%','100%'))
  }
  return(p2)
}
