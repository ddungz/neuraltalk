IMAGE_COUNT = 1449;

fileID = fopen('all_imgs.txt','w');
    
for i = 1:IMAGE_COUNT
    id = sprintf('%04d', i);
    imageFileName = strcat(id, '.jpg')
    fprintf(fileID,'%s\n', imageFileName);
end

fclose(fileID);