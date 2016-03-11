function dn = datelist(sdate, edate, months, days, hrs, mins, secs);
%DATELIST Lists datenumbers for months/days/hours/etc between two dates
%
% dn = datelist(sdate, edate, months, days, hrs, mins, secs);
%
% This lists all dates between the two given dates that match the criteria
% defined in the remaining input variables.  If any of the time variables
% are not included, they are set to the value in brackets.
%
% Input variables:
%
%   sdate:  starting date, as datenumber, date vector, or date string
%
%   edate:  ending date, as datenumber, date vector, or date string
%
%   months: months to include [1]
%
%   days:   days of the month to include [1]
%
%   hrs:    hours to include [0]
% 
%   mins:   minutes to include [0]
%
%   secs:   seconds to include [0]
%
% Output variables:
%
%   dn:     vector of datenumbers
%
% Examples:
%
% dn = datelist(now, now-10, 1:12, 1:31, 0:23); % list all hours from the
%                                               % last 10 days
%
% dn = datelist('2000-01-01', '2005-01-01', 1:3:12); % 4 months/year for 5
%                                                    % years, 1st of the
%                                                    % month

% Copyright 2013 Kelly Kearney


isdv = @(x) isnumeric(x) && isvector(x) && length(x)==6;

if ~isdv(sdate)
    sdate = datevec(sdate);
end
if ~isdv(edate)
    edate = datevec(edate);
end

dv = [sdate; edate];

yr = (dv(1,1):dv(2,1))';

if nargin < 3
    months = 1;
end
if nargin < 4
    days = 1;
end
if nargin < 5
    hrs = 0;
end
if nargin < 6
    mins = 0;
end
if nargin < 7
    secs = 0;
end

[yr, months, days, hrs, mins, secs] = ndgrid(yr, months, days, hrs, mins, secs);
dvall = [yr(:), months(:), days(:), hrs(:), mins(:), secs(:)];
dn = datenum(dvall);


dn = unique(dn); % Duplicates arise from 31st, leap year, etc
dn(dn < datenum(sdate) | dn > datenum(edate)) = [];