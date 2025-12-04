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
    #if (is(OrgDb, "character")) {
    #    require(OrgDb, character.only = TRUE)
    #    OrgDb <- eval(parse(text=OrgDb))
    #}
    if (is(OrgDb, "character")) {
        OrgDb <- utils::getFromNamespace(OrgDb, OrgDb)
    } 
    
    return(OrgDb)
}
