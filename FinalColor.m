
% SCALE = 2;
SCALE = 3;
% SCALE = 4;
BICTESTDATA_PATH = ['./Testx',num2str(SCALE),'Color/'];
SRDATA_PATH = ['./Resultx',num2str(SCALE),'Lum/'];
STOR_PATH = ['./Resultx',num2str(SCALE),'Color/'];
BICTESTDATA_bud = dir([BICTESTDATA_PATH,'/*.bmp']); % or whatever the filename extension is
fprintf('Start to generate color SR SCALE %s \n', num2str(SCALE));
fprintf('Luminance SR from %s \n', SRDATA_PATH);
fprintf('Cb Cr channel from %s \n', BICTESTDATA_PATH);
fprintf('Finial color SR store to %s \n', STOR_PATH);
for img_idx = 1:numel(BICTESTDATA_bud)
    BICTestFileName = BICTESTDATA_bud(img_idx).name;
    fprintf('Image: %s | %s \n', num2str(img_idx), BICTestFileName);
    BICTestImg = imread([BICTESTDATA_PATH,'/',BICTestFileName]);
    im_gnd = modcrop(BICTestImg, up_scale);
    im_gnd = single(im_gnd)/255;
    BIC_downscale=imresize(im_gnd,1/SCALE,'bicubic');
    BICBICTest_img = imresize(BIC_downscale, SCALE,'bicubic');
    TestImg_ycbcr = rgb2ycbcr(BICBICTest_img);
    TestImg_ycbcr(:,:,1) = 0;
    SRImg = imread([SRDATA_PATH,'/',BICTestFileName]);
    TestImg_ycbcr(:,:,1) = SRImg;
    SRColor = ycbcr2rgb(TestImg_ycbcr);
    imwrite(SRColor, [STOR_PATH,'/',BICTestFileName]);
end
