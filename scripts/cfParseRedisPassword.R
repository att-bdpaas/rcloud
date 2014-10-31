require ('rjson')

vcap_services = fromJSON(Sys.getenv('VCAP_SERVICES'))

cat(vcap_services$`p-redis`[[1]]$credentials$password)