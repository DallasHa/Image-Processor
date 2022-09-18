# Image Processor
This image processor receives filename input from a user and opens the corresponding PGM (black and white image) file. The program then verifies the size and filetype identifier contained in the image. The user is then prompted to select an image processing algorithm to be applied to the image.
The four transformations options offered are:

<strong>Image inversion</strong> - Each pixel is mapped to its greyscale opposite

<strong>Logarithmic transformation</strong> - An image enhancement technique which converts each pixel to its logarithmic equivalent

<strong>Histogram equalization</strong> - An algorithm which stores the pixels in a histogram and preforms intensity modifications based on greyscale distribution

<strong>Contrast stretching</strong> - Alters the contrast of the image by stretching the pixel intensity range, which the user is prompted to either input themselves or have automatically calculated

This program should be run with gcc using the -x flag to force the compiler to use ADA. All dependencies should be in the same folder. Sample usage:

gcc -x ada -c main.ada

Sample program navigation (using GNAT IDE):

![Sample Output](https://github.com/DallasHa/Image-Processor/blob/b798341a7c01da184e2f088091882536d8928119/output.PNG?raw=true "Title")

The following sample pgm(test3_p2.pgm) image as well as its transformation results can be seen below and found in this repository.

<strong>Original Image:</strong>

![Sample Output](https://github.com/DallasHa/Image-Processor/blob/54de78e9e7ef3c7ce0aedad170939dce71e6f3bf/test3.png?raw=true "Title")

<strong>Inversion:</strong>

![Sample Output](https://github.com/DallasHa/Image-Processor/blob/54de78e9e7ef3c7ce0aedad170939dce71e6f3bf/test3Inversion.png?raw=true "Title")

<strong>Logarithmic Transformation:</strong>

![Sample Output](https://github.com/DallasHa/Image-Processor/blob/54de78e9e7ef3c7ce0aedad170939dce71e6f3bf/test3LogarithmicTransformation.png?raw=true "Title")

<strong>Histogram Equalization:</strong>

![Sample Output](https://github.com/DallasHa/Image-Processor/blob/54de78e9e7ef3c7ce0aedad170939dce71e6f3bf/test3Histogram.png?raw=true "Title")

<strong>Contrast Stretching</strong>(automatically calculated):

![Sample Output](https://github.com/DallasHa/Image-Processor/blob/54de78e9e7ef3c7ce0aedad170939dce71e6f3bf/test3ContrastStretching.png?raw=true "Title")
