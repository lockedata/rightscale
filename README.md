rightscale
==========

Use rightscale to interface with [rightscale.com](https://rightscale.com) for cloud pricing, management, and optimisation

Installation
------------

Install from github with devtools

``` r
if(!require(devtools)) install.packages(devtools)
devtools::install_github("locakedata/rightscale")
```

Examples
--------

Here some basic examples

``` r
if(!require(rightscale)) devtools::load_all()
```

    ## Loading required package: rightscale

    ## Warning in library(package, lib.loc = lib.loc, character.only = TRUE,
    ## logical.return = TRUE, : there is no package called 'rightscale'

    ## Loading rightscale

``` r
library(rightscale)

authenticate("fa4d643a3b2b95ac59ec0ad6381e86267abbe278")
clouds<-list_clouds()
tibble::glimpse(clouds)
```

    ## Observations: 62
    ## Variables: 7
    ## $ id                <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 1...
    ## $ name              <chr> "EC2 us-east-1", "EC2 eu-west-1", "EC2 us-we...
    ## $ href              <chr> "/api/clouds/1", "/api/clouds/2", "/api/clou...
    ## $ kind              <chr> "ca#cloud", "ca#cloud", "ca#cloud", "ca#clou...
    ## $ cloud_type        <chr> "amazon", "amazon", "amazon", "amazon", "ama...
    ## $ cloud_vendor_name <chr> "Amazon Web Services", "Amazon Web Services"...
    ## $ datacenter_names  <list> [<"us-east-1a", "us-east-1b", "us-east-1c",...

``` r
acloud<-get_cloud(1)
tibble::glimpse(acloud)
```

    ## Observations: 5
    ## Variables: 7
    ## $ id                <int> 1, 1, 1, 1, 1
    ## $ name              <chr> "EC2 us-east-1", "EC2 us-east-1", "EC2 us-ea...
    ## $ href              <chr> "/api/clouds/1", "/api/clouds/1", "/api/clou...
    ## $ kind              <chr> "ca#cloud", "ca#cloud", "ca#cloud", "ca#clou...
    ## $ cloud_type        <chr> "amazon", "amazon", "amazon", "amazon", "ama...
    ## $ cloud_vendor_name <chr> "Amazon Web Services", "Amazon Web Services"...
    ## $ datacenter_names  <list> ["us-east-1a", "us-east-1b", "us-east-1c", ...

``` r
anothercloud<-get_cloud(name="EC2 us-east-1")
tibble::glimpse(anothercloud)
```

    ## Observations: 5
    ## Variables: 7
    ## $ id                <int> 1, 1, 1, 1, 1
    ## $ name              <chr> "EC2 us-east-1", "EC2 us-east-1", "EC2 us-ea...
    ## $ href              <chr> "/api/clouds/1", "/api/clouds/1", "/api/clou...
    ## $ kind              <chr> "ca#cloud", "ca#cloud", "ca#cloud", "ca#clou...
    ## $ cloud_type        <chr> "amazon", "amazon", "amazon", "amazon", "ama...
    ## $ cloud_vendor_name <chr> "Amazon Web Services", "Amazon Web Services"...
    ## $ datacenter_names  <chr> "us-east-1a", "us-east-1b", "us-east-1c", "u...

``` r
prices<-list_prices()
tibble::glimpse(prices)
```

    ## Observations: 500
    ## Variables: 10
    ## $ id                 <int> 547725001, 547726001, 547727001, 547728001,...
    ## $ href               <chr> "/api/prices/547725001", "/api/prices/54772...
    ## $ kind               <chr> "ca#price", "ca#price", "ca#price", "ca#pri...
    ## $ updated_at         <chr> "2016-04-21T12:28:31+00:00", "2016-04-21T12...
    ## $ priceable_resource <data.frame> c("c1.medium", "c1.medium", "c1.medi...
    ## $ purchase_option    <data.frame> c("Reserved Instance Offering 1::c1....
    ## $ fixed_charges      <list> [<c("Reserved Instance Upfront Fee", "Rese...
    ## $ usage_charges      <list> [<Usage, The hourly fee for using this Res...
    ## $ adjustments        <list> [[], [], [], [], [], [], [], [], [], [], [...
    ## $ start_at           <chr> "1970-01-01T00:00:00+00:00", "1970-01-01T00...

``` r
aprice<-get_price(547725001)
tibble::glimpse(aprice)
```

    ## List of 10
    ##  $ id                : int 547725001
    ##  $ href              : chr "/api/prices/547725001"
    ##  $ kind              : chr "ca#price"
    ##  $ updated_at        : chr "2016-04-21T12:28:31+00:00"
    ##  $ priceable_resource:List of 7
    ##   ..$ name                    : chr "c1.medium"
    ##   ..$ type                    : chr "instance"
    ##   ..$ public_cloud_vendor_name: chr "Amazon Web Services"
    ##   ..$ cpu_count               : int 2
    ##   ..$ memory                  : num 1.7
    ##   ..$ local_disk_size         : num 350
    ##   ..$ deprecated              : logi FALSE
    ##  $ purchase_option   :List of 9
    ##   ..$ name            : chr "Reserved Instance Offering 1::c1.medium::Red Hat Enterprise Linux::Partial Upfront::default::2 year"
    ##   ..$ type            : chr "reserved_instance_offering"
    ##   ..$ cloud_href      : chr "/api/clouds/1"
    ##   ..$ platform        : chr "Linux/UNIX"
    ##   ..$ platform_version: chr "Red Hat Enterprise Linux"
    ##   ..$ duration        : int 94608000
    ##   ..$ offering_type   : chr "Partial Upfront"
    ##   ..$ instance_tenancy: chr "default"
    ##   ..$ default_price   : logi FALSE
    ##  $ fixed_charges     :'data.frame':  2 obs. of  5 variables:
    ##   ..$ name       : chr [1:2] "Reserved Instance Upfront Fee" "Reserved Instance Recurring Fee"
    ##   ..$ description: chr [1:2] "The upfront fee paid to be able to use this Reserved Instance" NA
    ##   ..$ frequency  : chr [1:2] "once" "hour"
    ##   ..$ price      : chr [1:2] "631.0" "0.088"
    ##   ..$ currency   : chr [1:2] "USD" "USD"
    ##  $ usage_charges     :'data.frame':  1 obs. of  8 variables:
    ##   ..$ name         : chr "Usage"
    ##   ..$ description  : chr "The hourly fee for using this Reserved Instance"
    ##   ..$ type         : chr "usage"
    ##   ..$ usage_unit   : chr "hour"
    ##   ..$ usage_minimum: chr "1.0"
    ##   ..$ price        : chr "0.0"
    ##   ..$ price_unit   : chr "hour"
    ##   ..$ currency     : chr "USD"
    ##  $ adjustments       : list()
    ##  $ start_at          : chr "1970-01-01T00:00:00+00:00"

Tests
-----

``` r
devtools::test()
```

    ## Loading rightscale

    ## Loading required package: testthat

    ## Testing rightscale

    ## authenticate: .
    ## 
    ## DONE ======================================================================
