#This program will make EV files from the logfile collected during emotional gonogo Task in fmri

#Sarah Hennessy, 2018


import os
import sys
import csv
import pandas as pd
import numpy as np

#reload(sys)



datafolder = "/Volumes/MusicProject/AllMatlabScripts/fMRI/Emo_Go_NoGo/data"
subjectlist = [elem for elem in os.listdir(datafolder) if "run" in elem]


print ('your subject list is:',subjectlist)

#note: how does it know who the subject is?
# and how does it know what run it is on


for subject in subjectlist: #subject = indiv file
    subj = subject[:-20]
    run = subject[-5]
    
    
    log = datafolder + '/%s_emo_gonogo_run%s.txt' %(subj,run)
    evpath = "/Volumes/MusicProject/AllMatlabScripts/fMRI/Emo_Go_NoGo/EV"
    
    evfolder = evpath + '/%s_%s_evs' %(subj, run) 
    if os.path.exists(evfolder):
        print('Subject %s already has ev folder' %subj)
        continue
    else:
        os.makedirs(evfolder)
       

    #read in the text file

    data = pd.read_csv(log, delim_whitespace = True, comment = "#", header = "infer", skip_blank_lines = True, engine = "python")

   
    print('you are on run:',run)
    print('you are on subject:',subj)

    maxlen = data.shape[0]

    for index, row in data.iterrows():
   
        #RED
            if row.color == 'red':
                 devfilename = evfolder + '/red_run%s.txt' %(run)
                 devfile = open(devfilename, 'a')
                 devfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                 devfile.close()


            elif row.color == 'green':
                   
                 hevfilename = evfolder + '/green_run%s.txt' %(run)
                 hevfile = open(hevfilename, 'a')
                 hevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                 hevfile.close()
                    
            elif row.color == 'purple':
                
                 mevfilename = evfolder + '/purple_run%s.txt' %(run)
                 mevfile = open(mevfilename, 'a')
                 mevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                 mevfile.close()


                   




                


          

       


            

                

                            

                             
    
        
    
    
                       
    
