% Create .json files for images and descriptions

IMAGE_COUNT = 1449;

images = repmat(struct('sentids', 1, 'imgid', 1, 'sentences', 1, ...
                       'split', 1, 'filename', 1), IMAGE_COUNT, 1);
images = images(:)' % convert to vector so that 1-D array is printed in JSON
    
for i = 1:IMAGE_COUNT
    id = sprintf('%04d', i) 
    imageFileName = strcat(id, '.jpg')
    descriptionFileName =  strcat(id, '.mat')
    descriptionFile = load(descriptionFileName);
    annotation = descriptionFile.annotation;
    text = annotation.descriptions.text;
    words = annotation.descriptions.words;
    sentence = struct('tokens', {words}, 'raw', text, 'imgid', id, 'sentid', id);
    sentences = {sentence};
    sentIds = {id};
    image = struct('sentids', sentIds, 'imgid', id, 'sentences', sentences, ...
                   'split', 'train', 'filename', imageFileName);
    images(i) = image;
end

json = savejson('images', images, 'dataset_0.json');