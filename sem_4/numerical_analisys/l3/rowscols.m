function [rows, cols] = rowscols(len)
    try
        rows = ceil(sqrt(len));
        cols = ceil(len / rows);
    catch
        rows = 2;
        cols = 2;
    end
end
