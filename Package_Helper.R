#################################################################################
# Library Helper Functions
# v1 28th March 2019
# Mark Goble
#################################################################################
# Version History
# 29th March 2019 - Initial version created 

package_loader <- function(package_list) {
  
  installed_packages <- installed.packages()[,1]
  
  missing_packages <-  package_list[vapply(package_list, function(x) !x %in% installed_packages, logical(1))]
  
  if(length(missing_packages) >0) {
    #install the required libraries if there are any in the missing_packages list
    # todo make this more robust by putting error handling round the packages load 
    lapply(missing_packages, install.packages)
  } 
  
  #once the packages are installed then load them
  
  lapply(package_list,library, character.only = TRUE)
  
  # test condition to make sure the stop works
  #detach("package:wordcloud", unload=TRUE)
  
  
  # now test to make sure all the packages have loaded before proceding 
  loaded_packages <- .packages()
  
  unloaded_packages <- any(vapply(package_list, function(x) !x %in% loaded_packages, logical(1)))
  
  #handle where not all the packages are installed
  if(unloaded_packages == TRUE){
    stop("not all the libraries are loaded", call. = FALSE)
  }
  
  #tidy up
  rm(installed_packages,loaded_packages,unloaded_packages)
}





