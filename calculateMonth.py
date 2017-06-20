#calculateMonth.py
#Purpose: Calculates the Month from the date field for each record in the Spatially Joined AIS point data with Sea Ice
#June 20, 2017
#gfiske

# Import system modules
import arcpy

# Set environment settings
arcpy.env.workspace = "C:/Data/Arctic/ArcticOptions/AIS_w_ancillary_data_Apr_2017.gdb"

#choose a year
inTable = "spJoined_merged_w_Ice"
 
try:
    #Add new field and calculate it to yearJD
    fieldName = "ym"
    expression = "ymCalc(!time!)"
    codeblock = """def ymCalc(mydate):
        from datetime import datetime 
        date_obj = datetime.strptime(mydate, "%m/%d/%Y")
        #print date_obj
        return '%d%02d' % (date_obj.timetuple().tm_year,date_obj.timetuple().tm_mon)"""
     
    # Execute AddField
    arcpy.AddField_management(inTable, fieldName, "LONG")
     
    # Execute CalculateField 
    arcpy.CalculateField_management(inTable, fieldName, expression, "PYTHON_9.3", 
                                    codeblock)


except Exception:
    e = sys.exc_info()[1]
    print(e.args[0])