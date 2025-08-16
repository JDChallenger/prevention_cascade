df <- data.frame('level' = 1, 'N' = 732, 'in_Q' = 1, reason = NA)

df <- rbind(df, c('level' = 2, N = 544, 'in_Q' = 1, reason = NA))
df <- rbind(df, c('level' = 2, N = 54, 'in_Q' = 0, reason = 'Knowledge'))
df <- rbind(df, c('level' = 2, N = 42, 'in_Q' = 0, reason = 'Risk perception'))
df <- rbind(df, c('level' = 2, N = 132, 'in_Q' = 0, reason = 'Social Norms'))

df <- rbind(df, c('level' = 3, N = 375, 'in_Q' = 1, reason = NA))
df <- rbind(df, c('level' = 3, N = 47, 'in_Q' = 0, reason = 'Easy Access'))
df <- rbind(df, c('level' = 3, N = 41, 'in_Q' = 0, reason = 'Affordable'))
df <- rbind(df, c('level' = 3, N = 112, 'in_Q' = 0, reason = 'Caregiver awareness'))

df <- rbind(df, c('level' = 4, N = 189, 'in_Q' = 1, reason = NA))
df <- rbind(df, c('level' = 4, N = 77, 'in_Q' = 0, reason = 'In-date medication'))
df <- rbind(df, c('level' = 4, N = 31, 'in_Q' = 0, reason = 'Adherence'))
df <- rbind(df, c('level' = 4, N = 92, 'in_Q' = 0, reason = 'Partner'))

#df
df$level <- as.integer(df$level)
df$N <- as.integer(df$N)
df$in_Q <- as.integer(df$in_Q)