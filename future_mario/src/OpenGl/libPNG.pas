unit libPNG;
{
  PngLib.Pas

  Conversion from C header file to Pascal Unit by Edmund H. Hand in
  April of 1998.
  For conditions of distribution and use, see the COPYRIGHT NOTICE from the
  orginal C Header file below.

  This unit is intended for use with LPng.DLL.  LPng.DLL was compiled with
  Microsoft Visual C++ 5.0 and is comprised of the standard PNG library
  version 1.0.1.  LPng.DLL uses ZLib 1.1.2 internally for compression and
  decompression.  The ZLib functions are also exported in the DLL, but they
  have not yet been defined here.

  The primary word of warning I must offer is that most of the function
  pointers for callback functions have merely been declared as the pascal
  Pointer type. I have only defined one procedure type for read and write
  callback functions.  So if you plan to use other callback types, check the
  included header file for the function definition.

  The header comments of the original C Header file follow.

 * png.h - header file for PNG reference library
 *
 * libpng 1.0.1
 * For conditions of distribution and use, see the COPYRIGHT NOTICE below.
 * Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.
 * Copyright (c) 1996, 1997 Andreas Dilger
 * Copyright (c) 1998 Glenn Randers-Pehrson
 * March 15, 1998
 *
 * Note about libpng version numbers:
 *
 *    Due to various miscommunications, unforeseen code incompatibilities
 *    and occasional factors outside the authors' control, version numbering
 *    on the library has not always been consistent and straightforward.
 *    The following table summarizes matters since version 0.89c, which was
 *    the first widely used release:
 *
 *      source                    png.h   png.h   shared-lib
 *      version                   string    int   version
 *      -------                   ------  ------  ----------
 *      0.89c ("1.0 beta 3")      0.89        89  1.0.89
 *      0.90  ("1.0 beta 4")      0.90        90  0.90  [should have been 2.0.90]
 *      0.95  ("1.0 beta 5")      0.95        95  0.95  [should have been 2.0.95]
 *      0.96  ("1.0 beta 6")      0.96        96  0.96  [should have been 2.0.96]
 *      0.97b ("1.00.97 beta 7")  1.00.97     97  1.0.1 [should have been 2.0.97]
 *      0.97c                     0.97        97  2.0.97
 *      0.98                      0.98        98  2.0.98
 *      0.99                      0.99        98  2.0.99
 *      0.99a-m                   0.99        99  2.0.99
 *      1.00                      1.00       100  2.1.0 [int should be 10000]
 *      1.0.0                     1.0.0      100  2.1.0 [int should be 10000]
 *      1.0.1                     1.0.1    10001  2.1.0
 *
 *    Henceforth the source version will match the shared-library minor
 *    and patch numbers; the shared-library major version number will be
 *    used for changes in backward compatibility, as it is intended.
 *    The PNG_PNGLIB_VER macro, which is not used within libpng but
 *    is available for applications, is an unsigned integer of the form
 *    xyyzz corresponding to the source version x.y.z (leading zeros in y and z).
 *    
 *
 * See libpng.txt for more information.  The PNG specification is available
 * as RFC 2083 <ftp://ftp.uu.net/graphics/png/documents/>
 * and as a W3C Recommendation <http://www.w3.org/TR/REC.png.html>
 *
 * Contributing Authors:
 *    John Bowler
 *    Kevin Bracey
 *    Sam Bushell
 *    Andreas Dilger
 *    Magnus Holmgren
 *    Tom Lane
 *    Dave Martindale
 *    Glenn Randers-Pehrson
 *    Greg Roelofs
 *    Guy Eric Schalnat
 *    Paul Schmidt
 *    Tom Tanner
 *    Willem van Schaik
 *    Tim Wegner
 *
 * The contributing authors would like to thank all those who helped
 * with testing, bug fixes, and patience.  This wouldn't have been
 * possible without all of you.
 *
 * Thanks to Frank J. T. Wojcik for helping with the documentation.
 *
 * COPYRIGHT NOTICE:
 *
 * The PNG Reference Library is supplied "AS IS".  The Contributing Authors
 * and Group 42, Inc. disclaim all warranties, expressed or implied,
 * including, without limitation, the warranties of merchantability and of
 * fitness for any purpose.  The Contributing Authors and Group 42, Inc.
 * assume no liability for direct, indirect, incidental, special, exemplary,
 * or consequential damages, which may result from the use of the PNG
 * Reference Library, even if advised of the possibility of such damage.
 *
 * Permission is hereby granted to use, copy, modify, and distribute this
 * source code, or portions hereof, for any purpose, without fee, subject
 * to the following restrictions:
 * 1. The origin of this source code must not be misrepresented.
 * 2. Altered versions must be plainly marked as such and must not be
 *    misrepresented as being the original source.
 * 3. This Copyright notice may not be removed or altered from any source or
 *    altered source distribution.
 *
 * The Contributing Authors and Group 42, Inc. specifically permit, without
 * fee, and encourage the use of this source code as a component to
 * supporting the PNG file format in commercial products.  If you use this
 * source code in a product, acknowledgment is not required but would be
 * appreciated.
 *}
