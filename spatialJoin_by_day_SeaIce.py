#spatialJoin_by_day_SeaIce.py

#The purpose of this script is to select each set of points by Julian Day and Spatially Join them with the NSIDC sea ice data
#NSIDC data source: ftp://sidads.colorado.edu/DATASETS/NOAA/G02186/shapefiles/4km/
#gfiske June, 2017

import arcpy,os
#from arcpy.sa import *

# Set environment settings
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb"
arcpy.env.overwriteOutput = True

#choose a year set output directory
year = str(2014)
inTable = "spJoined" + year
outdir = "C:\\Data\\Arctic\\ArcticOptions\\AIS_w_ancillary_data_Apr_2017.gdb\\iceJoined" + year + "\\"

#make a JD range
jd = range(1,365)

#loop through jd range and identify which points for each day have sea ice interaction
for i in jd:
    i = (format(i, '03'))
    yearJD = year + i
    #only produce those that don't exist
    if not arcpy.Exists(outdir + "ice_" + yearJD):
        #block into 'try except' due to potential errors
        try:
            # Make a layer from the feature class
            arcpy.MakeFeatureLayer_management(inTable, "lyr")        
            #select out all the points for one jd
            arcpy.SelectLayerByAttribute_management("lyr", "NEW_SELECTION", ' "yd" = ' + yearJD)
            #from that subset do a spatial join to the ice data
            arcpy.analysis.SpatialJoin("lyr", "C:\\Users\\gfiske\\Downloads\\" + year + "\\masie_ice_r00_v01_" + yearJD +"_4km.shp", outdir + "ice_" + yearJD, "JOIN_ONE_TO_MANY", "KEEP_COMMON", None, "INTERSECT", None, None)
            #the output joined feature class will have the attributes of the NSIDC sea ice data shapefile
        except:
            print "this jd failed: " + i
            file = open('C:\\Data\\Arctic\\ArcticOptions\\seaIce_NSIDC_fail_log.txt', 'a')
            file.write("YearJD fail: %s" % yearJD)
            file.write("\n")
            file.close()
            #some jd have no NSIDC data
            #other errors are yet to be determined


    

