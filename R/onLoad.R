#' Adds static resources to shiny
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath("simpleshinyauth", system.file(package = "simpleshinyauth"))
}
