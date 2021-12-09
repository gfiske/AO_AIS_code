#noGeoCluster_googleComputeEngineR.R
#a test script
#starts a cluster of Google VMs and uses each node to count AIS data without geolocation info
#gfiske Apr 2017

rm(list = ls())

#load librarys
library(future)
library(googleComputeEngineR)
library(googleCloudStorageR)

#set environment
Sys.setenv("GCE_AUTH_FILE" = "C:/Data/Crap/compute-1-41465c05b2a2.json")
gce_global_project("compute-1-1084")
gce_global_zone("us-east1-b")
options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/cloud-platform")

#authorize
gce_auth()

#setup ssh on all three instances - only needs to be run once
key.pub <- "C://Users/gfiske/.ssh/github_rsa.pub"
key.private <- "C://Users/gfiske/.ssh/github_rsa"
vm1 <- gce_vm("vm1")
vm1 <- gce_ssh_setup(vm, username="gfiske", key.pub = key.pub, key.private = key.private)
vm2 <- gce_vm("vm2")
vm2 <- gce_ssh_setup(vm2, username="gfiske", key.pub = key.pub, key.private = key.private)
vm3 <- gce_vm("vm3")
vm3 <- gce_ssh_setup(vm3, username="gfiske", key.pub = key.pub, key.private = key.private)

#test a small instance
vmTest <- gce_vm("micro-compute-1")
vmTest <- gce_ssh_setup(vmTest, username="gfiske", key.pub = key.pub, key.private = key.private)
plan(cluster, workers = as.cluster(vmTest))

# make bigger cluster
plan(cluster, workers = as.cluster(vm1, vm2, vm3))

# make a big function to run asynchronously
f <- function() {
  mycount = 0
  # read the data from a storage bucket
  psvfiles <- list.files("/mnt/gce/arctic-ais-data/decoded/", "*.psv$", full.names = T)
  for (i in psvfiles){
    mydata = read.csv(i, header=T, sep="|")
    #subset only the pertinent fields
    myvars <- c("mmsi", "rot", "satellite_timestamp", "true_heading", "x", "y")
    newdata <- subset(mydata[myvars])
    newdata <- subset(newdata, newdata$x == 181.000000)
    mycount <- nrow(newdata) + mycount
  }
  return(mycount)
}

# send computation to cluster
result %<-% f()

# check if finished
res <- resolved(result)
# print if true
if(res = TRUE) {
  print(res)
}

# shutdown instances when finished, they cost big bucks!
vms <- c(vm1, vm2, vm3)
lapply(vms, gce_vm_stop)
