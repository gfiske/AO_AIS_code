#spatialJoin_by_day_SeaIce.py

#gfiske June 2017
#runs on the ancillary data
#spatialJoin_by_day_SeaIce.py
#AIS processing script by gfiske June 2017
#The purpose of this script is to select each set of points by Julian Day and Spatially Join them with the NSIDC sea ice data
#NSIDC data source: ftp://sidads.colorado.edu/DATASETS/NOAA/G02186/shapefiles/4km/

import arcpy,os
#from arcpy.sa import *

# Set environment settings
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb"
arcpy.env.overwriteOutput = True

#choose a year
year = str(2016)
inTable = "spJoined" + year

#make a JD range
jd = range(1,365)

#loop through jd range and identify which points for each day have sea ice interaction
for i in jd:
    i = (format(i, '03'))
    yearJD = year + i
    
    try:
        # Make a layer from the feature class
        arcpy.MakeFeatureLayer_management(inTable, "lyr")        
        #select out all the points for one jd
        arcpy.SelectLayerByAttribute_management("lyr", "NEW_SELECTION", ' "yd" = ' + yearJD)
        #from that subset do a spatial join to the ice data
        outdir = "C:\\Data\\Arctic\\ArcticOptions\\AIS_w_ancillary_data_Apr_2017.gdb\\iceJoined" + year + "\\"
        arcpy.analysis.SpatialJoin("lyr", "C:\\Users\\gfiske\\Downloads\\2016\\masie_ice_r00_v01_" + yearJD +"_4km.shp", outdir + "ice_" + yearJD, "JOIN_ONE_TO_MANY", "KEEP_COMMON", None, "INTERSECT", None, None)
        #the output joined feature class will have the attributes of the NSIDC sea ice data shapefile
    except:
        print "this jd failed: " + i
        #some jd have no NSIDC data
        #other errors are yet to be determined


    

