--Program which preforms image processing on greyscale images
--Written by Dallas Haymes
--CIS*3190
--dhaymes@uougelph.ca

with Ada.Text_IO;                   use Ada.Text_IO;
with ada.directories;               use ada.directories;
with ada.strings.unbounded;         use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with imagePROCESS;                  use imagePROCESS;
with imagePGM;                      use imagePGM;
with Gnat.OS_Lib;                   use Gnat.OS_Lib;
with Ada.Exceptions;                use Ada.Exceptions;

--main program wrapper
procedure main is

   inputFname : unbounded_string;
   outputFname : unbounded_string;
   img : image;
   processedImg :imageprocess.image;
   userSelection : character;

   -- function which gets and validates file name
   function getFilename(RWIndicator: in String) return Unbounded_String is

      inputFname : unbounded_string;
      outputFname : unbounded_string;
      ans: character;
      outfp: file_type;

   begin

      -- hanldle file writing
      if RWindicator = "W" then

         Put_Line ("Enter file name to write:  ");
         get_line(outputFname);

         if exists(to_string(outputFname)) then
            put_line("File exists - overwrite (Y/N)? ");
            get(ans);

            if ans = 'Y' then
               return outputFname;
            else
               put_line("Exiting - image not saved");
               GNAT.OS_Lib.OS_Exit (0);
            end if;

         end if;

         return outputFname;

      end if;

      --handle file reading
      if RWindicator = "R" then
         Put_Line ("Enter file name to read:  ");
         get_line(inputFname);

         if not exists(to_string(inputFname)) then
            put_line("File does not exist: exiting - image not saved");
            GNAT.OS_Lib.OS_Exit (0);
         end if;

      end if;

   return inputFname;

   end;


--main program wrapper
begin

   --Prompt user for input and output file names, and read the image into a record
   inputFname := getFilename("R");
   img := readPGM(inputFname);
   outputFname := getFilename("W");


   --I/O user interaction for file name and image processing method
   Put_Line("In which way would you like the image processed?");
   Put_Line("Press [1] for an image inversion");
   Put_Line("Press [2] for a logarithmic transformation");
   Put_Line("Press [3] for a contrast stretching");
   Put_Line("Press [4] for a histogram equalization");

   get(userSelection);
   Skip_Line;

   --call the appropriate image processing function, based on the user input
   if userSelection = '1' then
      processedImg := imageINV(img);
      processedImg.fileName := outputFname;
      writePGM(processedImg);
      Put_Line("Image inversion successful");

   elsif userSelection = '2' then
      processedImg := imageLOG(img);
      processedImg.fileName := outputFname;
      writePGM(processedImg);
      Put_Line("Logarithmic transformation successful");

   elsif userSelection = '3' then
      processedImg := imageSTRETCH(img);
      processedImg.fileName := outputFname;
      writePGM(processedImg);
      Put_Line("Contrast stretching successful");

   elsif userSelection = '4' then
      processedImg := histEQUAL(img);
      processedImg.fileName := outputFname;
      writePGM(processedImg);
      Put_Line("Histogram equalization successful");

   else
      Put_Line("You did not enter a correct selection number. (1, 2, or 3). Exiting without saving");
      GNAT.OS_Lib.OS_Exit (0);

   end if;

   --hadle exceptions raised when processing images
   exception
      when Error: Data_Error =>
          Put_Line("Data error. Unable to process image correctly.");
          GNAT.OS_Lib.OS_Exit (0);
      when Error: others =>
          Put ("Unexpected exception: ");
          Put_Line (Exception_Information(Error));
          GNAT.OS_Lib.OS_Exit (0);

end main;
