# Prevention Cascade
Visualise an HIV prevention cascade

Note: this repo is currently under construction, and is not yet ready to be used reliably. But any testing would be useful.

## Installation guidance
To use the R scripts, one option is to click on the green button above, marked 'Code', and download the ZIP file that contains the contents of this repository. Or, within RStudio you could select the 'New Project' option (from within the File menu), choose the Version Control option, select Git and enter the URL of this webpage when prompted.

To visualise a prevention cascade, you should open the 
script **create_cascade.R**. Running this script will 
load a hypothetical dataset (defined in the script **synthetic_data.R**), which you can replace with your own data. The user-defined R function that generates the visualisation can be viewed in the file **visualise_cascade_function.R**. This function contains several arguments, to allow the user to customise their plot. These arguments are described in **create_cascade.R**. Run this script line by line, to understand the options available.