interface

uses Windows, SysUtils;

type PPByte     = ^PByte;
type PPChar     = ^PChar;
type PWord      = ^Word;
type PPWord     = ^PWord;
type PDouble    = ^Double;
type PSmallint  = ^Smallint;
type PCardinal  = ^Cardinal;
type PPCardinal = ^PCardinal;
type PInteger   = ^Integer;
type PPInteger  = ^PInteger;

//const Lib = 'libpng.dll';

// Version information for png.h - this should match the version in png.c
const PNG_LIBPNG_VER_STRING =  '1.0.1';
const PNG_LIBPNG_VER        =  '10001';  // 1.0.1

// Supported compression types for text in PNG files (tEXt, and zTXt).
// The values of the PNG_TEXT_COMPRESSION_ defines should NOT be changed.
const PNG_TEXT_COMPRESSION_NONE_WR: Integer = -3;
const PNG_TEXT_COMPRESSION_zTXt_WR: Integer = -2;
const PNG_TEXT_COMPRESSION_NONE:    Integer = -1;
const PNG_TEXT_COMPRESSION_zTXt:    Integer = 0;
const PNG_TEXT_COMPRESSION_LAST:    Integer = 1;  // Not a valid value

// These describe the color_type field in png_info.
// color type masks
const PNG_COLOR_MASK_PALETTE: Integer = 1;
const PNG_COLOR_MASK_COLOR:   Integer = 2;
const PNG_COLOR_MASK_ALPHA:   Integer = 4;

// color types.  Note that not all combinations are legal
const PNG_COLOR_TYPE_GRAY:       Integer = 0;
const PNG_COLOR_TYPE_PALETTE:    Integer = 3;
const PNG_COLOR_TYPE_RGB:        Integer = 2;
const PNG_COLOR_TYPE_RGB_ALPHA:  Integer = 6;
const PNG_COLOR_TYPE_GRAY_ALPHA: Integer = 4;

// This is for compression type. PNG 1.0 only defines the single type.
const PNG_COMPRESSION_TYPE_BASE:    Integer = 0; // Deflate method 8, 32K window
const PNG_COMPRESSION_TYPE_DEFAULT: Integer = 0;

// This is for filter type. PNG 1.0 only defines the single type.
const PNG_FILTER_TYPE_BASE:    Integer = 0; // Single row per-byte filtering
const PNG_FILTER_TYPE_DEFAULT: Integer = 0;

// These are for the interlacing type.  These values should NOT be changed.
const PNG_INTERLACE_NONE:  Integer = 0; // Non-interlaced image
const PNG_INTERLACE_ADAM7: Integer = 1; // Adam7 interlacing
const PNG_INTERLACE_LAST:  Integer = 2; // Not a valid value

// These are for the oFFs chunk.  These values should NOT be changed.
const PNG_OFFSET_PIXEL:      Integer = 0; // Offset in pixels
const PNG_OFFSET_MICROMETER: Integer = 1; // Offset in micrometers (1/10^6 meter)
const PNG_OFFSET_LAST:       Integer = 2; // Not a valid value

// These are for the pCAL chunk.  These values should NOT be changed.
const PNG_EQUATION_LINEAR:     Integer = 0; // Linear transformation
const PNG_EQUATION_BASE_E:     Integer = 1; // Exponential base e transform
const PNG_EQUATION_ARBITRARY:  Integer = 2; // Arbitrary base exponential transform
const PNG_EQUATION_HYPERBOLIC: Integer = 3; // Hyperbolic sine transformation
const PNG_EQUATION_LAST:       Integer = 4; // Not a valid value

// These are for the pHYs chunk.  These values should NOT be changed.
const PNG_RESOLUTION_UNKNOWN: Integer = 0; // pixels/unknown unit (aspect ratio)
const PNG_RESOLUTION_METER:   Integer = 1; // pixels/meter
const PNG_RESOLUTION_LAST:    Integer = 2; // Not a valid value

// These are for the sRGB chunk.  These values should NOT be changed.
const PNG_sRGB_INTENT_SATURATION: Integer = 0;
const PNG_sRGB_INTENT_PERCEPTUAL: Integer = 1;
const PNG_sRGB_INTENT_ABSOLUTE:   Integer = 2;
const PNG_sRGB_INTENT_RELATIVE:   Integer = 3;
const PNG_sRGB_INTENT_LAST:       Integer = 4; // Not a valid value

{* These determine if an ancillary chunk's data has been successfully read
 * from the PNG header, or if the application has filled in the corresponding
 * data in the info_struct to be written into the output file.  The values
 * of the PNG_INFO_<chunk> defines should NOT be changed.
 *}
