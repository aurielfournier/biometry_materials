# load packages
library(knitr)
library(markdown)
library(rmarkdown)

# use first 5 rows of mtcars as example data
mtcars <- c("Shannon","Allyson","Allyn") #,"Jake","Ashley","Matt","Kayla","Elizabeth") #,"Larry","Nicki","Aditi")


# for each type of car in the data create a report
# these reports are saved in output_dir with the name specified by output_file
for (car in mtcars){
  rmarkdown::render('../Desktop/biometry_presentation_summary.Rmd',  # file 2
                    output_file =  paste("report_", car, '_', Sys.Date(), ".html", sep=''), 
                    output_dir = '../Desktop/')
  
  # for pdf reports  
  #   rmarkdown::render(input = "/Users/majerus/Desktop/R/auto_reporting/test/r_script_pdf.Rmd", 
  #           output_format = "pdf_document",
  #           output_file = paste("test_report_", car, Sys.Date(), ".pdf", sep=''),
  #           output_dir = "/Users/majerus/Desktop/R/auto_reporting/test/reports")
  
}