#' Get a cookie value by name from a cookie string
#'
#' @param cookie_string the cookie string
#' @param name the name of the cookie
#'
get_cookie <- function(cookie_string, name) {
  cookie_string <- "session=.eJzNkz2P1DAQQP-Li6tWG3_HjrSivuI6RIOQNfaMb60Lycp2DhDiv-MT2yIakGjH8968xt9ZyJXalS0Z1kYnFgqyhUXrPTjPZ2skoc-KexezkjF6r6PyXHONck5Zi4xghYoYlZBkuVMyW3AwWMxO5hm9kT4LPjtpYzQuxcyVytyjcko70hIM5OiRnJbRKscFCDZCblQ_w0ZbZ0uvx0hLrebQ9xfaRmGyYAjRzXbWBpV12coopZ2jV8YqVDFhRAnDhPAcWod-tJDL2qkOHFIvrzQe1z3BSmMyrCd2g2cK19L6Xr-x5SO79n5bpklIfpbmLLw-e7M47sTUob2UbWi3RNM6iOldyGsPKrydK3iJ0K714T57O0-X4xbyXkOlPuynvyxvR0rU2r_yPoQ9hfeDf7zzTzvS-qHQlwt9pXT0sm_D0mks4m8WoaX_OQ_pD32vUAvE9d7GPp3Y0aj--jGC_fgJHpEVDQ.X0Ilmg.fsuMQMm6Zyi971vGT-bQu34pmpA; _189ea=http://10.0.2.176:3838; _7f98d=http://10.0.3.145:3838; PGADMIN_LANGUAGE=en; port-token=42326b8b6bf7; token=bc30e967-8348-450d-8e72-677ece4715b6; user-id=rstudio|Sun%2C%2023%20Aug%202020%2014%3A11%3A18%20GMT|z3LU8I7leECh4QTL7CQYnIpLpJHMvUO%2B6ppnAtpe2V8%3D; user-list-id=9c16856330a7400cbbbba228392a5d83|Sun%2C%2023%20Aug%202020%2014%3A11%3A03%20GMT|jQ5iAMoxFN2DKZ5BYn%2BdO2cKoP%2FYta2HsbAFEPiEYlE%3D; persist-auth=1; csrf-token=eb8b13a3-4999-42da-8e22-b50de11fbcd1"

  cookies <- unlist(strsplit(cookie_string , split = "; ", fixed = TRUE))
  cookies <- lapply(cookies, function(x) {unlist(strsplit(x, split="=", fixed = TRUE))})

  cookies <- Reduce(function(acc, x) {
    val <- x[[2]]
    names(val) <- x[[1]]
    c(acc,val)
  },cookies,list())

  value <- cookies[[name]]
  if (rlang::is_empty(value)) {
    return(NULL)
  } else {
    return(value)
  }
}

#' Get user information as dataframe
#'
#' @param token token to be verified
get_user_df <- function(token) {
  resp <- httr::GET(getOption('simpleshinyauth.verify_token_api_url', 'http://fastapi/api/v1/verify_token'), query = list(token = token))
  df <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyDataFrame  = TRUE)
  df
}

#' check token is valid or not from server
#'
#' @param token token to be verified
verify_token <- function (token) {
  user <- get_user_df(token)
  print(user)
  if (identical(user, list())) {
    FALSE
  } else {
    TRUE
  }
}
