require.with.install.packages.if.necesarry = function(packages) {
  require.2 = function(p) {
    if( eval(parse(text = paste0("require(",p,")" ) ) ) ) {
      cat(paste(p, "is loaded. \n"))
    } else {
      cat(paste("trying to install", p, "... \n"))
      install.packages(p)
      if( eval(parse(text = paste0("require(",p,")" ) ) ) ) {
        cat(paste(p, "is loaded. \n"))
      } else {
        stop(paste(p, "could not be installed. \n"))
      }
    }
  }
  if(is.vector(packages)) {
    for( k in packages) {
      require.2(k)
    }    
  } else {
    require.2(packages)    
  }
}

detach.all.extra.packages <- function() {
  packages.default <- getOption("defaultPackages")
  search.paths <- search()
  packages.loaded <- search.paths[ifelse(unlist(gregexpr("package:", 
                                                         search.paths)) == 1, 
                                         TRUE, 
                                         FALSE)]
  packages.extra <- setdiff(packages, packages.default)
  lapply(packages.extra, detach, character.only = TRUE)
}

set.proxy = function(proxy) {
  if( is.list(proxy) ) {
    if(length(setdiff(names(proxy), c("http", "https", "ftp"))) == 0 ) {
      Sys.setenv("http_proxy"=proxy$http)
      Sys.setenv("https_proxy"=proxy$https)
      Sys.setenv("ftp_proxy"=proxy$ftp)
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else if (is.vector(proxy)) {
    if( length(proxy) == 3 ) {
      Sys.setenv("http_proxy"=proxy[1])
      Sys.setenv("https_proxy"=proxy[2])
      Sys.setenv("ftp_proxy"=proxy[3])
      return(TRUE)
    } else if (is.character(proxy[1])) {
      Sys.setenv("http_proxy"=proxy[1])
      Sys.setenv("https_proxy"=proxy[1])
      Sys.setenv("ftp_proxy"=proxy[1])
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else if (is.character(proxy)) {
    Sys.setenv("http_proxy"=proxy)
    Sys.setenv("https_proxy"=proxy)
    Sys.setenv("ftp_proxy"=proxy)
    return(TRUE)
  }
  return(FALSE)
}
