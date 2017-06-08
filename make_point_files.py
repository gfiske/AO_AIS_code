#make_point_files.py

#The purpose of this script is to convert all raw AIS csv files to feature class point files in an Esri FGDB
#gfiske Feb 2017

import arcpy,os
#from arcpy.sa import *
arcpy.env.overwriteOutput = True

# Set the current workspace
arcpy.env.workspace = "C:/Data/rawDir/ancillary_data"
outdir = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb/pointData"

# Set the local variables
x_coords = "long"
y_coords = "lat"


# Convert each .csv file to a feature class
for csv_file in arcpy.ListFiles("2016*p000*.csv"):
    # Use splitext to set the output table name
    out_file = os.path.splitext(csv_file)[0] 
    out_file = "p" + out_file.replace("-", "_")
    # Make the XY event layer...    
    try:
        arcpy.MakeXYEventLayer_management(csv_file, x_coords, y_coords, out_file, "", "")    
        # Write layer to feature class
        arcpy.FeatureClassToFeatureClass_conversion(out_file, outdir, out_file)
    except:
        print "this file failed: " + out_file