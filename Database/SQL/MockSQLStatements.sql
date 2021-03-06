SEARCH FOR ALL MERITS
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, award.awardName, award.description, timestamp, teacher.surname, teacher.forename
FROM pupil, instance, award, teacher
WHERE instance.candidateNumber = pupil.candidateNumber AND instance.awardID = award.awardID AND instance.teacherID = teacher.teacherID AND meritOrDemerit = "merit";

SEARCH FOR ALL DEMERITS
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, award.awardName, award.description, timestamp, teacher.surname, teacher.forename
FROM pupil, instance, award, teacher
WHERE instance.candidateNumber = pupil.candidateNumber AND instance.awardID = award.awardID AND instance.teacherID = teacher.teacherID AND meritOrDemerit = "demerit";

SEARCH FOR SPECIFIC INSTANCE
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, instance.meritOrDemerit award.awardName, award.description, timestamp, teacher.surname, teacher.forename
FROM pupil, instance, award, teacher
WHERE instance.candidateNumber = pupil.candidateNumber AND instance.awardID = award.awardID AND instance.teacherID = teacher.teacherID  AND instance.instanceID = searchTerm;

SEARCH FOR LIST OF A PUPIL’S MERITS (by SCN)
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, totalMerits, instanceID, instance.timestamp, award.awardName, award.description, teacher.forename, teacher.surname, teacher.subject
FROM pupil, instance, award, teacher
WHERE instance.candidateNumber = pupil.candidateNumber AND instance.awardID = award.awardID AND instance.teacherID = teacher.teacherID;

SEARCH FOR LIST OF A PUPIL’S DEMERITS (by SCN)
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, totalDemerits, instanceID, instance.timestamp, award.awardName, award.description, teacher.forename, teacher.surname, teacher.subject
FROM pupil, instance, award, teacher
WHERE instance.candidateNumber = pupil.candidateNumber AND instance.awardID = award.awardID AND instance.teacherID = teacher.teacherID;

SEARCH FOR LIST OF A PUPIL’S MERITS (by name)
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, totalMerits, instanceID, instance.timestamp, award.awardName, award.description, teacher.forename, teacher.surname, teacher.subject
FROM pupil, instance, award, teacher
WHERE instance.forename = pupil.forename AND instance.surname = pupil.surname AND instance.awardID = pupil.awardID AND meritOrDemerit = "merit";

SEARCH FOR LIST OF A PUPIL’S DEMERITS (by name)
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, totalDemerits, instanceID, instance.timestamp, award.awardName, award.description, teacher.forename, teacher.surname, teacher.subject
FROM pupil, instance, award, teacher
WHERE instance.forename = pupil.forename AND instance.surname = pupil.surname AND instance.awardID = pupil.awardID AND meritOrDemerit = "demerit";

SEARCH FOR LIST OF A PUPIL’S INSTANCES (by SCN)
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, totalMerits, totalDemerits, instanceID, instance.timestamp, instance.meritOrDemerit award.awardName, award.description teacher.forename, teacher.surname, teacher.subject
FROM pupil, instance, award, teacher
WHERE instance.candidateNumber = pupil.candidateNumber AND instance.teacherID = teacher.teacherID AND instance.awardID = award.awardID;

SEARCH FOR LIST OF A PUPIL’S INSTANCES (by Name)
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, PSRclass, totalMerits, instanceID, instance.timestamp, instance.meritOrDemerit award.awardName, award.description, teacher.forename, teacher.surname, teacher.subject
FROM pupil, instance, award, teacher
WHERE instance.forename = pupil.forename AND instance.surname = pupil.surname AND instance.teacherID = teacher.teacherID AND instance.awardID = award.awardID;

UPDATE TOTAL MERIT FIELD
UPDATE pupil, instance
SET totalMerits = (SELECT COUNT(instanceID) FROM pupil, instance, award WHERE instance.candidateNumber = pupil.candidateNumber AND instance.teacherID = teacher.teacherID AND instance.awardID = award.awardID AND meritOrDemerit = "merit") AS SUBQUERY
WHERE pupil.candidateNumber = instance.candidateNumber AND instance.teacherID = teacher.teacherID AND instance.awardID = award.awardID;

