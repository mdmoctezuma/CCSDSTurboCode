The file that contains the code for the GUIDE and that must be executed with Matlab to open the graphical user interface (GUI)
is "TCGUI.m". The rest of the files are necessary to run the program. Other files contained in this folder are ".mat", which are
previously simulated results used for comparison, and scripts that run Simulink models.

In the GUI the user can simulate the turbo code specified by the CCSDS (Consultative Committee for Space Data Systems) 
standard 131.0-B-2 for deep space communications. The only element that differs in this program from the standard is the number 
of tail bits on each frame, which is larger than the one  specified in the standard. This is because this parameter can't be 
changed when using the Turbo Coder and Turbo Decoder blocks in Simulink. This results in a slightly better BER (Bit Error Rate)
performance in the waterfall region of the BER vs SNR (Signal to Noise Ratio) graph.

The user can select a frame size (1784, 3568, 7136 and 8920 bits) and a coding rate (1/2, 1/3, 1/4 and 1/6) from the dropboxes. 
The user can also select the number of frames to be simulated.
The custom interleaver and puncturing matrix must be a text file ".txt". If there is and error when opening these files, the
GUI will show the error. An example of the format of the interleaver can be found in the file "ccsdsSize1784.txt" and 
"randomInter1784.txt", which contain the interleaver specified by the CCSDS standard of size 1784 and a random interleaver of size
1784, respectively. An example of the format of the puncturing matrix can be found in the file "punct12", which contain the puncturing 
matrix specified by the CCSDS standard for the coding rate 1/2.
The user must write the full name of the file in the GUI, including the ".txt" extension.
The number and values of SNR (Eb/No) can't be changed. These values are the ones used by the simulations shown on the CCSDS standard. 
At the end of the simulation, the resulting BER curve is shown alongside a previously simulated BER curve that uses the CCSDS standard
parameters, so that the user can see if there is any coding gain. The results are also stored in the 2D array "BER.mat", which contains 
the SNR values in the first row and the respective BER value in the second row.

Please take into consideration that in order to be able to obtain results for lower values of BER, the simulation must be done for 
a large number of frames depending on the case, e.g. more than a million bits simulated. Please be aware that this can be a very 
time-consuming process. 