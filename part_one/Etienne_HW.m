%Nichole Etienne 
%BMI 500 
%Table guidance : https://www.mathworks.com/help/matlab/ref/table.html
%slide82 instructions : Code to loop over files and markers and aggregate outcomes into the output dataset

%files 
%input
icd = readtable ("/Users/nicholeetienne/Downloads/Etienne_HW11/part_one/icd.csv");
fpath = ("/Users/nicholeetienne/Downloads/Etienne_HW11/deidentified_trc");
%output 
output = "Etienne_output.csv"

%table 
DT = table(); 
dataTable = table();

%loop
for index=1:size(icd,1)
    fprintf("%i\n",icd.id(index))
    list_file=dir(fpath+icd.id(index)+'/*.trc');
    %inner loop 
    for index2 = 1:length(list_file)
        fname=list_file(index2).name;
        fpath2 = icd.id(index)+"/"+fname;
        outcome = tremor_analysis(...
            'fname', fpath+fpath2,...
            'markername', 'L.Finger3.M3', 'plot_flag', 0);
        
        dataTable.record_id = icd.id(index); 
        dataTable.file = fpath2; 
        dataTable.icd = icd.icd(index); 
        dataTable.markername = {'L.Finger3.M3'}; 
        dataTable.max_p = outcome(1);
        dataTable.f_max_p = outcome(2);
        dataTable.f_sd = outcome(3);
        dataTable.rms_power = outcome(4);
        DT = [DT;dataTable];
    end
end

%output file 
writetable(DT,output)




