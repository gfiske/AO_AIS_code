# findBadRecords.py
# searches for bad records in the spatially joined AIS data
# gfiske May 2017

import arcpy
import os

arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb/spatialJoined"

for i in arcpy.ListFeatureClasses("p2012*"):
    rows = arcpy.SearchCursor(i,fields="nav")
    # Iterate through the rows in the cursor and print out the nav value as an indicator of bad data
    for row in rows:
        if not row.getValue("nav"):
            print "in this FC: " + i + " delete this ID: " + str(row.getValue("OBJECTID"))