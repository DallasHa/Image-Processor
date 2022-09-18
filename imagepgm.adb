with Ada.Text_IO;                   use Ada.Text_IO;
with ada.directories;               use ada.directories;
with ada.Integer_Text_IO;           use Ada.Integer_Text_IO;
with Gnat.OS_Lib;                   use Gnat.OS_Lib;
package body imagePGM is
   
   infp : file_type;
   
   --function which takes a file name and returns a record populated with an images information
   function readPGM(fnameIn: in Unbounded_String) return image is
      pgmRecord : image;
      greyscaleNum : Integer;
      
   begin
      open(infp,in_file,to_string(fnameIn));
      get_line(infp,pgmRecord.pNum);
      get(infp,pgmRecord.dx);
      get(infp,pgmRecord.dy);
      get(infp, greyscaleNum);
      
      --handle incorrect file formats
      if not(pgmRecord.pNum = "P2")then
         Put_Line("File continas incorrect magic number - Exiting without saving");
         GNAT.OS_Lib.OS_Exit (0);
      end if;
      
      if ((pgmRecord.dx < 1) or (pgmRecord.dx > 500) or (pgmRecord.dy < 1) or (pgmRecord.dy > 500))then
         Put_Line("Improper image dimension - Exiting without saving");
         GNAT.OS_Lib.OS_Exit (0);
      end if;
      
      if not(greyscaleNum = 255)then
         Put_Line("Incorrect greyscale identifier - Expected 255 - Exiting without saving");
         GNAT.OS_Lib.OS_Exit (0);
      end if;
      
      --Populate pgmRecord pixel array with the pixels from the input file
      for i in 1..pgmRecord.dx loop
         for j in 1..pgmRecord.dy loop
            get(infp,pgmRecord.pixel(i,j));
         end loop;
      end loop;
      
      close(infp);

   return pgmRecord;
      
   --Handle all possible excptions
   exception
      when Error: Data_Error => 
         Put_Line("The data in the file was formatted incorrectly. Please user proper PGM files.");
         GNAT.OS_Lib.OS_Exit (0);
      when others =>
         Put_Line("The data in the file was formatted incorrectly. Please user proper PGM files.");
         GNAT.OS_Lib.OS_Exit (0);
   end;
  
   
   --function which takes a record of an image and writes it to a file
   procedure writePGM(img: in image) is
      
      outfp: file_type;
      count : Integer  := 0;
      pString : string := "P2";
      pgmMax : Integer := 255;
      fname : unbounded_string;
      
   begin
      
      --create the file for the new image record
      create(outfp,out_file,to_string(img.fileName));

      --populate the new image file with the record
      set_output(outfp);
      put(pString); new_line;
      put(img.dx,width=>0);
      put(" ");
      put(img.dy,width=>0); new_line;
      put(pgmMax, width=>0); new_line;
      
      for i in 1..img.dx loop
         for j in 1..img.dy loop
            put(img.pixel(i,j),width=>4);
            count      := count+1;
            if count = img.dx then
               count   := 0;
               New_Line;
            end if;
         end loop;
      end loop;
      
      set_output(standard_output);
      close(outfp);
      
      --Handle all possible excptions
      exception
        when Error: Data_Error => 
            Put_Line("Error writing record to file.");
            GNAT.OS_Lib.OS_Exit (0);
        when others =>
            Put_Line("Error writing record to file");
            GNAT.OS_Lib.OS_Exit (0);
      
   end;

end imagePGM;
