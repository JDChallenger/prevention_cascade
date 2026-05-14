library(ggplot2)
library(scales) #for label_wrap()

#bray <- paste0('bray',seq(1,9,1))
brayX <- c('Condoms', 'VMMC', 'PrEP',
           'Condoms + VMMC', 'Condoms + PrEP',
           'VMMC + PrEP', 'Condoms + VMMC + PrEP' )
dx1 <- data.frame(name = 'Total Population', level = 1)
dx2 <- as.data.frame(expand.grid('name' = brayX, 'level' = c(2,3,4)))
dx <- rbind(dx1, dx2)

dx$level_name <- NA #not in use at the moment 
#(https://www.andrewheiss.com/blog/2022/06/23/long-labels-ggplot/)
dx$N <- NA
dx[dx$level==1,]$N <- 733
dx[dx$level==1,]$level_name <- 'Priority population'

dx[dx$level==2,]$N <- c(37,144,29,26,117,44,53)
dx[dx$level==2,]$level_name <- 'Motivation'

dx[dx$level==3,]$N <- c(30,84,20,15,90,32,44)
dx[dx$level==3,]$level_name <- 'Access'

dx[dx$level==4,]$N <- c(10,44,16,11,67,24,40)
dx[dx$level==4,]$level_name <- 'Effective use'

table(dx$N, useNA = 'a')

ggplot(dx) + 
  geom_bar(aes(x = level, y = N, fill = name),
           position="stack", stat="identity") + 
  theme_classic()

#In the legend, I would prefer to have Total Population as the top colour
# We can achieve this by making name a factor variable, then changing the 
# first 'level' in the factor variable

dx$name <- as.factor(dx$name)
dx$name <- relevel(dx$name, "Total Population") 

ggplot(dx) + 
  geom_bar(aes(x = level, y = N, fill = name),
           position="stack", stat="identity") + 
  theme_classic()

# dx$cs1 <- NA
# dx$cs2 <- NA
# dx$pc_cs1 <- NA
# dx$pc_cs2 <- NA
# for(i in 2:4){
#   #aux <- dx[dx$level==i,]
#   totl <- sum(dx[dx$level==i,]$N)
#   
#   dx[dx$level==i,]$cs2 <- cumsum(dx[dx$level==i,]$N)
#   dx[dx$level==i,]$cs1 <- c(0,dx[dx$level==i,]$cs2[1:6])
#   #If we have the same number of factors for each level
#   
#   dx[dx$level==i,]$pc_cs1 <- dx[dx$level==i,]$cs1 /totl
#   dx[dx$level==i,]$pc_cs2 <- dx[dx$level==i,]$cs2 /totl
# }
# dx
# dx[dx$level==1,]$cs1[1] <- 0
# dx[dx$level==1,]$cs2[1] <- dx[dx$level==1,]$N[1]
# #
# dx[dx$level==1,]$pc_cs1[1] <- 0
# dx[dx$level==1,]$pc_cs2[1] <- 1#?
# 
# ggplot(dx) + theme_classic() + labs(fill = '') +
#   geom_rect(aes(xmin = level - 0.49, xmax = level + 0.49,
#                 ymin = cs1, ymax = cs2, fill = name),
#             alpha = .72) + 
#   scale_x_continuous(breaks = seq(1,4),
#                      labels = c('Priority\npopulation',
#                                 'Motivation',
#                                 'Access',
#                                 'Effective\nuse')) 
# 
# 
# ggplot(dx) + theme_classic() +
#   geom_rect(aes(xmin = level - 0.49, xmax = level + 0.49,
#                 ymin = 100*pc_cs1, ymax = 100*pc_cs2,
#                 fill = name), alpha = .65) + 
#   ylab('Percentage of population (%)') + 
#   labs(fill = '') +
#   scale_x_continuous(breaks = seq(1,4),
#                      labels = c('Priority population',
#                                 'Motivation',
#                                 'Access',
#                                 'Effective use'))  

source('fn_name.R')

fn_name(data = dx)
fn_name(data = dx, PC = F)
fn_name(data = dx, PC = F, opacity = 0.3)
fn_name(data = dx, PC = F, opacity = 0.5, spacing = 0.06)

# Second dataset

dy <- rbind(dx1, dx2)

dy$level_name <- NA #not in use at the moment 
#(https://www.andrewheiss.com/blog/2022/06/23/long-labels-ggplot/)
dy$N <- NA
dy[dy$level==1,]$N <- 668
dy[dy$level==1,]$level_name <- 'Priority population'

dy[dy$level==2,]$N <- c(33,99,34,26,97,14,63)
dy[dy$level==2,]$level_name <- 'Motivation'

dy[dy$level==3,]$N <- c(30,84,20,15,80,12,34)
dy[dy$level==3,]$level_name <- 'Access'

dy[dy$level==4,]$N <- c(17,49,13,10,64,4,20)
dy[dy$level==4,]$level_name <- 'Effective use'

table(dy$N, useNA = 'a')

fn_name(data = dy, PC = T, opacity = 0.5, spacing = 0.06)

fn_name2(data1 = dx, data2 = dy, PC = T, spacing = 0.02, 
         dataset_names = c('2003','2011'), opacity = 0.99) #+ theme(legend.position = 'top')
