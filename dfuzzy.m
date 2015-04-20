function out = dfuzzy(support, grade)
    if ~isvector(support) || ~isvector(grade)
        error('dfuzzy(support vector, grade vector)');
    end
    out = trapz(grade(1,1:end).*support(1,1:end))/trapz(grade(1,1:end));
end    
