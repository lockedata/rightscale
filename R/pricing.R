list_clouds<-function(){
  URL<-"https://pricing.rightscale.com/api/clouds"
  jsonlite::fromJSON(
  httr::content(
    httr::GET(URL, pricing_headers,rightscale_token()),
    encoding = "UTF-8",
    as="text"
  )
  )
}

get_cloud<-function(id=NULL, name=NULL){
  if(!is.null(id)) {
    URL<-glue::glue("https://pricing.rightscale.com/api/clouds/{id}")
    result<-tibble::as_data_frame(
      httr::content(
        httr::GET(URL, pricing_headers,rightscale_token()),
        encoding = "UTF-8"
      )
    )
    result<-jsonlite::flatten(result)
  }

  if(is.null(id)&!is.null(name)){
    clouds<-list_clouds()
    result<-clouds[clouds$name==name, ]
    result<-tidyr::unnest(result)
  }

  return(result)
}

list_prices<-function(){
  URL<-"https://pricing.rightscale.com/api/prices"
  jsonlite::fromJSON(
    httr::content(
      httr::GET(URL, pricing_headers,rightscale_token()),
      encoding = "UTF-8",
      as="text"
    )
  )
}

get_price<-function(id=NULL){
    URL<-glue::glue("https://pricing.rightscale.com/api/prices/{id}")
    result<-jsonlite::fromJSON(
      httr::content(
        httr::GET(URL, pricing_headers,rightscale_token()),
        encoding = "UTF-8",
        as="text"
      )
    )

}

pricing_headers<-httr::add_headers(`X-API-Version`="1.0")

a_cloud<-c("id", "name", "href", "kind","cloud_type","cloud_vendor_name","datacenter_names")
a_price<-c("id",
           "href",
           "kind",
           "updated_at",
           "priceable_resource",
           "purchase_option",
           "fixed_charges",
           "usage_charges",
           "adjustments",
           "start_at",
           "end_at",
           "deleted_at")
