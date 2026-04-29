library(ggplot2)

bray <- paste0('bray',seq(1,9,1))
dx1 <- data.frame('bray' = NA, level = 1)
dx2 <- as.data.frame(expand.grid('bray' = bray, 'level' = c(2,3,4)))
dx <- rbind(dx1, dx2)

dx$N <- NA
dx[dx$level==1,]$N <- 733

dx[dx$level==2,]$N <- c(37,144,29,26,97,44,53,82,29)

dx[dx$level==3,]$N <- c(30,84,20,15,71,32,44,70,18)

dx[dx$level==4,]$N <- c(10,44,16,11,57,24,40,30,11)

table(dx$N, useNA = 'a')

ggplot(dx) + 
  geom_bar(aes(x = level, y = N, fill = bray),
           position="stack", stat="identity") + 
  theme_classic()

ggplot(dx) + theme_classic() +
  geom_rect(aes(xmin = level - 0.5, xmax = level + 0.5,
                ymin = 0, ymax = N, fill = bray), alpha = .2) #+

dx$cs1 <- NA
dx$cs2 <- NA
for(i in 2:4){
  #aux <- dx[dx$level==i,]
  
  dx[dx$level==i,]$cs2 <- cumsum(dx[dx$level==i,]$N)
  dx[dx$level==i,]$cs1 <- c(0,dx[dx$level==i,]$cs2[1:8])
  #If we have the same number of factors for each level
  
}
dx
dx[dx$level==1,]$cs1[1] <- 0
dx[dx$level==1,]$cs2[1] <- dx[dx$level==1,]$N[1]

ggplot(dx) + theme_classic() +
  geom_rect(aes(xmin = level - 0.5, xmax = level + 0.5,
                ymin = cs1, ymax = cs2, fill = bray), alpha = .32) 
