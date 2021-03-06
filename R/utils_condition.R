throw_validate <- function(...) {
  stop(condition_validate(...))
}

condition_validate <- function(...) {
  structure(
    list(message = paste0(..., collapse = ""), call = NULL),
    class = c(
      "condition_validate",
      "condition_tarchetypes",
      "error",
      "condition"
    )
  )
}
