function [B,date,time] = readUSGS(Start,Stop,ppd,Station)
%READUSGS Read magnetometer data from magweb.cr.usgs.gov/data/magnetometer/
%
%    [B,date,time] = readUSGS(Start,Stop) Reads 1-minute data from all
%    stations.  Outputs are cell arrays.
%
%    [B,date,time] = readUSGS(Start,Stop,ppd) Reads either 1-minute data
%    (ppd=1440) or 1-second data (ppd=86400).
%
%    [B,date,time] = readUSGS(Start,Stop,ppd,Station) Read data from single
%    station.  Output is matrix.
%
%

stations = {'BDT','BOU','BSL','CMO','DED','FRD','FRN','GUA','HON','KGI','NEW','SHU','SIT','SJG','TUC'};

if (nargin < 4)
  for i = 1:length(stations)
    [B{i},date{i},time{i}] = readUSGS(Start,Stop,ppd,stations{i});
  end
  return;
end
if (nargin < 3)
  ppd = 1440;
end

% Set forceUpdate=true if problem loading file.
url0 = 'http://datacache.org/dc/sync?forceUpdate=false&return=stream&template=http://magweb.cr.usgs.gov/data/magnetometer/';
if ~exist('./data/usgs')
  system('mkdir -p data/usgs')
end
if (ppd == 1440)
  fname = sprintf('./data/usgs/%s_%s_%s_%d.txt',lower(Station),strrep(Start,'-',''),strrep(Stop,'-',''),ppd);
  url1 = sprintf('%s/OneMinute/%s',upper(Station),lower(Station));
  url2 = ['%Y%m%dvmin.min&timeRange=',Start,'/',Stop];
elseif (ppd == 1440*60)
  fname = sprintf('./data/usgs/%s_%s_%s_%d.txt',lower(Station),strrep(Start,'-',''),strrep(Stop,'-',''),ppd);
  url2 = ['%Y%m%dvsec.sec&timeRange=',Start,'/',Stop];
  url1 = sprintf('%s/OneSecond/%s',upper(Station),lower(Station));
else
  % TODO: If PPD < 1440, get 1440 data and average.
  %       If PPD > 86400, get 86400 data and average.
  error('ppd must be 1440 or 86400');
end

fnamem = strrep(fname,'.txt','.mat');
if ~exist(fnamem)
  com = sprintf('curl --compressed "%s" > %s',[url0,url1,url2],fname)
  fprintf('readUSGS.m: Calling system with command: %s\n',com);
  system(com);
  fprintf('readUSGS.m: Reading %s\n',fname);
  data = load(fname);
  save(fnamem,'data');
else
  fprintf('readUSGS.m: Reading: %s\n',fnamem);
  load(fnamem);
end

B    = data(:,8:10);
date = data(:,1:3);
time = data(:,4:6);







