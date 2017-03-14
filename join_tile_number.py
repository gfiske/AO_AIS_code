#join_tile_number.py
#This script joins the 4k tile number to each AIS point

import arcpy
import os

arcpy.env.overwriteOutput = True

arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/pointData"
#arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/test"
outdir = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/joinedPointData/"
outdirDissolved = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/dissolved_by_tile_mmsi/"
outdirFreq = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/"

featureclasses = arcpy.ListFeatureClasses()

# Copy shapefiles to a file geodatabase
for fc in featureclasses:
    #test print
    print fc
    #join the tile number to each point
    result = arcpy.analysis.SpatialJoin(fc, "C:\\Data\\Arctic\\ArcticOptions\\AO_AIS_Feb2017.gdb\\fishnet_4k_above_60N", outdir + fc + '_joined', "JOIN_ONE_TO_MANY", "KEEP_COMMON", None, "INTERSECT", None, None)
    #dissolve the points by tile number and mmsi number
    result2 = arcpy.management.Dissolve(result, outdirDissolved + fc + '_diss', "code_id;mmsi", "Join_Count SUM", "MULTI_PART", None)
    #one potential use of this dissolved product could be a map of total unique ship points for the time series by tile
    #to make, we'd need to use the frequency tool to count the number of unique mmsi numbers per tile
    #afterwards, these can be merged together and then summarized by tile through the time series
    arcpy.Frequency_analysis(result2, outdirFreq + fc + '_freq', ["code_id"], ["mmsi"])
    #i.e. for each tile there are XX number of unique mmsi numbers (as written in the FREQUENCY column of the output table)
    #these values will need to be summed per tile
       