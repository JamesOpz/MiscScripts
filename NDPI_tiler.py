# JO 11/02/2017
# File to split big ndpi files into tiled tiff images
# Files must be small enough to fit into java memory for histology quantification

import os
import shutil
import sys
from os.path import basename

# Input filepath to folder to look through find files to split
for arg in sys.argv:
    filePath = arg

# Collect files in path and check if they are .ndpi files
count = 0


for File in os.listdir(filePath):
    if File.endswith(".ndpi"):
        count += 1

        # Create a new folder for each file and move the NDPI file there so that it can output its tiled images there
        base = basename(File)
        fileName = os.path.splitext(base)[0]
        newPath = os.path.join(filePath, fileName)

        if not os.path.exists(newPath):
            os.makedirs(newPath)
            shutil.move(File, newPath)

        # Needs to run NDPI split tile from the command line on the ndpi file in the folder
            for NDPI_File in os.listdir(newPath):
                if File.endswith(".ndpi"):

                    # Run NDPI split command from the commandline
                    # -m max memory of file
                    # -o is the pixel overlap of the mosaic images
                    absPath = os.path.join(newPath, NDPI_File)
                    os.system('ndpisplit -m500 '+absPath)


print(count, " NDPI files processed")
