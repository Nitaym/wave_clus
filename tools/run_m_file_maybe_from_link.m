function [m, new_fname] = run_m_file_maybe_from_link(m_fname)
% run_m_file_maybe_from_link    
%
%                               m_fname - string - m file name, without the
%                                                  '.m' suffix.

% Author: Ariel Tankus.
% Created: 10.03.2024.


cur_wd = pwd;

try
    [filepath, name, ext] = fileparts(m_fname);
    if (~isempty(filepath))
        cd(filepath);
    end
    if (~isempty(ext))
        name = [name, ext];
    end
    eval(sprintf("m = %s;", name));
    
    new_fname = [pwd, filesep, name];
catch ME
    if (strcmp(ME.identifier,'MATLAB:m_illegal_character'))
        
        fid = fopen([m_fname, '.m'], 'r');
        link_str = fscanf(fid, '%s');

        % link file has a header of 8 char, and each letter in the destination file name is separated by a null char.
        if (strcmp(link_str(1:7), "IntxLNK") & (all(double(link_str(10:2:end)) == 0)))
            % file is a Linux link:
            new_fname = link_str(9:2:end);

            [new_filepath, new_name, new_ext] = fileparts(new_fname);

            % go to the destination dir, so relative paths will be relative
            % to that path:
            cd(new_filepath);

            if (~isempty(ext))
                new_name = [new_name, new_ext];
            end

            % recursively test if the destination file is itself yet
            % another link:
            [m, new_fname] = run_m_file_maybe_from_link(m_fname);
            fclose(fid);
        else
            fclose(fid);
            rethrow(ME);
        end

    else
        rethrow(ME);
    end
end

cd(cur_wd);