const PNG_INFO_gAMA: Cardinal = $0001;
const PNG_INFO_sBIT: Cardinal = $0002;
const PNG_INFO_cHRM: Cardinal = $0004;
const PNG_INFO_PLTE: Cardinal = $0008;
const PNG_INFO_tRNS: Cardinal = $0010;
const PNG_INFO_bKGD: Cardinal = $0020;
const PNG_INFO_hIST: Cardinal = $0040;
const PNG_INFO_pHYs: Cardinal = $0080;
const PNG_INFO_oFFs: Cardinal = $0100;
const PNG_INFO_tIME: Cardinal = $0200;
const PNG_INFO_pCAL: Cardinal = $0400;
const PNG_INFO_sRGB: Cardinal = $0800;   // GR-P, 0.96a

{* The values of the PNG_FILLER_ defines should NOT be changed *}
const PNG_FILLER_BEFORE: Integer = 0;
const PNG_FILLER_AFTER: Integer = 1;

{* Three color definitions.  The order of the red, green, and blue, (and the
 * exact size) is not important, although the size of the fields need to
 * be png_byte or png_uint_16 (as defined below).
 *}
type TPng_Color = record
  red:   Byte;
  green: Byte;
  blue:  Byte;
end;
type PPng_Color  = ^TPng_Color;
type PPPng_Color = ^PPng_Color;

type TPng_Color_16 = record
  index: Byte;     // Used for palette files
  red:   Word;     // For use in reg, green, blue files
  green: Word;
  blue:  Word;
  gray:  Word;     // For use in grayscale files
end;
type PPng_Color_16  = ^TPng_Color_16;
type PPPng_Color_16 = ^PPng_Color_16;

type TPng_Color_8 = record
   red:   Byte;    // for use in red green blue files
   green: Byte;
   blue:  Byte;
   gray:  Byte;    // for use in grayscale files
   alpha: Byte;    // for alpha channel files
end;
type PPng_Color_8  = ^TPng_Color_8;
type PPPng_Color_8 = ^PPng_Color_8;

{* png_text holds the text in a PNG file, and whether they are compressed
 * in the PNG file or not.  The "text" field points to a regular C string.
 *}
type TPng_Text = record
   compression: Integer;   // compression value, see PNG_TEXT_COMPRESSION_
   key:         PChar;     // keyword, 1-79 character description of "text"
   text:        PChar;     // comment, may be an empty string (ie "")
   text_length: Integer;   // length of "text" field
end;
type PPng_Text  = ^TPng_Text;
type PPPng_Text = ^PPng_Text;
type TPng_Text_Array = array[0..65535] of TPng_Text;
type PPng_Text_Array = ^TPng_Text_Array;

{* png_time is a way to hold the time in an machine independent way.
 * Two conversions are provided, both from time_t and struct tm.  There
 * is no portable way to convert to either of these structures, as far
 * as I know.  If you know of a portable way, send it to me.  As a side
 * note - PNG is Year 2000 compliant!
 *}
type TPng_Time = record
   year:   Word; // full year, as in, 1995
   month:  Byte; // month of year, 1 - 12
   day:    Byte; // day of month, 1 - 31
   hour:   Byte; // hour of day, 0 - 23
   minute: Byte; // minute of hour, 0 - 59
   second: Byte; // second of minute, 0 - 60 (for leap seconds)
end;
type PPng_Time  = ^TPng_Time;
type PPPng_Time = ^PPng_Time;

type TM = record            // Standard C time structure
  tm_sec: Integer;     // seconds after the minute - [0,59]
  tm_min: Integer;     // minutes after the hour - [0,59]
  tm_hour: Integer;    // hours since midnight - [0,23]
  tm_mday: Integer;    // day of the month - [1,31]
  tm_mon: Integer;     // months since January - [0,11]
  tm_year: Integer;    // years since 1900
  tm_wday: Integer;    // days since Sunday - [0,6]
  tm_yday: Integer;    // days since January 1 - [0,365]
  tm_isdst: Integer;   // daylight savings time flag
end;
type PTM = ^TM;

{ png_info is a structure that holds the information in a PNG file so
 * that the application can find out the characteristics of the image.
 * If you are reading the file, this structure will tell you what is
 * in the PNG file.  If you are writing the file, fill in the information
 * you want to put into the PNG file, then call png_write_info().
 * The names chosen should be very close to the PNG specification, so
 * consult that document for information about the meaning of each field.
 *
 * With libpng < 0.95, it was only possible to directly set and read the
 * the values in the png_info_struct, which meant that the contents and
 * order of the values had to remain fixed.  With libpng 0.95 and later,
 * however, * there are now functions which abstract the contents of
 * png_info_struct from the application, so this makes it easier to use
 * libpng with dynamic libraries, and even makes it possible to use
 * libraries that don't have all of the libpng ancillary chunk-handing
 * functionality.
 *
 * In any case, the order of the parameters in png_info_struct should NOT
 * be changed for as long as possible to keep compatibility with applications
 * that use the old direct-access method with png_info_struct.
 *}
