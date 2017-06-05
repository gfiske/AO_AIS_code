#spatialJoin_by_day_SeaIce.py

#An ArcGIS script that'll do a Spatial Join between all the individual AIS points by MMSI_Year_JD and the NSIDC sea ice polygons

#gfiske May 2017
#runs on the ancillary data
#spatialJoin_by_day_SeaIce.py
#AIS processing script by gfiske June 2017
#The purpose of this script is to select each set of points by Julian Day and Spatially Join them with the NSIDC sea ice data

import arcpy,os
#from arcpy.sa import *

# Set environment settings
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb"
 
try:
    # Set local variables
    #inTable = "spJoined_merged"
    inTable = "justOneDay"
    # Make a layer from the feature class
    arcpy.MakeFeatureLayer_management(inTable, "lyr")
    # select the field name that has the Julian Day
    fieldName = "yd"
    #make a search cursor
    rows = arcpy.SearchCursor(inTable,fields=fieldName,sort_fields=fieldName)
    # Iterate through the rows in the cursor and print out the yd value
    for row in rows:
        #get just the Julian Day from this record
        yearJD = str(row.getValue(fieldName))
        #select out just one record
        arcpy.SelectLayerByAttribute_management("lyr", "NEW_SELECTION", ' "yd" = ' + yearJD)
        #from that record do a spatial join to the ice data
        outdir = "C:\\Data\\Arctic\\ArcticOptions\\AIS_w_ancillary_data_Apr_2017.gdb\\iceJoined\\"
        arcpy.analysis.SpatialJoin("lyr", "C:\\Users\\gfiske\\Downloads\\2016\\masie_ice_r00_v01_" + yearJD +"_4km.shp", outdir + "ice_" + yearJD, "JOIN_ONE_TO_MANY", "KEEP_COMMON", None, "INTERSECT", None, None)
        print "completed: " + yearJD
except:
    print "failed"