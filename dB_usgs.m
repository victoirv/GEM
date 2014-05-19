function dB_usgs()

load dB_ccmc.mat
for i = 1:length(D1)
    t = regexprep(D1{i},'.*dB_([0-9])','$1');
    t = regexprep(t,'//','/');
    m{i} = upper(regexprep(t,'.*dB_(.*).txt','$1'));
end
m
stations = {'BDT','BOU','BSL','CMO','DED','FRD','FRN','GUA','HON','KGI','NEW','SHU','SIT','SJG','TUC'};

%[Bc{1},datec{1},timec{1}] = readUSGS('2011-09-14','2011-12-31',1440,'CMO');
%[Bc{2},datec{2},timec{2}] = readUSGS('2012-01-01','2012-12-31',1440,'CMO');
[Bd,date,time] = readUSGS('2013-01-01','2013-05-29',1440,'CMO');

Bd(find(Bd(:) == 99999)) = NaN;

BdX = Bd(:,1).*cos(Bd(:,2)*2*pi/(60*360));
BdY = Bd(:,1).*sin(Bd(:,2)*2*pi/(60*360));
    
Td = datenum([date,time]);
Bm = X1{8};
Tm = T1{8};
BdXi = interp1(Td,BdX,Tm);
BdXi = BdXi-nanmean(BdXi);

BdYi = interp1(Td,BdY,Tm);
BdYi = BdYi-nanmean(BdYi);

% Rotate from magnetic to geographic.
BdXio = BdXi;
magDecl = 19.5*(pi/180);
BdXi = BdXi*cos(-magDecl) - BdYi*sin(-magDecl);
BdYi = BdXio*sin(-magDecl) + BdYi*cos(-magDecl);

save dB_usgs.mat Tm Bm BdXi BdYi 