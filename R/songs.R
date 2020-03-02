#' LP's Lyrics
#'
#' This package contains the complete lyrics of LP's 5 completed,
#' published albums, formatted to be convenient for text analysis.
#' @docType package
#' @name lp
#' @aliases lp lp-package
NULL

#' The lyrics of LP's album "Heart-Shaped Scar" (2001)
#'
#' A dataset containing the lyrics of LP's 2001 album "Heart-Shaped Scar".
#' The UTF-8 plain text was sourced manually created Excel files with the
#' lyrics obtained from Genius. (Some elements are blank.)
#'
#' @source \url{https://genius.com/albums/Lp/Heart-shaped-scar}
#' @format A list with 24 elements
"heart_shaped_scar"

#' The lyrics of LP's album "Suburban Sprawl and Alcohol" (2004)
#'
#' A dataset containing the lyrics of LP's 2001 album "Suburban Sprawl and Alcohol".
#' The UTF-8 plain text was sourced manually created Excel files with the
#' lyrics obtained from Genius. (Some elements are blank.)
#'
#' @source \url{https://genius.com/albums/Lp/Suburban-sprawl-alcohol}
#' @format A list with 24 elements
"suburban_sprawl_and_alcohol"

#' The lyrics of LP's album "Forever For Now" (2014)
#'
#' A dataset containing the lyrics of LP's 2014 album "Forever For Now".
#' The UTF-8 plain text was sourced manually created Excel files with the
#' lyrics obtained from Genius. (Some elements are blank.)
#'
#' @source \url{https://genius.com/albums/Lp/Forever-for-now-deluxe-edition}
#' @format A list with 24 elements
"forever_for_now"

#' The lyrics of LP's album "Lost On You" (2016)
#'
#' A dataset containing the lyrics of LP's 2016 album "Lost On You".
#' The UTF-8 plain text was sourced manually created Excel files with the
#' lyrics obtained from Genius. (Some elements are blank.)
#'
#' @source \url{https://genius.com/albums/Lp/Lost-on-you-international-version}
#' @format A list with 13 elements
"lost_on_you"

#' The lyrics of LP's album "Heart to Mouth" (2018)
#'
#' A dataset containing the lyrics of LP's 2018 album "Heart to Mouth".
#' The UTF-8 plain text was sourced manually created Excel files with the
#' lyrics obtained from Genius. (Some elements are blank.)
#'
#' @source \url{https://genius.com/albums/Lp/Heart-to-mouth}
#' @format A list with 12 elements
"heart_to_mouth"

#' Convert a single album to a data.frame
#' @keywords internal
album_to_df <- function(data, album) {
  y <- data

  # just to avoid a dependency on stringr
  # using str_to_title() would be an overkill
  names(y) <- gsub("_", " ", names(y))
  names(y) <- gsub("i m", "I'm", names(y))
  names(y) <- gsub(" live", " (Live)", names(y))
  names(y) <- gsub("\\b([[:lower:]])([[:lower:]]+)", "\\U\\1\\E\\2", names(y), perl=TRUE)
  names(y) <- gsub(" i ", " I ", names(y))
  names(y) <- gsub(" To ", " to ", names(y))
  names(y) <- gsub(" The ", " the ", names(y))
  names(y) <- gsub(" In ", " in ", names(y))
  names(y) <- gsub("Its ", "It's ", names(y))
  names(y) <- gsub("With ", "with ", names(y))

  z <- data.frame(album = album,
                  song = names(y),
                  lyrics = as.character(
                    lapply(seq_along(y), function(a) { paste(y[[a]], collapse = "\n") })
                    ),
                  stringsAsFactors = FALSE
                  )

  return(z)
}

#' Tidy data frame of LP's 5 completed, published albums
#'
#' Returns a tidy data frame of LP's 5 completed, published albums with
#' three columns:  \code{album} which contains the titles of the albums as a
#' factor in order of publication, \code{song} which contains the titles of the
#' songs as factor in order of playing considering repetition, and
#' \code{lyrics}, which contains the lyrics of the songs.
#'
#' @return A data frame with three columns: \code{album}, \code{song} and
#' \code{lyrics}
#'
#' @name lp_songs
#'
#' @examples
#' library(dplyr)
#'
#' lp_songs() %>%
#'    group_by(album) %>%
#'    summarise(number_of_songs = n())
#'
#' @export
lp_songs <- function() {
  songs <- list(
    "Heart-Shaped Scar" = album_to_df(lp::heart_shaped_scar, album = "Heart-Shaped Scar"),
    "Suburban Sprawl and Alcohol" = album_to_df(lp::suburban_sprawl_and_alcohol, album = "Suburban Sprawl and Alcohol"),
    "Forever For Now" = album_to_df(lp::forever_for_now, album = "Forever For Now"),
    "Lost On You" = album_to_df(lp::lost_on_you, album = "Lost On You"),
    "Heart to Mouth" = album_to_df(lp::lost_on_you, album = "Heart to Mouth")
  )

  songs <- do.call(rbind, songs)
  songs$album <- factor(songs$album, levels = unique(songs$album))
  songs$song <- factor(songs$song, levels = unique(songs$song))

  structure(songs, class = c("tbl_df", "tbl", "data.frame"))
}
