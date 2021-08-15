clear all;

%Initilize data
vecNo = 16;%change from 1 to 100
image_width = 200;
image_height = 200;

%Loading matrix made on PCA training
disp("Loading PCA Vectors...");
load V_100.mat
disp("Loading PCA eigen values...");
load m_100.mat
disp("Loading PCA eigen values...");
load mean_image.mat

meanImageReshaped = reshape(meanImage,image_height*image_width*3,1);

%Loop for seeing variation of mean image in direction of PCA vectors
weight = [-1:0.1:1];
for itr=0:20
  imgVec = reshape(V_100(:,3),image_height*image_width*3,1);%3
  imgVecNorm = 255*(imgVec - min(imgVec))/(max(imgVec)-min(imgVec));
  imgBlend = weight(itr+1) * imgVecNorm + meanImageReshaped;
  imgBlendNorm = 255*(imgBlend - min(imgBlend))/(max(imgBlend)-min(imgBlend));
  img = reshape(imgBlendNorm,image_height,image_width,3);
  imwrite(uint8(img),["try",num2str(itr),".jpg"]);
end