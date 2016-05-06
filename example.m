texture = imread('T1.gif');

t2 = synthesize(texture', 4 * size(texture), 12, 2);

figure(1)
imshow(texture);
figure(2)
imshow(uint8(t2))

