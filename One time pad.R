#install.packages("BiocManager") 
#BiocManager::install("EBImage")
library(EBImage)
library(tidyverse)

img <- readImage("enc.png", "png")

img_gray <- channel(img, "gray")
img_bw <- img_gray > 0.5
#display(img_bw, method = "raster")

img_bw_transp <- t(img_bw) 

all_rows <- rowSums(img_bw_transp)
all_columns <- colSums(img_bw_transp)

#all_rows_reduced <- all_rows[13:192]
all_rows_reduced <- all_rows[13:180]
all_columns_reduced <- all_columns[13:1452]
head(all_rows_reduced, 20)
head(all_columns_reduced, 20)
tail(all_rows_reduced, 20)
tail(all_columns_reduced, 20)
img_bw_transp_reduced <- img_bw_transp[13:180,13:1452]

display(t(img_bw_transp_reduced), method = "raster")
