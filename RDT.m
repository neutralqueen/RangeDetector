
Error = testsnc((@(x,y) (snc(x,y))));
if(isempty(Error))
    disp('All Tests Passed!');
else
    disp(Error');
end