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
