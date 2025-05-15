function brain_region = find_brain_region(ch, use_clusters)
% find_brain_region    

% Author: Ariel Tankus.
% Created: 23.07.2005.
% Modified: 10.03.2024. Add run_m_file_maybe_from_link to handle Linux
%                       links on Windows.


if (nargin < 2)
    use_clusters = true;
end

if ~strcmp(class(ch), 'double')
    ch = str2num(ch);
end

if (use_clusters & exist('clusters_electrode_montage.m', 'file'))
    %m = clusters_electrode_montage;
    [m, new_fname] = run_m_file_maybe_from_link('clusters_electrode_montage');
else
    %m = electrode_montage;
    [m, new_fname] = run_m_file_maybe_from_link('electrode_montage');
end
for i=1:size(m, 1)
    if (any(m{i, 1} == ch))
        brain_region = m{i, 2};
        return;
    end
end

brain_region = 'Unknown';
