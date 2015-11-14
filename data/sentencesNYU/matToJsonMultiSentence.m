% Create .json files for images and descriptions

IMAGE_COUNT = 1449;

images = {};

currentSentId = 1;
    
for i = 1:IMAGE_COUNT
    id = sprintf('%04d', i);
    imageFileName = strcat(id, '.jpg')
    descriptionFileName =  strcat(id, '.mat');
    descriptionFile = load(descriptionFileName);
    annotation = descriptionFile.annotation;
    text = annotation.descriptions.text;
    words = annotation.descriptions.words;
    
    rawSentences = textscan(text, '%s', 'Delimiter', '.');
    rawSentences = rawSentences{1, 1};
    rawSentences = strcat(rawSentences, '.');
    
    sentences = {};
    sentIds = {};
    for n = 1:size(rawSentences, 1)
        stopIndex = find(strcmp(words, '.'), 1);
        tokens = words(1 : stopIndex);
        words = words(stopIndex + 1 : end);
        sentence = struct('tokens', {tokens}, 'raw', rawSentences(n), ...
                          'imgid', i, 'sentid', currentSentId);
        sentences = [sentences sentence];
        sentIds = [sentIds currentSentId];
        currentSentId = currentSentId + 1;
    end

    image = struct('sentids', {sentIds}, 'imgid', i, 'sentences', {sentences}, ...
                   'split', 'train', 'filename', imageFileName);
    images = [images image];

end

images = images(:)'; % convert to vector so that 1-D array is printed in JSON

json = savejson('images', images, 'dataset_raw.json');