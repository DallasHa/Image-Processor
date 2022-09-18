with ada.strings.unbounded;         use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with imagePROCESS;                  use imagePROCESS;

package imagePGM is

   function readPGM(fnameIn : in Unbounded_String) return image;
      
   procedure writePGM(img   : in image);

end imagePGM;
