df <- data.frame('level' = 1, 'N' = 732, 'in_Q' = 1, reason = NA)

df <- rbind(df, c('level' = 2, N = 544, 'in_Q' = 1, reason = NA))
df <- rbind(df, c('level' = 2, N = 54, 'in_Q' = 0, reason = 'dull'))
df <- rbind(df, c('level' = 2, N = 42, 'in_Q' = 0, reason = 'smelly'))
df <- rbind(df, c('level' = 2, N = 132, 'in_Q' = 0, reason = 'ScottishGuy'))

df <- rbind(df, c('level' = 3, N = 375, 'in_Q' = 1, reason = NA))
df <- rbind(df, c('level' = 3, N = 47, 'in_Q' = 0, reason = 'boring'))
df <- rbind(df, c('level' = 3, N = 41, 'in_Q' = 0, reason = 'crunchy'))
df <- rbind(df, c('level' = 3, N = 112, 'in_Q' = 0, reason = 'The PM'))

df <- rbind(df, c('level' = 4, N = 189, 'in_Q' = 1, reason = NA))
df <- rbind(df, c('level' = 4, N = 77, 'in_Q' = 0, reason = 'Wednesdays'))
df <- rbind(df, c('level' = 4, N = 31, 'in_Q' = 0, reason = 'TopGun'))
df <- rbind(df, c('level' = 4, N = 92, 'in_Q' = 0, reason = 'Quiz'))

#df
df$level <- as.integer(df$level)
df$N <- as.integer(df$N)
df$in_Q <- as.integer(df$in_Q)