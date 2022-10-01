function [meshcode,elevation] = get_elevation(path)
    fileID = mopen(path,'r');
    j = 1;

    while ~meof(fileID)
        tline = mgetl(fileID,1);
        if strindex(tline,'<gml:tupleList>') > 0 then
          for i = 1:16
          //i = 1;
            tline = mgetl(fileID,1);
            C = strsplit(tline,',');
            if C(2) <> "unknown" then
                meshcode(j) = C(1);
                elevation(j) = strtod(C(2));
                j = j + 1;
            end
          end
        end
    end

    mclose(fileID);
endfunction
