library(dplyr)
library(stringr)

# Function to process the input data
process_data <- function(file_path) {
  # Read the file content
  input_data <- readLines(file_path)
  
  # Extract hexadecimal numbers
  hex_data <- str_extract_all(input_data, "0x[0-9A-Fa-f]+") %>%
    lapply(as.character) %>%
    do.call(rbind, .) %>%
    as.data.frame(stringsAsFactors = FALSE)
  
  # Extract character symbols
  character_symbols <- str_extract(input_data, "\\(.*\\)") %>%
    str_remove_all("[()]")
  
  # Combine data and character symbols
  data <- cbind(hex_data, character = character_symbols)
  colnames(data) <- c(paste0("hex", 1:8), "character")
  
  return(data)
}

# Specify the path to your file
file_path <- "font_file.txt"

# Process the data
font <- process_data(file_path)

font[9,]$character <- "("
font[10,]$character <- ")"
font[61,]$character <- "\\"

# Print the output data
print(font)
