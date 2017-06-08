#calculateJD.py
#Purpose: Calculates the Year and Julian day field for each record in the Spatially Joined AIS point data
#Adding the JD field allows a SpaceTime join with the NSIDC data
#June 8, 2017
#gfiske

# Import system modules
import arcpy

# Set environment settings
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb"

#choose a year
year = str(2015)
inTable = "spJoined" + year
 
try:
    #Add new field and calculate it to yearJD
    fieldName = "yd"
    expression = "ydCalc(!time!)"
    codeblock = """def ydCalc(mydate):
        from datetime import datetime 
        date_obj = datetime.strptime(mydate, "%m/%d/%Y")
        #print date_obj
        return '%d%03d' % (date_obj.timetuple().tm_year,date_obj.timetuple().tm_yday)"""
     
    # Execute AddField
    arcpy.AddField_management(inTable, fieldName, "LONG")
     
    # Execute CalculateField 
    arcpy.CalculateField_management(inTable, fieldName, expression, "PYTHON_9.3", 
                                    codeblock)


except Exception:
    e = sys.exc_info()[1]
    print(e.args[0])