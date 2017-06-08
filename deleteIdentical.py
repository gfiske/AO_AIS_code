#deleteIdentical.py

#The purpose of this script is to delete the identical AIS points per cell
#It uses the spaceTime resultion of 4km and one day
#run initially on the ancillary data
#May 2017

import arcpy,os
#from arcpy.sa import *
arcpy.env.overwriteOutput = True

# Set the current workspace
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017_rawPoints.gdb/pointData"
outdir = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb/spatialJoined/"

#  List raw files and run functions against this set
for i in arcpy.ListFeatureClasses("*"):
    # Use splitext to set the output table name
    out_file = outdir + i 
    # Make the XY event layer...    
    try:
        print out_file
        arcpy.analysis.SpatialJoin(i, "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/fishnet_4k_above_60N", out_file, "JOIN_ONE_TO_ONE", "KEEP_ALL", None, "INTERSECT", None, None)
        dropFields = ["Join_Count", "TARGET_FID"]
        arcpy.DeleteField_management(out_file, dropFields)
        # Set the field upon which the identicals are found
        fields = ["code_id", "mmsi"]  
        # Execute Delete Identical 
        arcpy.DeleteIdentical_management(out_file, fields)        
    except:
        print "this file failed: " + i