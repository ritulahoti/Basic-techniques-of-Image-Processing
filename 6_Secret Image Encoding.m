import cv2
import numpy as np
from matplotlib import pyplot as plt
import random
from skimage import measure

carrier = cv2.imread("/home/ritu/Desktop/DIP/
carrier.jpg")
secret = cv2.imread("/home/ritu/Desktop/DIP/
secret.jpg")
fig = plt.figure()
fig.set_figheight(5)
fig.set_figwidth(15)

# Display the original image
fig.add_subplot(1,2,1)
plt.imshow(cv2.cvtColor(carrier, cv2.COLOR_BGR2RGB))
plt.xticks([]), plt.yticks([])
fig.add_subplot(1,2,2)
plt.imshow(cv2.cvtColor(secret, cv2.COLOR_BGR2RGB))
plt.xticks([]), plt.yticks([])
plt.show()

if secret.shape[0] > carrier.shape[0] or secret.shape[1] > carrier.shape[1]:
raise ValueError('Carrier image size is lower than secret image size!')
width = secret.shape[1]
height = secret.shape[0]
dim = (width, height)

######### Encryption function
for i in range(height):
for j in range(width):
for l in range(3):
# v1 and v2 are 8-bit pixel values
# of img1 and img2 respectively
v1 = format(carrier[i][j][l], '08b')
v2 = format(secret[i][j][l], '08b')
# Taking 4 MSBs of each image
v3 = v1[:4] + v2[:4]
carrier[i][j][l]= int(v3, 2)
cv2.imwrite('secret_encoded.png', carrier)

######### Decryption function
# Encrypted image
img = cv2.imread('secret_encoded.png')
width = img.shape[0]
height = img.shape[1]
# img1 and img2 are two blank images
img1 = np.zeros((width, height, 3), np.uint8)
img2 = np.zeros((width, height, 3), np.uint8)
for i in range(width):
for j in range(height):
for l in range(3):
v1 = format(img[i][j][l], '08b')
v2 = v1[:4] + chr(random.randint(0, 1)+48) * 4
v3 = v1[4:] + chr(random.randint(0, 1)+48) * 4

# Appending data to img1 and img2
img1[i][j][l]= int(v2, 2) #decrypted
img2[i][j][l]= int(v3, 2) #secret

##### Croping secret image to its original size
width = secret.shape[0]
height = secret.shape[1]
secret_decoded = img2[0:width, 0:height]

##### Saving the images obtained
cv2.imwrite('carrier_recovered.png', img1)
cv2.imwrite('secret_decoded.png', secret_decoded)

##### Display all outputs
fig = plt.figure()
fig.set_figheight(10)
fig.set_figwidth(20)
fig.add_subplot(2,2,1)
plt.imshow(cv2.cvtColor(carrier, cv2.COLOR_BGR2RGB))
plt.title('Secret encoded carrier image')
plt.xticks([]), plt.yticks([])
fig.add_subplot(2,2,2)
plt.imshow(cv2.cvtColor(img1, cv2.COLOR_BGR2RGB))
plt.title('Carrier image recovered')
plt.xticks([]), plt.yticks([])
fig.add_subplot(2,2,3)
plt.imshow(cv2.cvtColor(img2, cv2.COLOR_BGR2RGB))
plt.title('Secret Decoded')
plt.xticks([]), plt.yticks([])
fig.add_subplot(2,2,4)
plt.imshow(cv2.cvtColor(secret_decoded, cv2.COLOR_BGR2RGB))
plt.title('Rescaled secret image')
plt.xticks([]), plt.yticks([])
plt.show()

#### Analyse merging of MSBs
v1 = format(carrier[20][2][0], '08b')
v2 = format(secret[20][2][0], '08b')
# Taking 4 MSBs of each image
v3 = v1[:4] + v2[:4]
print('4 MSB(',v1,') + 4 MSB(',v2,')=', v3)

##### Quality evaluation
error = mse(carrier,img1)
print("MSE: ",error)
s = measure.compare_ssim(carrier, img1,multichannel=True)
print("SSIM: ",s)
error = mse(secret,secret_decoded)
print("MSE: ",error)
s = measure.compare_ssim(secret, secret_decoded,multichannel=True)
print("SSIM: ",s)