# environment to store credentials
.state <- new.env(parent = emptyenv())

authenticate<-function(secret, endpoint="us-3"){
  URL<-glue::glue("https://{endpoint}.rightscale.com/api/oauth2")
  response<-httr::POST(URL,
      httr::add_headers(
        `X-API-Version`="1.5"
      ),
      body=list(
        grant_type="refresh_token",
        refresh_token=secret
      )
  )
  content<-httr::content(response)
  .state$token <-  content$access_token
  invisible(.state$token)
}

rightscale_token<-function(){
  if (is.null(.state$token)) stop("Run rightscale::authenticate()")
  httr::add_headers(Authorization = glue::glue("Bearer {.state$token}"))
}
