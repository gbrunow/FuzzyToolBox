function out = fmamdani(input, inference, output)
    if ~isvector(input) || ~iscell(inference) || ~iscell(output)
        error('fmamdani(vector input, cell inference, cell output)');
    end
    
    datasize = size(inference);
    sys_temp = zeros(size(output{1}(1,1:end)));
    for i=1:datasize(1) %rules number
        memb_temp = 1;
        for j=1:datasize(2) %inferences number
            if ismatrix(inference{i,j})
                    memb_temp = min(memb_temp, membership(input(j),inference{i,j})); %find the smallest membership value
            else
                disp(strcat('--  Inference {', int2str(i),', ', int2str(j), '} ignored.'));
            end
        end
        sys_temp = max(sys_temp,min(memb_temp, output{i}(1,1:end)));
    end      
    out = sys_temp;       
end