function dB_ccmc()


if ~exist('dB_ccmc.mat','file')

    % ftp://virbo.org/users/rastaetter/dB_20121227-20130529/
    D1 = dirwalk('/home/victoir/Work/GEM/data/ccmc/dB_20121227-20130529/');
    % ftp://virbo.org/users/rastaetter/dB_20110812-20121120/
    D2 = dirwalk('/home/victoir/Work/GEM/data/ccmc/dB_20110812-20121120/');

    for i = 1:length(D1)
        fname = D1{i};

        fid   = fopen(fname);
        l = fgetl(fid);
        % Find first data line
        while 1
            l = fgetl(fid);
            if regexp(l,'^[0-9]');,break,end
        end
        % Read rest of file and prepend first data line
        s = fscanf(fid,'%c',Inf);

        fprintf('readfile: Converting string to number.\n');

        % Convert string to numbers, append first data line
        d = [str2num(l);str2num(s)];

        fclose(fid);

        T1{i} = datenum([d(:,1),d(:,2),d(:,3),d(:,4),d(:,5),d(:,6)]);
        X1{i} = d(:,7:end);
    end

    for i = 1:length(D2)
        fname = D2{i};

        fid   = fopen(fname);
        l = fgetl(fid);
        % Find first data line
        while 1
            l = fgetl(fid);
            if regexp(l,'^[0-9]');,break,end
        end
        % Read rest of file and prepend first data line
        s = fscanf(fid,'%c',Inf);

        fprintf('readfile: Converting string to number.\n');

        % Convert string to numbers, append first data line
        d = [str2num(l);str2num(s)];

        fclose(fid);

        T2{i} = datenum([d(:,1),d(:,2),d(:,3),d(:,4),d(:,5),d(:,6)]);
        X2{i} = d(:,7:end);
    end

    save dB_ccmc.mat T1 T2 X1 X2 D1 D2
end