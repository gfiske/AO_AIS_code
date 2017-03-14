#make_point_files.py

#An ArcGIS script that'll convert all csv files to feature layers in a FGDB
#gfiske Feb 2017

import arcpy,os

# Set the current workspace
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/temp_csv"
outdir = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/pointData/"


# Copy each file with a .csv extension to a dBASE file
for csv_file in arcpy.ListFiles("*.csv"):
    # Use splitext to set the output table name
    out_file = os.path.splitext(csv_file)[0] 
    out_file = out_file.replace(".", "_")
    out_file = out_file.replace("-", "_")
    #print out_file
    # Set the local variables
    x_coords = "x"
    y_coords = "y"
    # Make the XY event layer...
    arcpy.MakeXYEventLayer_management(csv_file, x_coords, y_coords, out_file, "", "")    
    # Write layer to feature class
    arcpy.FeatureClassToFeatureClass_conversion(out_file, outdir, out_file)