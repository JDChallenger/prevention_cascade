# These are the packages we'll need.
# If you don't have these installed, select the
# 'Install Packages' option from the Tools menu
library(ggplot2)
library(scales)

# If you don't have data to read in, you 
# can use the fake data provided
source('synthetic_data.R')
df

# TO DO: Add description of data format to be used here

# The function we'll use to generate the visualise is called
# 'visualise_cascade() . We load the function from this R script: 
source('visualise_cascade_function.R')

# The function has a number of arguments, 
# which allow the user to customise the plot.
# The only compulsory one is the specification of 
# the data frame to use:
visualise_cascade(data = df)

####### Now we'll go through a list of the other options:

# * plot_label
# This allows the user to add a label to the plot, 
# which is placed below the x-axis.
# By default, this is empty
visualise_cascade(data = df, 
                  plot_label = 'A description of the overall plot')

# * plot_title
#Alternatively, you may wish to add a title at the top of the plot
# By default, this is empty
visualise_cascade(data = df, 
                  plot_title = 'Plot title')

# * y_axis
# For the scale on the y axis, there are three options:
# (i) The number of people (y_axis = 'N')
# (ii) The percentage of the study population (y_axis = 'PC')
# (iii) Both options, with the percentage on a 2nd y axis (y_axis = 'both)

visualise_cascade(data = df, y_axis = 'N')
visualise_cascade(data = df, y_axis = 'both')
visualise_cascade(data = df, y_axis = 'PC')

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
visualise_cascade(data = df, 
                  colour_scheme = c('dodgerblue3','slateblue',
                                    'skyblue2','turquoise'))

# * second_colour
# This is the colour of the bars,
# for those not covered by effective treatment.
# By default, this is set to dark grey.
# But you could use anything, e.g.: 

visualise_cascade(data = df, 
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

visualise_cascade(data = df, order_reasons = 'AZ')
visualise_cascade(data = df, order_reasons = 'ascend')
visualise_cascade(data = df, order_reasons = 'descend')

# * buffer_x
# Allows the user to add extra space in the x direction
# This is in units of the number of levels
# i.e. buffer_x = 1 adds white space of the width of one 'bar'
# The default is 0
visualise_cascade(data = df, buffer_x = 1)

# * buffer_y
# This adds extra white space at the top of the plot
# This could be useful if some of the labels are 
# falling off the top of the plot
# The scale of this matches the number of people in the 
# cascade. E.g. if level 1 contains 100 people,
# setting buffer_y=10 adds 10% extra space to the plot
visualise_cascade(data = df, buffer_y = 70) 

# * label_buffer
# This determines the gap between the bar for each
# reason, and the corresponding label
# As the scale on the y-axis is determined by the
# number of people in the study, this can be useful to 
# scale this value, e.g.:

#make the gap 4% of plot size (ignoring extra space introduced by buffer_y)
#If not specified, the default is 2.5%
visualise_cascade(data = df, 
                  label_buffer = 0.04*max(df$N))

# * font_size1, font_size2
# These arguments change the font sizes for the labels
# font_size1 is larger, and for the numbers of people 
# remaining in the cascade.
# By default, font_size1= 5.1, font_size2 = 3.4
visualise_cascade(data = df, 
                  font_size1= 6, font_size2 = 2) 

# * verbose
# if verbose==T (True), then extra info is printed to 
# the console while the function is running
visualise_cascade(data = df, verbose = T)

###### That's the end of the list of options

# any of these options can be used together, e.g.:
visualise_cascade(data = df, 
                  plot_title = 'Treatment cascade',
                  colour_scheme = c('dodgerblue3','slateblue',
                                    'skyblue2','turquoise'),
                  order_reasons = 'descend',
                  buffer_y = 77)
#if you wish, you can save the plot.
#PDF plot is high-resolution, but PNG can be easier to 
#include in (e.g.) Word/Powerpoint
ggsave('cascade.pdf', height = 6, width = 7.8)
ggsave('cascade.png', height = 6, width = 7.8)
