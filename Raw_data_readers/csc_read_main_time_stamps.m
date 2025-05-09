function [time0, timeend, sr, timetotal] = read_main_time_stamps(filename)
% read_main_time_stamps    Read the first, second and last time stamps, and
%                          compute the sampling rate and total length of
%                          recording time.
%
%                          [time0, timeend, sr, timetotal] = ...
%                                    read_main_time_stamps(filename)
%                          filename  - string - .Ncs file name.
%                          time0     - 1x1 - first time stamp [microsec.].
%                          timeend   - 1x1 - last time stamp [microsec.].
%                          sr        - 1x1 - sampling frequency [Hz].
%                          timetotal - 1x1 - total recording time [sec.].
%     
%                               See also: read_ncs, convert_ncs,
%                                         read_first_time_stamp,
%                                         read_first_last_time_stamp.

% Author: Ariel Tankus.
% Created: 05.12.2005.


[first_time_stamps, last_time_stamp] = csc_read_first_last_time_stamp(filename);
time0 = first_time_stamps(1); 
timeend = last_time_stamp;
sr = 512 * 1e6 ./ diff(first_time_stamps);
timetotal = (timeend - time0)*1E-6;
