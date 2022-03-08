%Specify the folder where the jsonlab toolbox exists.
addpath /Applications/jsonlab-2.0/jsonlab-2.0

% Specify the main folder where the .jsonfiles live.
myFolder = '/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix';
i=0;
% Get a list of all files in the folder with the desired file name pattern.
filelist = dir(fullfile(myFolder, '/sub-*/*.qc/*.qc/*.json')); %/**/** depends on the number of subdirectories you need to go inside to find the file. In this case it was maindirectory/subjects/fmap/*.json, so two times **/** for subjects and fmap.
%Now loop for getting the each one.
for k = 1 : length(filelist)
  baseFileName = filelist(k).name;
  directory_structure = filelist(k).folder;
  fullFileName = fullfile(directory_structure, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name, In this case load the
  % files to json toolbox.

  seq=loadjson(fullFileName);

output_a214{k,1}= fullFileName;
output_a214{k,2}= seq.qc_mot_abs;
output_a214{k,3}= seq.qc_mot_rel;
output_a214{k,4}= seq.qc_outliers_b(1,1);
output_a214{k,5}= seq.qc_outliers_b(1,2);
output_a214{k,6}= seq.qc_outliers_b(1,3);
output_a214{k,7}= seq.qc_outliers_pe(1,1);
output_a214{k,8}= seq.qc_outliers_tot;


%Now to convert the json to csv
% fid=fopen('a214_qc_params.csv','wt'); %creates a csv file with the name
% Mag_str=int2str(seq.MagneticFieldStrength); %this is just to change the integer to string to write in the csv, as magneticfieldstrength is an integer. Other parameters could be directly entered if they are string.
% mot_abs=num2str(seq.qc_mot_abs);
% mot_rel=num2str(seq.qc_mot_rel);
% tot_out=num2str(seq.qc_outliers_b(1,1));
%x={'Subject_ID', 'avg_abs_mot', 'avg_rel_mot', 'pct_outliers_total'; fullFileName, mot_abs, mot_rel, tot_out};
% fprintf(fid,'%s,%d,$f\n', fullFileName, seq.qc_mot_abs, seq.qc_mot_rel, seq.qc_outliers_b(1,1));
% 
% [rows,cols]=size(x)
% total_length=length(filelist) + 1;
%     i=i+1;
%     for i=1:rows
%        fprintf(fid,'%s,',x{i,1:end-1});
%        fprintf(fid,'%s\n',x{i,end})
%     end
 end

colnames={'filename', 'avg_abs_mot_mm', 'avg_rel_mot_mm', 'outliers_b750', 'outliers_b1620', 'outliers_b2500', 'outliers_pe', 'outliers_total_pct'}

% Convert cell to a table and use first row as variable names
T = cell2table(output_a214,'VariableNames',{'filename', 'avg_abs_mot_mm', 'avg_rel_mot_mm', 'outliers_b750', 'outliers_b1620', 'outliers_b2500', 'outliers_pe', 'outliers_total_pct'})
 
% Write the table to a CSV file
writetable(T,'/Volumes/PSYCH_Landi/Projects/A214_MRI/a214_data/derivatives/mrtrix/squad/a214_qc_params.csv');
save output_a214;
% fclose(fid);
