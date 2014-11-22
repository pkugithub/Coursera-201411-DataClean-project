PROGRAM DESCRIPTION:

run_analysis.R processes the 'weareable device' data in the zipped data file bundle located at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Before running this script, you should make sure the following prerequisites have been met:

- install.packaged("dplyr") in R 
- the machine on which you are running R have internet access and the above URL 
  (where the zipped data file bundle is located) is accessible

In R:

1. setwd() to the directory where run_analysis.R resides.   
2. source('./run_analysis.R')

Upon executing run_analysis.R, an outputfile named result_group_by_subject_act.txt is written
to the same directory as where run_analysis.R resides.   See Codebook.md for details on the
contents of result_group_by_subject_act.txt.


QA DETALS:

- run_analysis.R has been tested on RStudio/R on Mac OS 10.9.4
> RStudio 0.98.1091 
> R.version
               _                           
platform       x86_64-apple-darwin13.4.0   
arch           x86_64                      
os             darwin13.4.0                
system         x86_64, darwin13.4.0        
status                                     
major          3                           
minor          1.2                         
year           2014                        
month          10                          
day            31                          
svn rev        66913                       
language       R                           
version.string R version 3.1.2 (2014-10-31)
nickname       Pumpkin Helmet   



