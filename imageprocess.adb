with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Text_IO;                   use Ada.Text_IO;
with Gnat.OS_Lib;                   use Gnat.OS_Lib;

package body imagePROCESS is
   
 --function which takes a record of an image and returns an invert image record
 function imageINV(img: in image) return image is

   InvertedImg : image;
      
 begin
      
   InvertedImg.dx := img.dx;
   InvertedImg.dy := img.dy;
      
   --preform inversion formula on all pixels in an image   
   for i in 1..img.dx loop
      for j in 1..img.dy loop
         InvertedImg.pixel(i,j) := abs (255 - (img.pixel(i,j)));
      end loop;
   end loop;

 return InvertedImg;
      
end;
  
   
--function which takes an image record and returns a logarithmic transformation of that image
function imageLOG(img: in image) return image is

   logImage : image;
   sum: float;
      
 begin
      
   logImage.dx := img.dx;
   logImage.dy := img.dy;
      
   --preform logarithmic transformation function all pixels in an image   
   for i in 1..img.dx loop
      for j in 1..img.dy loop
            sum := (Ada.Numerics.Elementary_Functions.Log(Float(img.pixel(i,j))) *
                    (255.0 / (Ada.Numerics.Elementary_Functions.Log(Float(255)))));
            logImage.pixel(i,j) := Integer(sum);
      end loop;
   end loop;

 return logImage;
 end;
   
     
--function which takes an image record and returns that image with a stretched contrast   
function imageSTRETCH(img: in image) return image is

   stretchImg : image;
   iMin : integer := 256;
   iMax : integer := -1;
   userSelection : character;

begin
      
   stretchImg.dx := img.dx;
   stretchImg.dy := img.dy;
   
   Put_Line("Press [1] to have minimum and maximum intensity values calculated automatically");
   Put_Line("Press [2] to manually enter minimum and maximum intensity values in image");
   get(userSelection);
   Skip_Line;
   
   if userSelection = '1' then
            
      --Calculate min and max pixel values in the image
      for k in 1..img.dx loop
         for m in 1..img.dy loop
            if img.pixel(k,m) > iMax then
                  iMax := img.pixel(k,m);
            end if;
            if img.pixel(k,m) < iMin then
               iMin := img.pixel(k,m);
            end if;
         end loop;
      end loop;
   
         
   elsif userSelection = '2' then
      
      --Get the min and max pixel values from the user   
      Put_Line("Enter minimum intensity value present in the image:");
      iMin := Integer'Value(Get_Line);
         
      Put_Line("Enter maximum intensity value present in the image:");
      iMax := Integer'Value(Get_Line);
         
      if ((iMin < 0) or (iMin > 255) or (iMax < 0) or (iMax > 255) or (iMax < iMin))then
      Put_Line("Invalid min / max intensity - Exiting without saving");
      GNAT.OS_Lib.OS_Exit (0);
      end if;
         
   else 
       
       Put_Line("Invalid selection - Exiting without saving");
       GNAT.OS_Lib.OS_Exit (0);
         
   end if;  
         
   --preform stretched contrast function on all pixels in the image  
   for i in 1..img.dx loop
      for j in 1..img.dy loop
         stretchImg.pixel(i,j) := Integer(255.0 * (Float(Float(img.pixel(i,j) - iMin)) / Float(iMax - iMin)));
      end loop;
   end loop;

  return stretchImg;
 end;
   
       
   --function which returns an array with a histogram of an image
   function makeHIST(img : in image) return histArray is
   
   histArray1 : histArray;
   
   begin
   
      for n in 1..256 loop
         histArray1(n) := 0;
      end loop; 
          
      for m in 1..256 loop
         for i in 1..img.dx loop
            for j in 1..img.dy loop
               if img.pixel(i,j) = m then
                  histArray1(m) := histArray1(m) + 1;
               end if;
            end loop;
         end loop;
      end loop; 
      
   return histArray1;
   end;
      
   
    --functions which converts image record to an equalized histogram 
    function histEQUAL(img: in image) return image is

      equalImage : image;
      type histArray is Array(1..256) of integer;
      type CHIntArray is Array(1..256) of integer;
      type cumuHistArray is Array(1..256) of Float;
      type PDFArray is Array(1..256) of Float;
      
      cumuHistArray1 : cumuHistArray;
      histArray1 : histArray;
      PDFArray1 : PDFArray; 
      CHIntArray1 : CHIntArray;
      totalPixels : integer;      
      
   begin
      
      equalImage.dx := img.dx;
      equalImage.dy := img.dy;
      
      --calculate the total number of pixels in the image
      totalPixels := equalImage.dx * equalImage.dy;
      
      --create a histogram distribution array
      for n in 1..256 loop
         histArray1(n) := 0;
         cumuHistArray1(n) := 0.0;
         PDFArray1(n) := 0.0;
         CHIntArray1(n) := 0;
      end loop;       
      
      for m in 1..256 loop
         for i in 1..img.dx loop
            for j in 1..img.dy loop
               if img.pixel(i,j) = m then
                  histArray1(m) := histArray1(m) + 1;
               end if;
            end loop;
         end loop;
      end loop; 
         
      --Populate Probability Density Arr
      for m in 1..256 loop
         PDFArray1(m) := (Float(histArray1(m))) / (Float(totalPixels));
      end loop;
           
      --Calculate Cumulative Histogram
      cumuHistArray1(1) := PDFArray1(1);
      for m in 2..256 loop
         cumuHistArray1(m) := PDFArray1(m) + cumuHistArray1(m-1);
      end loop;
      
      --multiply the CH by 255 and round, forming a new integer array
      for m in 1..256 loop
         CHIntArray1(m) := Integer(cumuHistArray1(m) * 255.0);
      end loop;
   
      --map the new greyscale values to a histogram record
      for i in 1..img.dx loop
         for j in 1..img.dy loop       
            equalImage.pixel(i,j) := CHIntArray1(img.pixel(i,j));           
         end loop;
      end loop;        
      
      return equalImage; 
    end;

end imagePROCESS;