type TPng_Info = record
   //the following are necessary for every PNG file
   width:            Cardinal;  // width of image in pixels (from IHDR)
   height:           Cardinal;  // height of image in pixels (from IHDR)
   valid:            Cardinal;  // valid chunk data (see PNG_INFO_ below)
   rowbytes:         Cardinal;  // bytes needed to hold an untransformed row
   palette:          PPng_Color;// array of color values (valid & PNG_INFO_PLTE)
   num_palette:      Word;      // number of color entries in "palette" (PLTE)
   num_trans:        Word;      // number of transparent palette color (tRNS)
   bit_depth:        Byte;      // 1, 2, 4, 8, or 16 bits/channel (from IHDR)
   color_type:       Byte;      // see PNG_COLOR_TYPE_ below (from IHDR)
   compression_type: Byte;      // must be PNG_COMPRESSION_TYPE_BASE (IHDR)
   filter_type:      Byte;      // must be PNG_FILTER_TYPE_BASE (from IHDR)
   interlace_type:   Byte;      // One of PNG_INTERLACE_NONE,PNG_INTERLACE_ADAM7

   // The following is informational only on read, and not used on writes.
   channels:     Byte;    // number of data channels per pixel (1, 3, 4)
   pixel_depth:  Byte;    // number of bits per pixel
   spare_byte:   Byte;    // to align the data, and for future use
   signature: array[0..7] of Byte;// magic bytes read by libpng from start of file

   {* The rest of the data is optional.  If you are reading, check the
    * valid field to see if the information in these are valid.  If you
    * are writing, set the valid field to those chunks you want written,
    * and initialize the appropriate fields below.
    *}

   {* The gAMA chunk describes the gamma characteristics of the system
    * on which the image was created, normally in the range [1.0, 2.5].
    * Data is valid if (valid & PNG_INFO_gAMA) is non-zero.
    *}
   gamma: Single;  // gamma value of image, if (valid & PNG_INFO_gAMA)

    // GR-P, 0.96a
    // Data valid if (valid & PNG_INFO_sRGB) non-zero.
   srgb_intent: Byte;       // sRGB rendering intent [0, 1, 2, or 3]

   {* The tEXt and zTXt chunks contain human-readable textual data in
    * uncompressed and compressed forms, respectively.  The data in "text"
    * is an array of pointers to uncompressed, null-terminated C strings.
    * Each chunk has a keyword which describes the textual data contained
    * in that chunk.  Keywords are not required to be unique, and the text
    * string may be empty.  Any number of text chunks may be in an image.
    *}
   num_text: Integer;   // number of comments read/to write
   max_text: Integer;   // current size of text array
   text:     PPng_Text; // array of comments read/to write

   {* The tIME chunk holds the last time the displayed image data was
    * modified.  See the png_time struct for the contents of this struct.
    *}
   mod_time: TPng_Time;

   {* The sBIT chunk specifies the number of significant high-order bits
    * in the pixel data.  Values are in the range [1, bit_depth], and are
    * only specified for the channels in the pixel data.  The contents of
    * the low-order bits is not specified.  Data is valid if
    * (valid & PNG_INFO_sBIT) is non-zero.
    *}
   sig_bit: TPng_Color_8;  // significant bits in color channels

   {* The tRNS chunk supplies transparency data for paletted images and
    * other image types that don't need a full alpha channel.  There are
    * "num_trans" transparency values for a paletted image, stored in the
    * same order as the palette colors, starting from index 0.  Values
    * for the data are in the range [0, 255], ranging from fully transparent
    * to fully opaque, respectively.  For non-paletted images, there is a
    * single color specified which should be treated as fully transparent.
    * Data is valid if (valid & PNG_INFO_tRNS) is non-zero.
    *}
   trans: PByte; // transparent values for paletted image
   trans_values: TPng_Color_16; // transparent color for non-palette image

   {* The bKGD chunk gives the suggested image background color if the
    * display program does not have its own background color and the image
    * is needs to composited onto a background before display.  The colors
    * in "background" are normally in the same color space/depth as the
    * pixel data.  Data is valid if (valid & PNG_INFO_bKGD) is non-zero.
    *}
   background: TPng_Color_16;

   {* The oFFs chunk gives the offset in "offset_unit_type" units rightwards
    * and downwards from the top-left corner of the display, page, or other
    * application-specific co-ordinate space.  See the PNG_OFFSET_ defines
    * below for the unit types.  Valid if (valid & PNG_INFO_oFFs) non-zero.
    *}
   x_offset:         Cardinal; // x offset on page
   y_offset:         Cardinal; // y offset on page
   offset_unit_type: Byte;     // offset units type

   {* The pHYs chunk gives the physical pixel density of the image for
    * display or printing in "phys_unit_type" units (see PNG_RESOLUTION_
    * defines below).  Data is valid if (valid & PNG_INFO_pHYs) is non-zero.
    *}
   x_pixels_per_unit: Cardinal;  // horizontal pixel density
   y_pixels_per_unit: Cardinal;  // vertical pixel density
   phys_unit_type:    Byte;      // resolution type (see PNG_RESOLUTION_ below)

   {* The hIST chunk contains the relative frequency or importance of the
    * various palette entries, so that a viewer can intelligently select a
    * reduced-color palette, if required.  Data is an array of "num_palette"
    * values in the range [0,65535]. Data valid if (valid & PNG_INFO_hIST)
    * is non-zero.
    *}
   hist: PWord;

   {* The cHRM chunk describes the CIE color characteristics of the monitor
    * on which the PNG was created.  This data allows the viewer to do gamut
    * mapping of the input image to ensure that the viewer sees the same
    * colors in the image as the creator.  Values are in the range
    * [0.0, 0.8].  Data valid if (valid & PNG_INFO_cHRM) non-zero.
    *}
   x_white: Single;
   y_white: Single;
   x_red:   Single;
   y_red:   Single;
   x_green: Single;
   y_green: Single;
   x_blue:  Single;
   y_blue:  Single;

   {* The pCAL chunk describes a transformation between the stored pixel
    * values and original physcical data values used to create the image.
    * The integer range [0, 2^bit_depth - 1] maps to the floating-point
    * range given by [pcal_X0, pcal_X1], and are further transformed by a
    * (possibly non-linear) transformation function given by "pcal_type"
    * and "pcal_params" into "pcal_units".  Please see the PNG_EQUATION_
    * defines below, and the PNG-Group's Scientific Visualization extension
    * chunks document png-scivis-19970203 for a complete description of the
    * transformations and how they should be implemented, as well as the
    * png-extensions document for a description of the ASCII parameter
    * strings.  Data values are valid if (valid & PNG_INFO_pCAL) non-zero.
    *}
   pcal_purpose: PChar;     // pCAL chunk description string
   pcal_X0:      Integer;   // minimum value
   pcal_X1:      Integer;   // maximum value
   pcal_units:   PChar;     // Latin-1 string giving physical units
   pcal_params:  PPChar;    // ASCII strings containing parameter values
   pcal_type:    Byte;      // equation type (see PNG_EQUATION_ below)
   pcal_nparams: Byte;      // number of parameters given in pcal_params
