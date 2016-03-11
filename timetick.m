function timetick(ax, varargin)
%TIMETICK Add datestring-style ticks in specific locations
%
% timetick(ax, loc1, loc2, ...)
%
% This function is similar to datetick in that it allows labeling of time
% axes via datestring-formatted labels, but instead of trying to pick the
% best interval, it allowsthe user to specify exactly where to place the
% tick.
%
% Input variables:
%
%   ax:   handles of axes to label
%
%   loc#: 1 x n cell arrays, holding input to datelist along with a
%         formatting string.  For example, {'yyyy'} means to label every
%         start-of-year, {1:12, 15, 'm'} means to label the 15th of every
%         month.  You can specify as many combos as you want; if a
%         particular tick location falls into more than one set, the first
%         label will be used (for example, timetick(gca, {'yyyy'},
%         {1:12,'m'}) will label the first of every month with the first
%         letter of the month, except for January, where the year will be
%         added).

% Copyright 2014 Kelly Kearney

tlim = get(ax, 'xlim');
if iscell(tlim)
    tlim = minmax(cat(2, tlim{:}));
end
dv = datevec(tlim);

for ii = 1:length(varargin)
    
    tktmp = datelist(tlim(1), tlim(2), varargin{ii}{1:end-1});
    lbltmp = strtrim(cellstr(datestr(tktmp, varargin{ii}{end})));
    
    if ii > 1
        isrepeat = ismember(tktmp, tk);
        tk = [tk; tktmp(~isrepeat)];
        lbl = [lbl; lbltmp(~isrepeat)];
    else
        tk = tktmp;
        lbl = lbltmp;
    end
        
end

[tk, isrt] = sort(tk);
lbl = lbl(isrt);

set(ax, 'xtick', tk, 'xticklabel', lbl);

