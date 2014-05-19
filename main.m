if (1)
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 12)
set(0,'DefaultAxesFontWeight', 'normal')

% Change default text fonts.
set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', 12)
set(0,'DefaultTextFontWeight', 'normal')
end

if ~exist('m-rsw','dir')
    system('svn co http://aurora.gmu.edu/svn/m-rsw/');
    addpath('m-rsw');
    setpaths;
end

addpath('m-rsw');
addpath('m-rsw/stats');

dB_ccmc()
%dB_plot()

dB_usgs()
dB_compare()