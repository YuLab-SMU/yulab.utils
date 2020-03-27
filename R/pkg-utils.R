is.installed <- function(packages) {
  vapply(packages, function(package) {
    system.file(package=package) != ""
  }, logical(1))
}

