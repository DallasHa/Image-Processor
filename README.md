# Image Processor
This image processor recieves filename input from a user and opens the corresponding PGM (black and white image) file. The program then verifies the size and filetype identifer contained in the image. The user is then prompted to select an image processing algorithm to be applied to the image. 
The four transformations options offered are:

Image inversion - Each pixel is mapped to its greyscale opposite 

Logarithmic transformation - An image enhancement technique which converts each pixel to its logarithmic equivalent 

Histogram equalization - An algorithm which stores the pixels in a histogram and preforms intensity modifications based on greyscale distribution

Contrast stretching - Alters the images contrast by stretching the the pixels intensity range, which the user is prompted to either input themselves or have automatically calculated

This program should be run with gcc using the -x flag to force compiler to use ADA. All dependencies should be in the same folder. Sample usage:

gcc -x ada -c main.ada

Sample program navigation (using GNAT IDE):
![Sample Output](output.PNGraw=true "Title")
