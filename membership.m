function output = membership(crispinput, mfunc)
    if ~ismatrix(mfunc)
        error('membership(crispinput, membershipfunction[grade; support])');
    end
%     output = 0;
%     for i=1:length(mfunc)
%        if crispinput == mfunc(2,i) && mfunc(1,i) > 0
%           output = mfunc(1,i); 
%        end
%     end
    [c index] = min(abs(mfunc(2,:)-crispinput));
    output = mfunc(1,index);
end