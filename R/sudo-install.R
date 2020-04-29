sudo_install <- function(pkgs) {
    ## pkgs_str <- paste0('"', pkgs, '"') %>%
    ##     paste(collapse=',') %>%
    ##     paste("c(", ., ")")
    rcmd0 <- 'options(repos = c(CRAN = "https://mirrors.e-ducation.cn/CRAN/"));'
    for (pkg in pkgs) {
        pkg <- paste0('"', pkg, '"')
        rcmd <- paste0('install.packages(', pkg, ')')
        rcmd <- paste0(rcmd0, rcmd)
        cmd <- paste0("sudo Rscript -e '", rcmd, "'")
        system(cmd)
    }
}
