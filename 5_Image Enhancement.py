import cv2
import numpy as np
from matplotlib import pyplot as plt
from skimage.morphology import disk
from skimage.filters import rank

img = cv2.imread('/home/ritu/Desktop/DIP/
equalize.jpg')
hist,bins = np.histogram(img.flatten(),256,[0,256])
cdf = hist.cumsum()
cdf_normalized = cdf * hist.max()/ cdf.max()

####### Global Histogram Equalization
cdf_m = np.ma.masked_equal(cdf,0)
cdf_m = (cdf_m - cdf_m.min())*255/(cdf_m.max()-cdf_m.min())
cdf = np.ma.filled(cdf_m,0).astype('uint8')
img2 = cdf[img]

####### Localized Histogram Equalization
selem = disk(8)
img3 = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
img_eq = rank.equalize(img3, selem=selem)
hist,bins = np.histogram(img_eq.flatten(),256,[0,256])
cdf_eq = hist.cumsum()
cdf_local_eq = cdf_eq * hist.max()/ cdf_eq.max()

########### Plotting ############
fig = plt.figure()
fig.set_figheight(10)
fig.set_figwidth(20)

##### Display the original image ####
fig.add_subplot(3,2,1)
plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
plt.title('Original Input Image')

# Plotting the histogram and cdf of original image
fig.add_subplot(3,2,2)
plt.plot(cdf_normalized, color = 'b')
plt.hist(img.flatten(),256,[0,256], color = 'r')
plt.xlim([0,256])
plt.legend(('cdf','histogram'), loc = 'upper left')

#### Display the globally equalized image ####
fig.add_subplot(3,2,3)
plt.imshow(cv2.cvtColor(img2, cv2.COLOR_BGR2RGB))
plt.title('Histogram Equalized Image')

# Plotting the histogram and cdf of global equalized image
fig.add_subplot(3,2,4)
plt.plot(cdf, color = 'b')
plt.hist(img2.flatten(),256,[0,256], color = 'r')
plt.xlim([0,256])
plt.legend(('cdf','histogram'), loc = 'upper left')

#### Display the locally equalized image ####
fig.add_subplot(3,2,5)
plt.imshow(cv2.cvtColor(img_eq, cv2.COLOR_GRAY2RGB))
plt.title('Local Histogram Equalized Image')

# Plotting the histogram and cdf of locally equalized image
fig.add_subplot(3,2,6)
plt.plot(cdf_local_eq, color = 'b')
plt.hist(img_eq.flatten(),256,[0,256], color = 'r')
plt.xlim([0,256])
plt.legend(('cdf','histogram'), loc = 'upper left')
plt.show(