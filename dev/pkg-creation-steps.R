library(usethis)
library(readxl)
library(readr)
library(janitor)

use_directory("dev")
use_directory("data_raw")
use_directory("data")

use_cc0_license("Mauricio Vargas")
use_roxygen_md()
use_package("dplyr", type = "Suggest")
use_package("testthat", type = "Suggest")
use_readme_md()
use_git()
use_git_ignore("data_raw")
use_build_ignore("data_raw")
use_build_ignore("dev")
use_build_ignore("docs")
use_code_of_conduct()

# Heart-Shaped Scar ----

heart_shaped_scar <- read_excel("data_raw/heart_shaped_scar.xlsx")

heart_shaped_scar_2 <- as.list(heart_shaped_scar$lyrics)

for (i in seq_along(heart_shaped_scar_2)) {
  heart_shaped_scar_2[[i]] <- read_lines(heart_shaped_scar_2[[i]])
}

names(heart_shaped_scar_2) <- heart_shaped_scar$song
names(heart_shaped_scar_2) <- make_clean_names(names(heart_shaped_scar_2))
heart_shaped_scar <- heart_shaped_scar_2

# Lost on You ----

lost_on_you <- read_excel("data_raw/lost_on_you.xlsx")

lost_on_you_2 <- as.list(lost_on_you$lyrics)

for (i in seq_along(lost_on_you_2)) {
  lost_on_you_2[[i]] <- read_lines(lost_on_you_2[[i]])
}

names(lost_on_you_2) <- lost_on_you$song
names(lost_on_you_2) <- make_clean_names(names(lost_on_you_2))
lost_on_you <- lost_on_you_2

# Forever For Now ----

forever_for_now <- read_excel("data_raw/forever_for_now.xlsx")

forever_for_now_2 <- as.list(forever_for_now$lyrics)

for (i in seq_along(forever_for_now_2)) {
  forever_for_now_2[[i]] <- read_lines(forever_for_now_2[[i]])
}

names(forever_for_now_2) <- forever_for_now$song
names(forever_for_now_2) <- make_clean_names(names(forever_for_now_2))
forever_for_now <- forever_for_now_2

# Heath to Mouth ----

heart_to_mouth <- read_excel("data_raw/heart_to_mouth.xlsx")

heart_to_mouth_2 <- as.list(heart_to_mouth$lyrics)

for (i in seq_along(heart_to_mouth_2)) {
  heart_to_mouth_2[[i]] <- read_lines(heart_to_mouth_2[[i]])
}

names(heart_to_mouth_2) <- heart_to_mouth$song
names(heart_to_mouth_2) <- make_clean_names(names(heart_to_mouth_2))
heart_to_mouth <- heart_to_mouth_2

# Save ----

usethis::use_data(heart_shaped_scar, overwrite = T)
usethis::use_data(lost_on_you, overwrite = T)
usethis::use_data(heart_to_mouth, overwrite = T)
usethis::use_data(forever_for_now, overwrite = T)

