#join_tile_number.py
#The purpose of this script is to join the 4k tile number to each AIS point in the time series

import arcpy
import os

arcpy.env.overwriteOutput = True
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/pointData"

# set work environment
outdir = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/joinedPointData/"
outdirDissolved = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/dissolved_by_tile_mmsi/"
outdirFreq = "C:/Data/Arctic/ArcticOptions/AO_AIS_Feb2017.gdb/"

# list all feature classes that contain the AIS points
featureclasses = arcpy.ListFeatureClasses()

# iterate and conduct work
for fc in featureclasses:
    #spatial join the tile number to each point
    result = arcpy.analysis.SpatialJoin(fc, "C:\\Data\\Arctic\\ArcticOptions\\AO_AIS_Feb2017.gdb\\fishnet_4k_above_60N", outdir + fc + '_joined', "JOIN_ONE_TO_MANY", "KEEP_COMMON", None, "INTERSECT", None, None)
    #dissolve the points by tile number and mmsi number
    result2 = arcpy.management.Dissolve(result, outdirDissolved + fc + '_diss', "code_id;mmsi", "Join_Count SUM", "MULTI_PART", None)
    #use the frequency tool to count the number of unique mmsi numbers per tile, ultimately replaced by BigQuery processing for speed/time
    arcpy.Frequency_analysis(result2, outdirFreq + fc + '_freq', ["code_id"], ["mmsi"])
    #sum per tile
    #Optionally, replaced by Delete Identical tool  