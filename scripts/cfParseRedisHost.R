require ('rjson')

vcap_services = fromJSON(Sys.getenv('VCAP_SERVICES'))

cat(sprintf("%s:%s", vcap_services$`p-redis`[[1]]$credentials$host, vcap_services$`p-redis`[[1]]$credentials$port))
