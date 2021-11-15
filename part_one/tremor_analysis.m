%Nichole Etienne 
%BMI 500 
%Tremor Analysis code based on Slide 81 of BMI Lecture 12 


function outcomes = tremor_analysis(varargin)

%set up input parser
default_fname = "https://jlucasmckay.bmi.emory.edu/global/bmi500/sit-rest1-TP.trc";
%"/Users/nicholeetienne/Downloads/deidentified_trc";
default_markername = "L.Finger3.M3";
default_plot_flag=0;

prs = inputParser;
prs.addOptional('fname', default_fname);
prs.addOptional('markername', default_markername);
prs.addOptional('plot_flag',default_plot_flag);
prs.parse(varargin{:});

%assign arguments
fname = prs.Results.fname;
markername = prs.Results.markername;
plot_flag = prs.Results.plot_flag;

%read 
trc = rename_trc(read_trc(fname));
raw_data = trc{:,startsWith(names(trc),markername)};
filtered_data = preprocess_marker_data(raw_data,trc.Time, [2 45]); 

%principle component 1
time_s = trc.Time;
pc1_mm = pc1(filtered_data);

TT=timetable(seconds(time_s),pc1_mm);
TT.Properties.VariableNames = [markername];
TT.Properties.VariableUnits = ["mm"];

[p,f,t] = pspectrum(TT, 'spectrogram', 'MinThreshold' ,-50, 'FrequencyResolution' ,0.5, 'FrequencyLimits', [0 20]) ;

%max_p 
max_p = max(p,[],[1 2]);

%max index
maxindex = (max(p,[],[2])==max_p);

%f_max_p
f_max_p = f(maxindex);
[~, max_rows ] = max(p,[],[1]);

%f_sd
f_sd = std(f(max_rows));

frmsrange = (f >f_max_p-0.5 & f<f_max_p+0.5); 

%rms_power
rms_power = sqrt(sum(p(frmsrange,:),"all")/length(t));
outcomes = [max_p, f_max_p, f_sd, rms_power];

