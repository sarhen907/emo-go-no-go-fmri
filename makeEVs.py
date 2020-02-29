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
            	
            	# GO
            	if row.condition == 'go':
                	wevfilename = evfolder + '/red_go_run%s.txt' %(run)
                	wevfile = open(wevfilename, 'a')
                	wevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                	wevfile.close()

            	elif row.condition == 'nogo':

                # No Go
                	revfilename = evfolder + '/red_nogo_run%s.txt' %(run)
                	revfile = open(revfilename, 'a')
                	revfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                	revfile.close()

            elif row.color == 'green':
            	# GO
            	if row.condition == 'go':
                	wevfilename = evfolder + '/green_go_run%s.txt' %(run)
                	wevfile = open(wevfilename, 'a')
                	wevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                	wevfile.close()

            	elif row.condition == 'nogo':

                # No Go
                	revfilename = evfolder + '/green_nogo_run%s.txt' %(run)
                	revfile = open(revfilename, 'a')
                	revfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                	revfile.close()

            elif row.color == 'purple':
            	# GO
            	if row.condition == 'go':
                	wevfilename = evfolder + '/purple_go_run%s.txt' %(run)
                	wevfile = open(wevfilename, 'a')
                	wevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                	wevfile.close()

            	elif row.condition == 'nogo':

                # No Go
                	revfilename = evfolder + '/purple_nogo_run%s.txt' %(run)
                	revfile = open(revfilename, 'a')
                	revfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                	revfile.close()



                


          

       


            

                

                            

                             
    
        
    
    
                       
    
