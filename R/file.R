##' open selected directory or file
##'
##'
##' @title o
##' @param file to be open; open workding directory by default
##' @return No return value, called for opening specific directory or file
##' @author Guangchuang Yu
##' @examples
##' \dontrun{
##' ## to open current working directory
##' o()
##' }
##' @export
o <- function(file=".") {
    os <- Sys.info()[1]
    if (is.rserver()) {
        if (dir.exists(file)) {
            stop("open directory in RStudio Server is not supported.")
        }
        rserver_ip <- getOption("rserver_ip")
        if (!is.null(rserver_ip)) {
            rserver_port <- getOption("rserver_port") %||% '8787' 
            if (!startsWith(rserver_ip, "http")) {
                rserver_ip = paste0("http://", rserver_ip)
            }
            utils::browseURL(
                       paste0(
                           paste(rserver_ip, rserver_port, sep=":"),
                           "/file_show?path=",
                           file
                       ))
        } else {
            file.edit <- get("file.edit")
            file.edit(file)   
        }
    } else if (os == "Darwin") {
        cmd <- paste("open", file)
        system(cmd)
    } else if (os == "Linux") {
        cmd <- paste("xdg-open", file, "&")
        system(cmd)
    } else if (os == "Windows") {
        ## wd <- sub("/", "\\", getwd())
        ## cmd <- paste("explorer", wd)
        ## suppressWarnings(shell(cmd))
        cmd <- paste("start", file)
        shell(cmd)
    }
}


is.rserver <- function(){
    RStudio.Version = tryCatch(get("RStudio.Version"), error = function(e) NULL)
    if(is.null(RStudio.Version)) return(FALSE)
    if(!is.function(RStudio.Version)) return(FALSE)
    RStudio.Version()$mode == 'server'
}