end;
type PPng_Info = ^TPng_Info;
type PPPng_Info = ^PPng_Info;

{* This is used for the transformation routines, as some of them
 * change these values for the row.  It also should enable using
 * the routines for other purposes.
 *}
type TPng_Row_Info = record
   width:       Cardinal; // width of row
   rowbytes:    Cardinal; // number of bytes in row
   color_type:  Byte;     // color type of row
   bit_depth:   Byte;     // bit depth of row
   channels:    Byte;     // number of channels (1, 2, 3, or 4)
   pixel_depth: Byte;     // bits per pixel (depth * channels)
end;
type PPng_Row_Info = ^TPng_Row_Info;
type PPPng_Row_Info = ^PPng_Row_Info;

{* The structure that holds the information to read and write PNG files.
 * The only people who need to care about what is inside of this are the
 * people who will be modifying the library for their own special needs.
 * It should NOT be accessed directly by an application, except to store
 * the jmp_buf.
 *}
type TPng_Struct = record
   jmpbuf: array[0..10] of Integer; // used in png_error
   error_fn: Pointer;    // function for printing errors and aborting
   warning_fn: Pointer;  // function for printing warnings
   error_ptr: Pointer;       // user supplied struct for error functions
   write_data_fn: Pointer;  // function for writing output data
   read_data_fn: Pointer;   // function for reading input data
   read_user_transform_fn: Pointer; // user read transform
   write_user_transform_fn: Pointer; // user write transform
   io_ptr: Integer;         // ptr to application struct for I/O functions

   mode: Cardinal;          // tells us where we are in the PNG file
   flags: Cardinal;         // flags indicating various things to libpng
   transformations: Cardinal; // which transformations to perform

   zstream: Pointer;        // pointer to decompression structure (below)
   zbuf: PByte;             // buffer for zlib
   zbuf_size: Integer;      // size of zbuf
   zlib_level: Integer;     // holds zlib compression level
   zlib_method: Integer;    // holds zlib compression method
   zlib_window_bits: Integer; // holds zlib compression window bits
   zlib_mem_level: Integer; // holds zlib compression memory level
   zlib_strategy: Integer;  // holds zlib compression strategy

   width: Cardinal;         // width of image in pixels
   height: Cardinal;        // height of image in pixels
   num_rows: Cardinal;      // number of rows in current pass
   usr_width: Cardinal;     // width of row at start of write
   rowbytes: Cardinal;      // size of row in bytes
   irowbytes: Cardinal;     // size of current interlaced row in bytes
   iwidth: Cardinal;        // width of current interlaced row in pixels
   row_number: Cardinal;    // current row in interlace pass
   prev_row: PByte;         // buffer to save previous (unfiltered) row
   row_buf: PByte;          // buffer to save current (unfiltered) row
   sub_row: PByte;          // buffer to save "sub" row when filtering
   up_row: PByte;           // buffer to save "up" row when filtering
   avg_row: PByte;          // buffer to save "avg" row when filtering
   paeth_row: PByte;        // buffer to save "Paeth" row when filtering
   row_info: TPng_Row_Info; // used for transformation routines

   idat_size: Cardinal;     // current IDAT size for read
   crc: Cardinal;           // current chunk CRC value
   palette: PPng_Color;     // palette from the input file
   num_palette: Word;       // number of color entries in palette
   num_trans: Word;         // number of transparency values
   chunk_name: array[0..4] of Byte;   // null-terminated name of current chunk
   compression: Byte;      // file compression type (always 0)
   filter: Byte;           // file filter type (always 0)
   interlaced: Byte;       // PNG_INTERLACE_NONE, PNG_INTERLACE_ADAM7
   pass: Byte;             // current interlace pass (0 - 6)
   do_filter: Byte;        // row filter flags (see PNG_FILTER_ below )
   color_type: Byte;       // color type of file
   bit_depth: Byte;        // bit depth of file
   usr_bit_depth: Byte;    // bit depth of users row
   pixel_depth: Byte;      // number of bits per pixel
   channels: Byte;         // number of channels in file
   usr_channels: Byte;     // channels at start of write
   sig_bytes: Byte;        // magic bytes read/written from start of file

   filler: Byte;                  // filler byte for 24->32-bit pixel expansion
   background_gamma_type: Byte;
   background_gamma: Single;
   background: TPng_Color_16;     // background color in screen gamma space
   background_1: TPng_Color_16;   // background normalized to gamma 1.0
   output_flush_fn: Pointer;      // Function for flushing output
   flush_dist: Cardinal;          // how many rows apart to flush, 0 - no flush
   flush_rows: Cardinal;          // number of rows written since last flush
   gamma_shift: Integer;          // number of "insignificant" bits 16-bit gamma
   gamma: Single;                 // file gamma value
   screen_gamma: Single;          // screen gamma value (display_gamma/viewing_gamma
   gamma_table: PByte;            // gamma table for 8 bit depth files
   gamma_from_1: PByte;           // converts from 1.0 to screen
   gamma_to_1: PByte;             // converts from file to 1.0
   gamma_16_table: PPWord;        // gamma table for 16 bit depth files
   gamma_16_from_1: PPWord;       // converts from 1.0 to screen
   gamma_16_to_1: PPWord;         // converts from file to 1.0
   sig_bit: TPng_Color_8;         // significant bits in each available channel
   shift: TPng_Color_8;           // shift for significant bit tranformation
   trans: PByte;                  // transparency values for paletted files
   trans_values: TPng_Color_16;   // transparency values for non-paletted files
   read_row_fn: Pointer;          // called after each row is decoded
   write_row_fn: Pointer;         // called after each row is encoded
   info_fn: Pointer;              // called after header data fully read
   row_fn: Pointer;               // called after each prog. row is decoded
   end_fn: Pointer;               // called after image is complete
   save_buffer_ptr: PByte;        // current location in save_buffer
   save_buffer: PByte;            // buffer for previously read data
   current_buffer_ptr: PByte;     // current location in current_buffer
   current_buffer: PByte;         // buffer for recently used data
   push_length: Cardinal;         // size of current input chunk
   skip_length: Cardinal;         // bytes to skip in input data
   save_buffer_size: Integer;     // amount of data now in save_buffer
   save_buffer_max: Integer;      // total size of save_buffer
   buffer_size: Integer;          // total amount of available input data
   current_buffer_size: Integer;  // amount of data now in current_buffer
   process_mode: Integer;         // what push library is currently doing
   cur_palette: Integer;          // current push library palette index
   current_text_size: Integer;    // current size of text input data
   current_text_left: Integer;    // how much text left to read in input
   current_text: PByte;           // current text chunk buffer
   current_text_ptr: PByte;       // current location in current_text
   palette_lookup: PByte;         // lookup table for dithering
   dither_index: PByte;           // index translation for palette files
   hist: PWord;                   // histogram
   heuristic_method: Byte;        // heuristic for row filter selection
   num_prev_filters: Byte;        // number of weights for previous rows
   prev_filters: PByte;           // filter type(s) of previous row(s)
   filter_weights: PWord;         // weight(s) for previous line(s)
   inv_filter_weights: PWord;     // 1/weight(s) for previous line(s)
   filter_costs: PWord;           // relative filter calculation cost
   inv_filter_costs: PWord;       // 1/relative filter calculation cost
   time_buffer: PByte;            // String to hold RFC 1123 time text
