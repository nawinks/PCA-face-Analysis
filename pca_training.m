clear all;

%Initilize data
imageFolder = "./dataset/";
image_width = 200;
image_height = 200;

% Get list of all JPG files in this directory
imagefiles = dir('./dataset/*.jpg');     
numberOfImages = length(imagefiles);    % Number of files found

%Initializing arrays 
imageVectors = double(zeros(image_width*image_height*3,numberOfImages));
sumImage = double(zeros(image_width,image_height,3));

%loop to load images
disp("Loading Image ...");
for itr=1:numberOfImages
   currentFileName = imagefiles(itr).name;
   currenfullfilename = fullfile(imageFolder,currentFileName);
   currentimage = double(imread(currenfullfilename));
   imageVectors(:,itr) = reshape(currentimage,image_width*image_height*3,1);
   sumImage += currentimage;
end

%Finding mean image
meanImage = sumImage / numberOfImages;
%imshow(uint8(meanImage));
imwrite(uint8(meanImage),"meanImage.jpg");
meanImageReshaped = reshape(meanImage,image_height*image_width*3,1);

%loop for subtracting mean image from each image
disp("Subtracting mean Image from all images ...");
for itr=1:numberOfImages
  imageVectors(:,itr) = imageVectors(:,itr) - meanImageReshaped;
end

%Applying PCA to zero meaned images
%Finding Covariance matrix
disp("Finding PCA ...");
covImages = transpose(imageVectors)*imageVectors;
%Finding Eigen vectors and Eigen values
[Vtemp,mtemp] = eig(covImages);
V = real(imageVectors*Vtemp);%Vectors of transformed PCA space
m = diag(mtemp);%Eigen values of vectors

%Saving 100 Principal vectors as array
disp("saving PCA ...");
V_100 = V(:,1:100);
m_100 = m(1:100);
save V_100.mat V_100;
save m_100.mat m_100;
save mean_image.mat meanImage

%Saving 100 Principal vectors as images
disp("Saving PCA vectors as Image ...");
if ~exist("PCA_images", 'dir')
   mkdir("PCA_images")
end
for itr=1:100
  vec = reshape(V(:,itr),image_height*image_width*3,1);
  vecNorm = 255*(vec - min(vec))/(max(vec)-min(vec));
  vecImg = reshape(vecNorm,image_height,image_width,3);
  fname = ["PCA_images/",num2str(itr),".jpg"];
  imwrite(uint8(vecImg),fname);
end