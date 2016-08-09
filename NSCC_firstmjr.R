source("S:/Institutional Research/Chen/R setup/ODBC Connection.R")
library(sqldf)
PAGmajrH <- sqlQuery(MSUEDW, "select distinct cohort,Pid,
                    MAJOR_US1, 
                     MAJOR_FS1, 
                     MAJOR_SS1, 
                     MAJOR_US2, 
                     MAJOR_FS2,
                     MAJOR_SS2,
                     MAJOR_US3, 
                     MAJOR_FS3, 
                     MAJOR_SS3, 
                     MAJOR_US4,
                     MAJOR_FS4,
                     MAJOR_SS4, 
                     MAJOR_US5, 
                     MAJOR_FS5,
                     MAJOR_SS5,
                     MAJOR_US6, 
                     MAJOR_FS6, 
                     MAJOR_SS6, 
                     MAJOR_US7, 
                     MAJOR_FS7, 
                     MAJOR_SS7, 
                     MAJOR_US8, 
                     MAJOR_FS8, 
                     MAJOR_SS8,
                     MAJOR_US9, 
                     MAJOR_FS9, 
                     MAJOR_SS9, 
                     MAJOR_US10, 
                     MAJOR_FS10, 
                     MAJOR_SS10,
                     MAJOR_DEGREE,
                     MAJOR_NAME_FIRST
                    from OPB_PERS_FALL.PERSISTENCE_V 
                     where STUDENT_LEVEL='UN' and LEVEL_ENTRY_STATUS='FRST' and COHORT in (2009,2008,2007,2006,2005)
                     and MAJOR_NAME_FIRST='No Preference'
                   ")

library(reshape)
PAGmajrV <- melt(PAGmajrH, id=c('COHORT','PID','MAJOR_DEGREE','MAJOR_NAME_FIRST'))
PAGmajrV1 <- PAGmajrV[! is.na( PAGmajrV$value),]
PAGmajrV1$pick <- ifelse(PAGmajrV1$value=='5151',0,1)

library(plyr)
majr_1st<-ddply(.data=PAGmajrV1, .var=c("COHORT","PID","pick"), .fun=function(x)x[1,])

library(dplyr)
mjr <- majr_1st %>% group_by(COHORT, PID) %>% summarise(p=sum(pick))

