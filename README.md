# MOVICode
Code used for the Paper on the MOVI Method

The code is separated in 3 folders and has 1 master script which is Core_PAC_Sim.m 
In function of the settings specified in the master script the functions automatically will assign values to the variables. 
The script saves the results of MOVI and JSD into a folder for later use and prevent recomputing every time. 

Paths to the folders and the functions have to be changed in the main script and be adjusted to the computer you want to run the functions on. 

In the folder Simulation are all the functions and scripts relative to simulating the datasets used to perform the comparison between MOVI and JSD
In the folder Preprocessing and Analysis are the functions used to perform the processing of the signal (such as filtering) and the functions associated to analyses (Binomial Test for example) 
In the folder Figures are the scripts used to compute figures shown in the paper. 

Given the random noise generation in the simulation it is possible that the exact reproduction of these figures will not be possible, but that there will be a great overlap between newly generated figures and the ones shown in the paper. 

Specific Statistics about the figures (t-test, PPV, NPV, MCC) are calculated in the scripts of the figures directly., 

For any additional information contact: ludovico.s-adichanaz@hotmail.it
