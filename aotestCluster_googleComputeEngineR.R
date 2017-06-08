#testCluster_googleComputeEngineR.R
#a test script 
#experiments with an R cluster on the GCP infrastructure to mass process tabular AIS data
#ultimately replaced with Google BigQuery
#gfiske Apr 2017

rm(list = ls())

#load librarys
library(future)
library(googleComputeEngineR)
require(microbenchmark)

#set environment
Sys.setenv("GCE_AUTH_FILE" = "C:/Data/Crap/compute-1-41465c05b2a2.json")
gce_global_project("compute-1-1084")
gce_global_zone("us-east1-b")
options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/cloud-platform")

#Google Authorize
gce_auth()

#start the cluster that was created previously
vm_names <- c("vm1","vm2","vm3")
lapply(vm_names, gce_vm_start)

#setup ssh keys on all three instances - only needs to be run once
key.pub <- "C://Users/gfiske/.ssh/github_rsa.pub"
key.private <- "C://Users/gfiske/.ssh/github_rsa"
vm1 <- gce_vm("vm1")
vm1 <- gce_ssh_setup(vm1, username="gfiske", key.pub = key.pub, key.private = key.private)
vm2 <- gce_vm("vm2")
vm2 <- gce_ssh_setup(vm2, username="gfiske", key.pub = key.pub, key.private = key.private)
vm3 <- gce_vm("vm3")
vm3 <- gce_ssh_setup(vm3, username="gfiske", key.pub = key.pub, key.private = key.private)

## make the cluster
plan(cluster, workers = as.cluster(vm1, vm2, vm3))

## a big function that'll run asynchronously
f <- function(trials) {
  count = 0
  for(i in 1:trials) {
    if((runif(1,0,1)^2 + runif(1,0,1)^2)<1) {
      count = count + 1
    }
  }
  return((count*4)/trials)
}

# send to cluster
timeIncre <- microbenchmark(result %<-% f(10000000), times = 2L)

# shutdown instances when finished
lapply(vm_names, gce_vm_stop)
