#' load OrgDb
#'
#' 
#' @title load_OrgDb
#' @param OrgDb OrgDb object or OrgDb name
#' @return OrgDb object
#' @importFrom methods is
#' @importFrom utils getFromNamespace 
#' @export
#' @author Guangchuang Yu \url{https://yulab-smu.top}
load_OrgDb <- function(OrgDb) {
    if (is.character(OrgDb)) {
        check_packages(OrgDb, "for `load_OrgDb()`")
        # OrgDb <- utils::getFromNamespace(OrgDb, OrgDb)
        OrgDb <- get(OrgDb, envir = asNamespace(OrgDb))
    }
    return(OrgDb)
}