end;
type PPng_Struct = ^TPng_Struct;
type PPPng_Struct = ^PPng_Struct;

const PNG_BACKGROUND_GAMMA_UNKNOWN: Integer = 0;
const PNG_BACKGROUND_GAMMA_SCREEN:  Integer = 1;
const PNG_BACKGROUND_GAMMA_FILE:    Integer = 2;
const PNG_BACKGROUND_GAMMA_UNIQUE:  Integer = 3;

{* Values for png_set_crc_action() to say how to handle CRC errors in
 * ancillary and critical chunks, and whether to use the data contained
 * therein.  Note that it is impossible to "discard" data in a critical
 * chunk.  For versions prior to 0.90, the action was always error/quit,
 * whereas in version 0.90 and later, the action for CRC errors in ancillary
 * chunks is warn/discard.  These values should NOT be changed.
 *
 *      value                       action:critical     action:ancillary
 *}
const PNG_CRC_DEFAULT:      Integer = 0;  // error/quit         warn/discard data
const PNG_CRC_ERROR_QUIT:   Integer = 1;  // error/quit         error/quit
const PNG_CRC_WARN_DISCARD: Integer = 2;  // (INVALID)          warn/discard data
const PNG_CRC_WARN_USE:     Integer = 3;  // warn/use data      warn/use data
const PNG_CRC_QUIET_USE:    Integer = 4;  // quiet/use data     quiet/use data
const PNG_CRC_NO_CHANGE:    Integer = 5;  // use current value  use current value

