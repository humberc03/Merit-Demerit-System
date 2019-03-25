class pupil():
    def __init__(self, candidateNumber, forename, surname, year, PSRclass, totalMerits, totalDemerits, sManagementID, pSupportID):
        self.candidateNumber = candidateNumber
        self.forename = forename
        self.surname = surname
        self.year = year
        self.PSRclass = PSRclass
        self.totalMerits = totalMerits
        self.totalDemerits = totalDemerits
        self.sManagementID = sManagementID
        self.pSupportID = pSupportID

def importFileToArrayOfRecords():
    pArray = []
    lastPupil = pupil(0,0,0,0,0,0,0,0,0)
    entireFile = open("pupilDataALT.csv", "r")
    linesArray = entireFile.read().splitlines()
    for count in range(len(linesArray)):
        lineSplit = linesArray[count].split(",")
        currPupil = pupil(lineSplit[14], lineSplit[1], lineSplit[2], lineSplit[4], lineSplit[3], 0, 0, "", "")
        if currPupil.candidateNumber != lastPupil.candidateNumber and currPupil.forename != lastPupil.forename and currPupil.surname != lastPupil.surname:
            pArray.append(currPupil)
        if currPupil.candidateNumber == 0:
            pArray.append(currPupil)
        lastPupil = currPupil
    entireFile.close()
    return pArray

def outputArrayOfRecordsToFile(array):
    entireFile = open("pupilDataTrimmed7.csv", "w+")
    entireFile.write("candidateNumber,forename,surname,year,PSRclass,totalMerits,totalDemerits,sManagementID,pSupportID,\n")
    for count in range(len(array)):
        entireFile.write(str(array[count].candidateNumber) + "," + str(array[count].forename) + "," + str(array[count].surname) + "," + str(array[count].year) + "," + str(array[count].PSRclass) + "," + str(array[count].totalMerits) + "," + str(array[count].totalDemerits) + "," + str(array[count].sManagementID) + "," + str(array[count].pSupportID) + "\n")
    entireFile.close()

outputArrayOfRecordsToFile(importFileToArrayOfRecords())
