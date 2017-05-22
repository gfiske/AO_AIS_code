import glob, csv, sys
filenames = glob.glob("C:/Data/Crap/test/*.csv")
with open('C:/Data/Crap/test/output/output.csv', 'a') as oneFile:
          for i in filenames:
                    with open(i, 'r') as f:
                              for row in f:
                                        oneFile.write(row)
    