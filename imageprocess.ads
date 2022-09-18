with ada.strings.unbounded;         use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

package imagePROCESS is
   --array of pixels in the image set to the maximum size of the image (500 px by 500 px)
   type pixelMatrix is array(1..500,1..500) of integer;
   
   --record containing the information found in a pgm image file
   type image is
      record
         pixel               : pixelMatrix;
         dx                  : integer;
         dy                  : integer;
         pNum                : unbounded_string;
         fileName            : unbounded_string;
      end record;
   
   type histArray is Array(1..256) of integer;

   --all functions used in imageprocess.adb package
   function imageINV(img     : in image) return image; 
      
   function imageLOG(img     : in image) return image;
         
   function imageSTRETCH(img : in image) return image;
   
   function makeHIST(img     : in image) return histArray;
   
   function histEQUAL(img    : in image) return image; 

end imagePROCESS;