{* Flags for png_set_filter() to say which filters to use.  The flags
 * are chosen so that they don't conflict with real filter types
 * below, in case they are supplied instead of the #defined constants.
 * These values should NOT be changed.
 *}
const PNG_NO_FILTERS:   Integer = $00;
const PNG_FILTER_NONE:  Integer = $08;
const PNG_FILTER_SUB:   Integer = $10;
const PNG_FILTER_UP:    Integer = $20;
const PNG_FILTER_AVG:   Integer = $40;
const PNG_FILTER_PAETH: Integer = $80;
const PNG_ALL_FILTERS:  Integer = $F8;

{* Filter values (not flags) - used in pngwrite.c, pngwutil.c for now.
 * These defines should NOT be changed.
 *}
const PNG_FILTER_VALUE_NONE:  Integer = 0;
const PNG_FILTER_VALUE_SUB:   Integer = 1;
const PNG_FILTER_VALUE_UP:    Integer = 2;
const PNG_FILTER_VALUE_AVG:   Integer = 3;
const PNG_FILTER_VALUE_PAETH: Integer = 4;
const PNG_FILTER_VALUE_LAST:  Integer = 5;

{* Heuristic used for row filter selection.  These defines should NOT be
 * changed.
 *}
const PNG_FILTER_HEURISTIC_DEFAULT:    Integer = 0; // Currently "UNWEIGHTED"
const PNG_FILTER_HEURISTIC_UNWEIGHTED: Integer = 1; // Used by libpng < 0.95
const PNG_FILTER_HEURISTIC_WEIGHTED:   Integer = 2; // Experimental feature
const PNG_FILTER_HEURISTIC_LAST:       Integer = 3; // Not a valid value

