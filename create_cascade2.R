# These are the packages we'll need.
# If you don't have these installed, select the
# 'Install Packages' option from the Tools menu
library(ggplot2)
library(scales)
library(readxl)

# If you don't have data to read in, you 
# can use the fake data provided
source('synthetic_data.R')
df

# TO DO: Add description of data format to be used here

# The function we'll use to generate the visualise is called
# 'visualise_cascade2() . We load the function from this R script: 
source('visualise_cascade_function2.R')

# The function has a number of arguments, 
# which allow the user to customise the plot.
# The only compulsory one is the specification of 
# the data frame to use:
visualise_cascade2(data = df)

# Notice that the headings at the top looks a bit strange.
# Let's provide labels for these. At the moment, the
# reasons column has empty spaces in rows where in_Q = 1. 
# Let's use those spaces (I may update this)
df[df$level==1 & df$in_Q==1,]$reason <- 'Priority population'
df[df$level==2 & df$in_Q==1,]$reason <- 'Motivated to use'
df[df$level==3 & df$in_Q==1,]$reason <- 'Can access'
df[df$level==4 & df$in_Q==1,]$reason <- 'Effectively using'

#And run the function again...
visualise_cascade2(data = df)


# * plot_label
# This allows the user to add a label to the plot, 
# which is placed below the x-axis.
# By default, this is empty
visualise_cascade2(data = df, 
                  plot_label = 'A description of the overall plot')

# * plot_title
#Alternatively, you may wish to add a title at the top of the plot
# By default, this is empty
visualise_cascade2(data = df, 
                  plot_title = 'Plot title')

# * colour_scheme
# By default, we use the default ggplot2 colour scheme.
# But we can override this, by providing a list of colours.
# A list of named colours can be found here: https://sape.inf.usi.ch/quick-reference/ggplot2/colour
# You could also use "#RRGGBB" RGB colour strings, 
#but we won't show that here.
# Note: the length of the list needs to match the 
# number of levels in the cascade.
# Otherwise the function will print a warning message,
# and use the default values
visualise_cascade2(data = df, 
                  colour_scheme = c('dodgerblue3','slateblue',
                                    'skyblue2','turquoise'))

# * second_colour
# This is the colour of the bars,
# for those not covered by effective treatment.
# By default, this is set to dark grey.
# But you could use anything, e.g.: 

visualise_cascade2(data = df, 
                  colour_scheme = c('dodgerblue3','slateblue',
                                    'skyblue2','turquoise'),
                  second_colour = 'darkred')

# * order_reasons
# For each level of the cascade, this argument specifies
# the order in which the reasons are plotted. 
# The options are: (i) The order specified by the user in 
# the dataframe (the default); 
# (ii) Alphabetical (order_reasons='AZ); 
# (iii) Ascending (l to r) numerical values (order_reasons = 'ascend'); 
# (iv) Descending (l to r) numerical values (order_reasons = 'descend'); 

visualise_cascade2(data = df, order_reasons = 'AZ')
visualise_cascade2(data = df, order_reasons = 'ascend')
visualise_cascade2(data = df, order_reasons = 'descend')

# * space_y_PC
# This governs the amount of white space added to the top
# of the plot area. For this layout, this is important, 
# as this is where the labels for the reasons appear.
# This is expressed as a percentage, relative to the 
# height of 100% of the study population. The default is 66.67%,
# i.e. the area for the labels is two-thirds the height of the 
# bar chart. If you have long labels, you may need to increase this
# (or decrease the font size, see below)

visualise_cascade2(data = df, 
                   space_y_PC = 50)

#not included yet: buffer_x (do we need this?)
#not included yet: label_buffer (do we need this?)

# * font_size1, font_size2
# The former controls the size of the headings at the top.
# The latter controls the size of all other labels
# By default, font_size1 = 4 and font_size2=3.4

visualise_cascade2(data = df, font_size1 = 4.3, font_size2 = 2.5)

# * verbose
# Setting verbose = T prints extra info to the R console,
# while the function is running
visualise_cascade2(data = df, 
                   verbose = T)

# any of these options can be used together, e.g.:
visualise_cascade2(data = df, 
                  plot_title = 'Male condoms',
                  colour_scheme = c('dodgerblue3','slateblue',
                                    'skyblue2','turquoise'),
                  order_reasons = 'descend',
                  space_y_PC = 70)

#if you wish, you can save the plot.
#PDF plot is high-resolution, but PNG can be easier to 
#include in (e.g.) Word/Powerpoint
#For this layout, you may need to increase the height,
#to ensure that there is enough room for the labels
ggsave('cascade2.pdf', height = 6.8, width = 7.8)
ggsave('cascade2.png', height = 6.8, width = 7.8)
