import cv2
import numpy as np
import pylab as plt

# Reading the RGB image
image1 = cv2.imread("/home/ritu/Desktop/DIP/
cluster.jpg")
image = image1.copy()

image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)# convert to RGB
fig, ax = plt.subplots(nrows=1, ncols=1, figsize=(15,5))
ax.imshow(cv2.cvtColor(image1, cv2.COLOR_BGR2RGB))
plt.xticks([]), plt.yticks([])
plt.show()

color = ('b','g','r')
for i,col in enumerate(color):
histr = cv2.calcHist([image1],[i],None,[256],[0,256])
plt.plot(histr,color = col)
plt.xlim([0,256])
plt.show()

# Performing k-means clustering based on color
# reshape the image to a 2D array of pixels and 3 color values (RGB)
vectorized = image1.reshape((-1,3))
vectorized = np.float32(vectorized) # convert to float

# define stopping criteria
criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
K = 9 # number of clusters
attempts=10
ret,label,center=cv2.kmeans(vectorized,K,None,criteria,attempts,cv2.KMEANS_PP_CEN
TERS)

# convert back to 8 bit values
center = np.uint8(center)

# flatten the labels array
res = center[label.flatten()]

# convert all pixels to the color of the centroids
res=center[label]

# reshape back to the original image dimension
result_image1 = res.reshape((image1.shape))

# show the image
plt.imshow(cv2.cvtColor(result_image1, cv2.COLOR_BGR2RGB))
plt.show()

# disable only the cluster number 2 (turn the pixel into black)
masked_image = np.copy(image)

# convert to the shape of a vector of pixel values
masked_image = masked_image.reshape((-1, 3))

# color (i.e cluster) to disable
cluster = 2 # Label no. of cluster to be segmented
masked_image[labels != cluster] = [0, 0, 0]

# convert back to original shape
masked_image = masked_image.reshape(image.shape)

# show the image
plt.imshow(masked_image)
plt.show()