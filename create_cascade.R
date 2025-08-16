library(ggplot2)
library(scales)

#If you don't have data to read in, you 
# can use the fake data provided
source('synthetic_data.R')
df

source('visualise_cascade_function.R')

visualise_cascade(data = df, plot_label = 'Bray')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'N')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'both')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'PC')

visualise_cascade(data = df, plot_label = 'Title here', y_axis = 'both',
   color_scheme = c('dodgerblue3','slateblue','skyblue2','turquoise'),
   second_color = 'grey39', order_reasons = 'ascend', plot_title = 'Or title here')

visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'N')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'xyz')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'AZ')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'ascend')
visualise_cascade(data = df, plot_label = 'Bray', y_axis = 'N', order_reasons = 'descend')
