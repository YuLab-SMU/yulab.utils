#' @rdname baidu-translate
#' @export
en2cn <- function (x) {
    baidu_translate(x, from = 'en', to = 'zh')
}

#' @rdname baidu-translate
#' @export
cn2en <- function (x) {
    baidu_translate(x, from = 'zh', to = 'en')
}


#' Translate query sentence
#' 
#' This function use the Baidu fanyi API to translate query sentences
#' @title baidu_translate
#' @rdname baidu-translate
#' @param x query sentence
#' @param from source language, i.e., the language to be translated
#' @param to target language, i.e., the language to be translated into
#' @return the translated sentence
#' @author Guangchuang Yu 
#' @export
baidu_translate <- function(x, from = 'en', to = 'zh') {
    vapply(x, .baidu_translate, from = from, to = to, FUN.VALUE = character(1))
}

.baidu_translate <- function(x, from = 'en', to = 'zh') {
    url <- httr::modify_url("http://api.fanyi.baidu.com/api/trans/vip/translate",
            query = baidu_translate_query(x, from = from, to = to)
        )
    url <- url(url, encoding = "utf-8")
    res <- jsonlite::fromJSON(url)
    
    return(res$trans_result$dst)
}

baidu_translate_query <- function(x, from, to) {
    salt <- sample.int(1e+05, 1) 
    .info <- getOption('.baidu_translate')
    sign <- sprintf("%s%s%s%s", .info$appid, x, salt, .info$key)
    .sign <- openssl::md5(sign)

    .query <- list(q = x, from = from, to = to,
                    appid = .info$appid, 
                    salt = salt, 
                    sign = .sign
                )
    return(.query)
}

