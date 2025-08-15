library(ggplot2)
library(scales)

#If you don't have data to read in, you 
# can use the fake data provided
source('synthetic_data.R')
df

fn <- function(data, plot_label = ' ', 
               plot_title = ' ',y_axis = 'both',
               color_scheme = -1, second_color = 'grey57',
               order_reasons = 'auto'){
  
  #if(color_scheme[1]==-1){
  l <- length(unique(data$level))
  csc <- scales::hue_pal()(l)
  #}else{
  if(length(color_scheme) == l){
    csc <- color_scheme
  }else{
    print('No user-defined colour scheme detected')
  }
  print(csc)
  #}
  
  #check data types are OK
  data$level <- as.integer(data$level)
  data$N <- as.integer(data$N)
  data$in_Q <- as.integer(data$in_Q)
  
  #base plot
  p1 <- ggplot() + geom_rect(data = data[data$in_Q==1,], 
                             aes(xmin = level - 0.5, xmax = level + 0.5, ymin = 0, ymax = N, fill = factor(level))) + 
    theme_classic() + theme(axis.ticks.x = element_blank(), axis.text.x = element_blank(),
                            legend.position = 'none') + 
    xlab(plot_label) + ylab('Study population') + 
    scale_fill_manual(values = csc) + 
    geom_text(data = data[data$in_Q==1,], aes(y = 0.1*(data[data$level==1,]$N),
                                              x = level, label = paste0('N = ',N)), color = 'white')
  
  if(plot_title!=' '){
    p1 <- p1 + ggtitle(plot_title)
  }
  #return(p1)
  
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
    print(aux)
    
    base <- data[data$level==lu[i] & data$in_Q==1,]$N
    print(base)
    
    for(j in 1:no){
      x1 <- i - 0.5 + (j-1)/no
      x2 <- i - 0.5 + (j)/no
      y1 <- base
      y2 <- base + aux[aux$order==j,]$N 
      
      txt <- aux[aux$order==j,]$reason
      txt_loc <- (x1 + x2)/2
      txt_loc_y <- base + 1.1*aux[aux$order==j,]$N 
      
      N_label = as.character(aux[aux$order==j,]$N)#paste0('N = ',aux[aux$order==j,]$N)
      N_pos_x <- txt_loc <- (x1 + x2)/2
      #N_pos_y <- base + 0.2*aux[aux$order==j,]$N #+ 25 # may need modifying
      N_pos_y <- base + 0.25*min(aux$N)
      
      dx <- rbind(dx, data.frame('sx1' = x1, 'sx2' = x2, 'sy1' = y1, "sy2" = y2,
                                 'text' = txt, 'text_loc' = txt_loc, 'text_loc_y' = txt_loc_y,
                                 'N_lab' = N_label, 'N_pos_x' = N_pos_x, 'N_pos_y' = N_pos_y))
      #p1 <- p1 + geom_rect(aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = 'black', alpha = .7)
    }
    
  }
  
  size1 <- 3.4
  size2 <- 4.5
  
  p2 <- p1 + geom_rect(data = dx, aes(xmin = sx1, xmax = sx2, ymin = sy1, ymax = sy2),
                       fill = second_color[1]) + #, color = 'darkred' 
    geom_text(angle = 90, data = dx, aes(x = text_loc, y = text_loc_y, label = text),
              vjust = 0.5, hjust = 0, size = size1, color = 'grey19') + 
    geom_text(color = 'grey87', data = dx, 
        aes(x = N_pos_x, y = N_pos_y, label = N_lab), 
        vjust = 0, size = size1)
  
  if(y_axis=='both'){
    p2 <- p2 + scale_y_continuous(sec.axis =
                                    sec_axis(~ . * (100/df[df$level==1,]$N[1]),
                                             name = "Study population (%)"))
  }
  
  #this is default? So don't need to specify...
  # if(y_axis=='N'){
  #   p2 <- p2 + scale_y_continuous(limits = c(0,df[df$level==1,]$N[1]))
  # }
  
  if(y_axis=='PC'){
    print('boom')
    p2 <- p2 + 
      scale_y_continuous(limits = c(0,df[df$level==1,]$N[1]),
                         breaks = c(0,0.25*df[df$level==1,]$N[1],
                                    0.5*df[df$level==1,]$N[1],
                                    0.75*df[df$level==1,]$N[1],
                                    df[df$level==1,]$N[1]),
                         labels = c("0%",'25%','50%','75%','100%'))
  }
  return(p2)
}
fn(data = df, plot_label = 'Bray')
fn(data = df, plot_label = 'Bray', y_axis = 'N')
fn(data = df, plot_label = 'Bray', y_axis = 'both')
fn(data = df, plot_label = 'Bray', y_axis = 'PC')

fn(data = df, plot_label = 'Title here', y_axis = 'both',
   color_scheme = c('dodgerblue3','slateblue','skyblue2','turquoise'),
   second_color = 'grey39', order_reasons = 'ascend', plot_title = 'Or title here')

fn(data = df, plot_label = 'Bray', y_axis = 'N')
fn(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'xyz')
fn(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'AZ')
fn(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'ascend')
fn(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'descend')
