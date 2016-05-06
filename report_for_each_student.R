# load packages
library(knitr)
library(markdown)
library(rmarkdown)

# use first 5 rows of mtcars as example data
mtcars <- c("Shannon","Allyson","Allyn" ,"Jake","Ashley","Matt","Kayla","Elizabeth" ,"Larry","Nicki","Aditi")


# for each type of car in the data create a report
# these reports are saved in output_dir with the name specified by output_file
for (car in mtcars){
  rmarkdown::render('biometry_presentation_summary.Rmd',  # file 2
                    output_file =  paste("report_", car, '_', Sys.Date(), ".html", sep=''), 
                    output_dir = '../../Dropbox/Teaching/2016_Spring_Biometry/')
}