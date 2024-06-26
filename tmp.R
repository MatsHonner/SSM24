# # Example font data frame
# font <- data.frame(
#   hex1 = c("0x0C", "0x3F", "0x3C", "0x1F", "0x7F"),
#   hex2 = c("0x1E", "0x66", "0x66", "0x36", "0x46"),
#   hex3 = c("0x33", "0x66", "0x03", "0x66", "0x16"),
#   hex4 = c("0x33", "0x3E", "0x03", "0x66", "0x1E"),
#   hex5 = c("0x3F", "0x66", "0x03", "0x66", "0x16"),
#   hex6 = c("0x33", "0x66", "0x66", "0x36", "0x46"),
#   hex7 = c("0x33", "0x3F", "0x66", "0x1F", "0x7F"),
#   hex8 = c("0x00", "0x00", "0x00", "0x00", "0x00"),
#   character = c("A", "B", "C", "D", "E"),
#   stringsAsFactors = FALSE
# )

# Function to find the matching character for a given hex vector
find_character <- function(hex_vector, font_df) {
  # Convert the hex_vector to the same format as the font data frame
  hex_vector <- paste0("0x", toupper(hex_vector))
  # Compare the hex_vector to each row in the font data frame
  match_row <- which(
    font_df$hex1 == hex_vector[1] &
      font_df$hex2 == hex_vector[2] &
      font_df$hex3 == hex_vector[3] &
      font_df$hex4 == hex_vector[4] &
      font_df$hex5 == hex_vector[5] &
      font_df$hex6 == hex_vector[6] &
      font_df$hex7 == hex_vector[7] &
      font_df$hex8 == hex_vector[8]
  )
  # Return the corresponding character
  if (length(match_row) == 1) {
    return(font_df$character[match_row])
  } else {
    return(NA)
  }
}

# Function to add the matching character to each matrix in a list
add_character_to_matrices <- function(matrix_list, font_df) {
  lapply(matrix_list, function(mat) {
    # Get the hex vector from the matrix attributes
    hex_vector <- attr(mat, "hex")
    # Find the matching character
    character <- find_character(hex_vector, font_df)
    # Add the character as a new attribute to the matrix
    attr(mat, "character") <- character
    return(mat)
  })
}

# Add the matching character to each matrix in the list
matrix_list_with_character <- add_character_to_matrices(matrix_list_with_hex, font)

# Check the result
head(matrix_list_with_character)