UPDATE TOTAL DEMERIT FIELD
UPDATE pupil, instance
SET totalMerits = (SELECT COUNT(instanceID) FROM pupil, instance, award WHERE instance.candidateNumber = pupil.candidateNumber AND instance.teacherID = teacher.teacherID AND instance.awardID = award.awardID AND meritOrDemerit = "demerit") AS SUBQUERY
WHERE pupil.candidateNumber = instance.candidateNumber AND instance.teacherID = teacher.teacherID AND instance.awardID = award.awardID;

CALCULATE TOTAL MERITS FOR EACH YEAR GROUP
SELECT year, COUNT(instance.instanceID)
FROM pupil, instance
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "merit" AND year = searchTerm;

CALCULATE TOTAL DEMERITS FOR EACH YEAR GROUP
SELECT year, COUNT(instance.instanceID)
FROM pupil, instance
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "demerit" AND year = searchTerm;

CALCULATE TOTAL MERITS FOR EACH CLASS
SELECT instance.classID, COUNT(instance.instanceID)
FROM pupil, instance, class
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "merit" AND instance.classID = class.classID AND class.classID = searchTerm;

CALCULATE TOTAL DEMERITS FOR EACH CLASS
SELECT instance.classID, COUNT(instance.instanceID)
FROM pupil, instance, class
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "demerit" AND instance.classID = class.classID AND class.classID = searchTerm;

CALCULATE WHICH PUPILS HAVE MERITS IN SPECIFIC YEAR GROUP
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, totalMerits
FROM pupil, instance
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "merit" AND year = searchTerm;

CALCULATE WHICH PUPILS HAVE DEMERITS IN SPECIFIC YEAR GROUP
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, year, totalDemerits
FROM pupil, instance
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "demerit" AND year = searchTerm;

CALCULATE WHICH PUPILS HAVE MERITS IN SPECIFIC CLASS
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, instance.classID, totalMerits
FROM pupil, instance, class
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "merit" AND instance.classID = class.classID AND class.classID = searchTerm;

CALCULATE WHICH PUPILS HAVE DEMERITS IN SPECIFIC CLASS
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, instance.classID, totalDemerits
FROM pupil, instance, class
WHERE pupil.candidateNumber = instance.candidateNumber AND meritOrDemerit = "demerit" AND instance.classID = class.classID AND class.classID = searchTerm;

HOW MANY PEOPLE HAVE A SPECIFIC AWARD TYPE
SELECT COUNT(pupil.candidateNumber), pupil.forename, pupil.surname, instance.awardID, award.awardName
FROM pupil, instance, award
WHERE instance.awardID = award.awardID AND award.awardName = searchTerm;

LIST ALL PUPILS IN A SPECIFIC CLASS AND THEIR AWARDS
SELECT pupil.candidateNumber, pupil.forename, pupil.surname, pupil.year, pupil.PSRclass, instance.meritOrDemerit, award.awardName, award.description
FROM pupil, instance, award
WHERE instance.awardID = award.awardID AND PSRclass = searchTerm;

CALCULATE HOW MANY OF A SPECIFIC MERIT HAS BEEN ASSIGNED
SELECT COUNT(instance.instanceID), instance.meritOrDemerit, award.awardID, award.awardName, award.description
FROM instance, award
WHERE instance.awardID = award.awardID AND instance.meritOrDemerit = "merit" AND award.awardID = searchTerm;

CALCULATE HOW MANY OF A SPECIFIC DEMERIT HAS BEEN ASSIGNED
SELECT COUNT(instance.instanceID), instance.meritOrDemerit, award.awardID, award.awardName, award.description
FROM instance, award
WHERE instance.awardID = award.awardID AND instance.meritOrDemerit = "demerit" AND award.awardID = searchTerm;
