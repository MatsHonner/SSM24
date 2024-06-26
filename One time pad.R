library(png)

# Import matrix
img <- readPNG("enc.png")
img_gray <- (img[, , 1] + img[, , 2] + img[, , 3]) / 3
m <- as.matrix(img_gray)

# Clean edges
head(colSums(m), 30)
tail(colSums(m), 30)
m <- m[, 13:1448]
head(colSums(m), 30)
tail(colSums(m), 30)

head(rowSums(m), 30)
tail(rowSums(m), 30)
m <- m[13:176, ]
head(rowSums(m), 30)
tail(rowSums(m), 30)

# image(t(m))
# tmp <- m[1:8, 1:8]
# tmp

# Separate each character into a sub-matrix in a list
large_matrix <- m

sub_matrix_rows <- 8
sub_matrix_cols <- 8

num_sub_m_rows <- floor(nrow(large_matrix) / (sub_matrix_rows + 4)) + 1
num_sub_m_cols <- floor(ncol(large_matrix) / (sub_matrix_cols + 4)) + 1
num_rows <- num_sub_m_rows + 1
num_cols <- num_sub_m_cols + 1

sub_m <- vector("list", num_sub_m_rows * num_sub_m_cols)

index <- 1
for (i in 1:num_sub_m_rows) {
  for (j in 1:num_sub_m_cols) {
    start_row <- (i - 1) * (sub_matrix_rows + 4) + 1
    end_row <- start_row + sub_matrix_rows - 1
    start_col <- (j - 1) * (sub_matrix_cols + 4) + 1
    end_col <- start_col + sub_matrix_cols - 1
    
    sub_m[[index]] <- large_matrix[start_row:end_row, start_col:end_col]
    index <- index + 1
  }
}

# Add a vector with the corresponding hex numbers
bin_to_hex <- function(bin_vec) {
  # Collapse the binary vector to a single string
  bin_str <- paste(bin_vec, collapse = "")
  # Convert binary string to a hexadecimal string
  hex_str <- as.character(as.hexmode(strtoi(bin_str, base = 2)))
  return(hex_str)
}

add_hex_to_matrices <- function(matrix_list) {
  lapply(matrix_list, function(mat) {
    # Apply the bin_to_hex function to each column of the matrix
    hex <- apply(mat, 2, bin_to_hex)
    # Add the 'hex' vector as a new attribute to the matrix
    attr(mat, "hex") <- hex
    return(mat)
  })
}

matrix_list_with_hex <- add_hex_to_matrices(sub_m)

