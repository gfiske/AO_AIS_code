#calculateJD.py
#Caclulates the Year and Julian day field for each record in the Spatially Joined AIS point data

#May 22, 2017


# Import system modules
import arcpy
 
# Set environment settings
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb"
 
try:
    # Set local variables
    inTable = "spJoined_merged"
    fieldName = "yd"
    expression = "ydCalc(!time!)"
    codeblock = """def ydCalc(mydate):
        from datetime import datetime 
        date_obj = datetime.strptime(mydate, "%m/%d/%Y")
        #print date_obj
        return '%d%03d' % (date_obj.timetuple().tm_year,date_obj.timetuple().tm_yday)"""
     
    # Execute AddField
    #arcpy.AddField_management(inTable, fieldName, "LONG")
     
    # Execute CalculateField 
    arcpy.CalculateField_management(inTable, fieldName, expression, "PYTHON_9.3", 
                                    codeblock)


except Exception:
    e = sys.exc_info()[1]
    print(e.args[0])