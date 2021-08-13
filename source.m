clear all;

%Initilize data
imageFolder = "./utkcropped/";
image_width = 200;
image_height = 200;
noFilesToUse = 40;

% Get list of all JPG files in this directory
imagefiles = dir('./utkcropped/*.jpg');     
nfiles = length(imagefiles);    % Number of files found
allimages = double(zeros(image_width*image_height*3,noFilesToUse));
sumImage = double(zeros(image_width,image_height,3));
%for ii=1:nfiles
count = 0;
for ii=1:noFilesToUse
   currentfilename = imagefiles(ii).name;
   currenfullfilename = fullfile(imageFolder,currentfilename);
   currentimage = double(imread(currenfullfilename));
   if size(currentimage,3) == 3 %only colored RGB image
      allimages(:,ii) = reshape(currentimage,image_width*image_height*3,1);
      sumImage += currentimage;
   else
      count = count + 1;
   end
end
noFilesToUse = noFilesToUse - count;

meanImage = sumImage / noFilesToUse;
%imshow(uint8(meanImage));
imwrite(uint8(meanImage),"meanImage.jpg");

meanImageReshape = reshape(meanImage,image_height*image_width*3,1);
for ii=1:noFilesToUse
  allimages(:,ii) = allimages(:,ii) - meanImageReshape;
end

covImages = transpose(allimages)*allimages;
[Vtemp,mtemp] = eig(covImages);
V = allimages*Vtemp;
m = diag(mtemp);

%ca1 = reshape(V(:,1),image_height*image_width*3,1);
%pca1x = 255*(pca1 - min(pca1))/(max(pca1)-min(pca1));
%pca1xx = reshape(pca1x,image_height,image_width,3);
%imshow(uint8(pca1xx));
%imwrite(uint8(pca1xx),"pca1.jpg");

for ii=1:noFilesToUse
  pca1 = reshape(V(:,ii),image_height*image_width*3,1);
  pca1x = 255*(pca1 - min(pca1))/(max(pca1)-min(pca1));
  pca1xx = reshape(pca1x,image_height,image_width,3);
  %mshow(uint8(pca1xx));
  fname = ["./op/pca_",num2str(ii),".jpg"];
  imwrite(uint8(pca1xx),fname);
end