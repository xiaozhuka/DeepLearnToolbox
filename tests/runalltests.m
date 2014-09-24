clear all; close all; clc;
curr_path = fileparts(mfilename('fullpath'));
index=strfind(curr_path, '\');
if ~isempty(index)
    index = index(end);
else
    return;
end
addpath(genpath(curr_path(1:index-1)));
dirlist = dir(strcat(curr_path, '\test_*'));
for i = 1:length(dirlist)
    name = dirlist(i).name(1:end-2);
    feval(name)
end