var 
  pngOpenFile : function(fname : PChar; mode : PChar) : Pointer; stdcall;
  pngCreateReadStruct : function(pngVer : PChar; errorPtr, errorFn, warnFn : Pointer) : PPng_struct; stdcall;
  pngCreateInfoStruct : function(pngPtr : PPng_struct) : PPng_Info; stdcall;
  pngInitIO : procedure(pngPtr: PPng_Struct; fp : Pointer); stdcall;
  pngSetReadStatusFn : procedure(pngPtr : PPng_Struct; readRowFn : Pointer); stdcall;
  pngReadInfo : procedure(pngPtr : PPng_Struct; infoPtr : PPng_Info); stdcall;
  pngGetIHDR : function(pngPtr : PPng_Struct; infoPtr : PPng_Info; 
                        width, height : PCardinal; bitDepth, colorType, 
                        interlaceType, compressionType, filterType : PInteger) : Cardinal; stdcall;
  pngSetSwap : procedure(pngPtr : PPng_Struct); stdcall;
  pngSetExpand : procedure(pngPtr : PPng_Struct); stdcall;
  pngSetPacking : procedure(pngPtr : PPng_Struct); stdcall;
  pngGetValid : function(pngPtr : PPng_Struct; infoPtr : PPng_Info; flag : Cardinal) : Cardinal; stdcall;
  pngSetGrayToRGB : procedure(pngPtr : PPng_Struct); stdcall;
  pngGetGamma : function(pngPtr : PPng_Struct; infoPtr : PPng_Info; fileGamma : PDouble) : Cardinal; stdcall;
  pngSetGamma : procedure(pngPtr : PPng_Struct; screenGamma, defaultFileGamma : Double); stdcall; 
  pngReadUpdateInfo : procedure(pngPtr : PPng_Struct; infoPtr : PPng_Info); stdcall;
  pngGetRowBytes : function(pngPtr : PPng_Struct; infoPtr : PPng_Info) : Cardinal; stdcall;
  pngReadImage : procedure(pngPtr : PPng_Struct; image : PPByte); stdcall;
  pngReadEnd : procedure(pngPtr : PPng_Struct; infoPtr : PPng_Info); stdcall;
  pngDestroyReadStruct : procedure(pngPtrPtr : PPPng_Struct; infoPtrPtr, endInfoPtrPtr : PPPng_Info); stdcall;
  pngCloseFile : function(filep : Pointer) : Integer; stdcall;

  pngCreateWriteStruct : function(pngVer : PChar; errorPtr, errorFn, warnFn : Pointer) : PPng_struct; stdcall;
  pngSetWriteStatusFn : procedure(pngptr : PPng_Struct; writeRowFn : Pointer); stdcall;
  pngSetIHDR : procedure(pngPtr : PPng_Struct; infoPtr: PPng_Info;
          width, height : Cardinal; bitDepth, colorType, interlaceType,
          compressionType, filterType : Integer); stdcall;
  pngWriteInfo : procedure(pngPtr : PPng_Struct; infoPtr: PPng_Info); stdcall;
  pngWriteImage : procedure(pngPtr : PPng_Struct; image : PPByte); stdcall;
  pngWriteEnd : procedure(pngPtr : PPng_Struct; infoPtr: PPng_Info); stdcall;
  pngWriteFlush : procedure(pngPtr : PPng_Struct); stdcall;
  pngDestroyWriteStruct : procedure(pngPtrPtr : PPPng_Struct; infoPtrPtr : PPPng_Info); stdcall;

  pngLib : HINST;

function InitPNG() : Boolean;
  
implementation

// Name       : InitPNG
// Desription : Loads the PNG library and gets the procedure addresses
// Parameters : None
// Returns    : True if library could be loaded
function InitPNG() : Boolean;
begin
  Result := True;
  pngLib := LoadLibrary('libpng.dll');
  if (pngLib <> 0) then begin
    pngOpenFile           := GetProcAddress(pngLib, 'png_open_file');
    pngCreateReadStruct   := GetProcAddress(pngLib, 'png_create_read_struct');
    pngCreateInfoStruct   := GetProcAddress(pngLib, 'png_create_info_struct');
    pngInitIO             := GetProcAddress(pngLib, 'png_init_io');
    pngSetReadStatusFn    := GetProcAddress(pngLib, 'png_set_read_status_fn');
    pngReadInfo           := GetProcAddress(pngLib, 'png_read_info');
    pngGetIHDR            := GetProcAddress(pngLib, 'png_get_IHDR');
    pngSetSwap            := GetProcAddress(pngLib, 'png_set_swap');
    pngSetExpand          := GetProcAddress(pngLib, 'png_set_expand');
    pngSetPacking         := GetProcAddress(pngLib, 'png_set_packing');
    pngGetValid           := GetProcAddress(pngLib, 'png_get_valid');
    pngSetGrayToRGB       := GetProcAddress(pngLib, 'png_set_gray_to_rgb');
    pngGetGamma           := GetProcAddress(pngLib, 'png_get_gAMA');
    pngSetGamma           := GetProcAddress(pngLib, 'png_set_gAMA');
    pngReadUpdateInfo     := GetProcAddress(pngLib, 'png_read_update_info');
    pngGetRowBytes        := GetProcAddress(pngLib, 'png_get_rowbytes');
    pngReadImage          := GetProcAddress(pngLib, 'png_read_image');
    pngReadEnd            := GetProcAddress(pngLib, 'png_read_end');
    pngDestroyReadStruct  := GetProcAddress(pngLib, 'png_destroy_read_struct');
    pngCloseFile          := GetProcAddress(pngLib, 'png_close_file');
  
    pngCreateWriteStruct  := GetProcAddress(pngLib, 'png_create_write_struct');
    pngSetWriteStatusFn   := GetProcAddress(pngLib, 'png_set_write_status_fn');
    pngSetIHDR            := GetProcAddress(pngLib, 'png_set_IHDR');
    pngWriteInfo          := GetProcAddress(pngLib, 'png_write_info');
    pngWriteImage         := GetProcAddress(pngLib, 'png_write_image');
    pngWriteEnd           := GetProcAddress(pngLib, 'png_write_end');
    pngWriteFlush         := GetProcAddress(pngLib, 'png_write_flush');
    pngDestroyWriteStruct := GetProcAddress(pngLib, 'png_destroy_write_struct');
  end else
    Result := False;
end;

end.
