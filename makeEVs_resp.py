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
                
                    # CORRECT
                    if row.accuracy == 1:
                         aevfilename = evfolder + '/red_go_cor_run%s.txt' %(run)
                         aevfile = open(aevfilename, 'a')
                         aevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                         aevfile.close()
                    #IN
                    elif row.accuracy == 0:

                         bevfilename = evfolder + '/red_go_in_run%s.txt' %(run)
                         bevfile = open(bevfilename, 'a')
                         bevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                         bevfile.close()

                # No Go

                elif row.condition == 'nogo':

                    if row.accuracy == 1:
                         cevfilename = evfolder + '/red_nogo_cor_run%s.txt' %(run)
                         cevfile = open(cevfilename, 'a')
                         cevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                         cevfile.close()
                    
                    elif row.accuracy == 0:
                         devfilename = evfolder + '/red_nogo_in_run%s.txt' %(run)
                         devfile = open(devfilename, 'a')
                         devfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                         devfile.close()


            elif row.color == 'green':
                # GO
            
                if row.condition == 'go':
                    # CORRECT
                    if row.accuracy == 1:
                        eevfilename = evfolder + '/green_go_cor_run%s.txt' %(run)
                        eevfile = open(eevfilename, 'a')
                        eevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        eevfile.close()
                    #IN
                    elif row.accuracy == 0:
                        fevfilename = evfolder + '/green_go_in_run%s.txt' %(run)
                        fevfile = open(fevfilename, 'a')
                        fevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        fevfile.close()

                # No Go

                elif row.condition == 'nogo':
                    if row.accuracy == 1:
                        gevfilename = evfolder + '/green_nogo_cor_run%s.txt' %(run)
                        gevfile = open(gevfilename, 'a')
                        gevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        gevfile.close()
                    
                    elif row.accuracy == 0:
                        hevfilename = evfolder + '/green_nogo_in_run%s.txt' %(run)
                        hevfile = open(hevfilename, 'a')
                        hevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        hevfile.close()
                    
            elif row.color == 'purple':
                # GO
            
                if row.condition == 'go':
                    # CORRECT
                    if row.accuracy == 1:
                        jevfilename = evfolder + '/purple_go_cor_run%s.txt' %(run)
                        jevfile = open(jevfilename, 'a')
                        jevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        jevfile.close()
                    #IN
                    elif row.accuracy == 0:
                        kevfilename = evfolder + '/purple_go_in_run%s.txt' %(run)
                        kevfile = open(kevfilename, 'a')
                        kevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        kevfile.close()

                # No Go

                elif row.condition == 'nogo':
                    if row.accuracy == 1:
                        levfilename = evfolder + '/purple_nogo_cor_run%s.txt' %(run)
                        levfile = open(levfilename, 'a')
                        levfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        levfile.close()
                    
                    elif row.accuracy == 0:
                        mevfilename = evfolder + '/purple_nogo_in_run%s.txt' %(run)
                        mevfile = open(mevfilename, 'a')
                        mevfile.write('%0.4f\t%0.4f\t1\n' %(row.trialonset, row.triallength))
                        mevfile.close()


                   




                


          

       


            

                

                            

                             
    
        
    
    
                       
    
