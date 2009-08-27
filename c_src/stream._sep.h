/* This C header file is generated by NIT to compile modules and programs that requires stream. */
#ifndef stream_sep
#define stream_sep
#include "string._sep.h"
#include <nit_common.h>
#include <stream_nit.h>

extern const classtable_elt_t VFT_IOS[];

extern const classtable_elt_t VFT_IStream[];

extern const classtable_elt_t VFT_OStream[];

extern const classtable_elt_t VFT_BufferedIStream[];

extern const classtable_elt_t VFT_IOStream[];

extern const classtable_elt_t VFT_FDStream[];

extern const classtable_elt_t VFT_FDIStream[];

extern const classtable_elt_t VFT_FDOStream[];

extern const classtable_elt_t VFT_FDIOStream[];
extern const char *LOCATE_stream;
extern const int SFT_stream[];
#define ID_IOS (SFT_stream[0])
#define COLOR_IOS (SFT_stream[1])
#define INIT_TABLE_POS_IOS (SFT_stream[2] + 0)
#define CALL_stream___IOS___close(recv) ((stream___IOS___close_t)CALL((recv), (SFT_stream[2] + 1)))
#define CALL_stream___IOS___init(recv) ((stream___IOS___init_t)CALL((recv), (SFT_stream[2] + 2)))
#define ID_IStream (SFT_stream[3])
#define COLOR_IStream (SFT_stream[4])
#define INIT_TABLE_POS_IStream (SFT_stream[5] + 0)
#define CALL_stream___IStream___read_char(recv) ((stream___IStream___read_char_t)CALL((recv), (SFT_stream[5] + 1)))
#define CALL_stream___IStream___read(recv) ((stream___IStream___read_t)CALL((recv), (SFT_stream[5] + 2)))
#define CALL_stream___IStream___read_line(recv) ((stream___IStream___read_line_t)CALL((recv), (SFT_stream[5] + 3)))
#define CALL_stream___IStream___read_all(recv) ((stream___IStream___read_all_t)CALL((recv), (SFT_stream[5] + 4)))
#define CALL_stream___IStream___append_line_to(recv) ((stream___IStream___append_line_to_t)CALL((recv), (SFT_stream[5] + 5)))
#define CALL_stream___IStream___eof(recv) ((stream___IStream___eof_t)CALL((recv), (SFT_stream[5] + 6)))
#define ID_OStream (SFT_stream[6])
#define COLOR_OStream (SFT_stream[7])
#define INIT_TABLE_POS_OStream (SFT_stream[8] + 0)
#define CALL_stream___OStream___write(recv) ((stream___OStream___write_t)CALL((recv), (SFT_stream[8] + 1)))
#define CALL_stream___OStream___is_writable(recv) ((stream___OStream___is_writable_t)CALL((recv), (SFT_stream[8] + 2)))
#define ID_BufferedIStream (SFT_stream[9])
#define COLOR_BufferedIStream (SFT_stream[10])
#define ATTR_stream___BufferedIStream____buffer(recv) ATTR(recv, (SFT_stream[11] + 0))
#define ATTR_stream___BufferedIStream____buffer_pos(recv) ATTR(recv, (SFT_stream[11] + 1))
#define INIT_TABLE_POS_BufferedIStream (SFT_stream[12] + 0)
#define CALL_stream___BufferedIStream___fill_buffer(recv) ((stream___BufferedIStream___fill_buffer_t)CALL((recv), (SFT_stream[12] + 1)))
#define CALL_stream___BufferedIStream___end_reached(recv) ((stream___BufferedIStream___end_reached_t)CALL((recv), (SFT_stream[12] + 2)))
#define CALL_stream___BufferedIStream___prepare_buffer(recv) ((stream___BufferedIStream___prepare_buffer_t)CALL((recv), (SFT_stream[12] + 3)))
#define ID_IOStream (SFT_stream[13])
#define COLOR_IOStream (SFT_stream[14])
#define INIT_TABLE_POS_IOStream (SFT_stream[15] + 0)
#define ID_FDStream (SFT_stream[16])
#define COLOR_FDStream (SFT_stream[17])
#define ATTR_stream___FDStream____fd(recv) ATTR(recv, (SFT_stream[18] + 0))
#define INIT_TABLE_POS_FDStream (SFT_stream[19] + 0)
#define CALL_stream___FDStream___native_close(recv) ((stream___FDStream___native_close_t)CALL((recv), (SFT_stream[19] + 1)))
#define CALL_stream___FDStream___native_read_char(recv) ((stream___FDStream___native_read_char_t)CALL((recv), (SFT_stream[19] + 2)))
#define CALL_stream___FDStream___native_read(recv) ((stream___FDStream___native_read_t)CALL((recv), (SFT_stream[19] + 3)))
#define CALL_stream___FDStream___native_write(recv) ((stream___FDStream___native_write_t)CALL((recv), (SFT_stream[19] + 4)))
#define CALL_stream___FDStream___init(recv) ((stream___FDStream___init_t)CALL((recv), (SFT_stream[19] + 5)))
#define ID_FDIStream (SFT_stream[20])
#define COLOR_FDIStream (SFT_stream[21])
#define ATTR_stream___FDIStream____eof(recv) ATTR(recv, (SFT_stream[22] + 0))
#define INIT_TABLE_POS_FDIStream (SFT_stream[23] + 0)
#define CALL_stream___FDIStream___init(recv) ((stream___FDIStream___init_t)CALL((recv), (SFT_stream[23] + 1)))
#define ID_FDOStream (SFT_stream[24])
#define COLOR_FDOStream (SFT_stream[25])
#define ATTR_stream___FDOStream____is_writable(recv) ATTR(recv, (SFT_stream[26] + 0))
#define INIT_TABLE_POS_FDOStream (SFT_stream[27] + 0)
#define CALL_stream___FDOStream___init(recv) ((stream___FDOStream___init_t)CALL((recv), (SFT_stream[27] + 1)))
#define ID_FDIOStream (SFT_stream[28])
#define COLOR_FDIOStream (SFT_stream[29])
#define INIT_TABLE_POS_FDIOStream (SFT_stream[30] + 0)
#define CALL_stream___FDIOStream___init(recv) ((stream___FDIOStream___init_t)CALL((recv), (SFT_stream[30] + 1)))
#define LOCATE_stream___IOS___close "stream::IOS::close"
void stream___IOS___close(val_t p0);
typedef void (*stream___IOS___close_t)(val_t p0);
#define LOCATE_stream___IOS___init "stream::IOS::init"
void stream___IOS___init(val_t p0, int* init_table);
typedef void (*stream___IOS___init_t)(val_t p0, int* init_table);
val_t NEW_IOS_stream___IOS___init();
val_t NEW_IStream_stream___IOS___init();
#define LOCATE_stream___IStream___read_char "stream::IStream::read_char"
val_t stream___IStream___read_char(val_t p0);
typedef val_t (*stream___IStream___read_char_t)(val_t p0);
#define LOCATE_stream___IStream___read "stream::IStream::read"
val_t stream___IStream___read(val_t p0, val_t p1);
typedef val_t (*stream___IStream___read_t)(val_t p0, val_t p1);
#define LOCATE_stream___IStream___read_line "stream::IStream::read_line"
val_t stream___IStream___read_line(val_t p0);
typedef val_t (*stream___IStream___read_line_t)(val_t p0);
#define LOCATE_stream___IStream___read_all "stream::IStream::read_all"
val_t stream___IStream___read_all(val_t p0);
typedef val_t (*stream___IStream___read_all_t)(val_t p0);
#define LOCATE_stream___IStream___append_line_to "stream::IStream::append_line_to"
void stream___IStream___append_line_to(val_t p0, val_t p1);
typedef void (*stream___IStream___append_line_to_t)(val_t p0, val_t p1);
#define LOCATE_stream___IStream___eof "stream::IStream::eof"
val_t stream___IStream___eof(val_t p0);
typedef val_t (*stream___IStream___eof_t)(val_t p0);
val_t NEW_OStream_stream___IOS___init();
#define LOCATE_stream___OStream___write "stream::OStream::write"
void stream___OStream___write(val_t p0, val_t p1);
typedef void (*stream___OStream___write_t)(val_t p0, val_t p1);
#define LOCATE_stream___OStream___is_writable "stream::OStream::is_writable"
val_t stream___OStream___is_writable(val_t p0);
typedef val_t (*stream___OStream___is_writable_t)(val_t p0);
val_t NEW_BufferedIStream_stream___IOS___init();
#define LOCATE_stream___BufferedIStream___read_char "stream::BufferedIStream::(stream::IStream::read_char)"
val_t stream___BufferedIStream___read_char(val_t p0);
typedef val_t (*stream___BufferedIStream___read_char_t)(val_t p0);
#define LOCATE_stream___BufferedIStream___read "stream::BufferedIStream::(stream::IStream::read)"
val_t stream___BufferedIStream___read(val_t p0, val_t p1);
typedef val_t (*stream___BufferedIStream___read_t)(val_t p0, val_t p1);
#define LOCATE_stream___BufferedIStream___read_all "stream::BufferedIStream::(stream::IStream::read_all)"
val_t stream___BufferedIStream___read_all(val_t p0);
typedef val_t (*stream___BufferedIStream___read_all_t)(val_t p0);
#define LOCATE_stream___BufferedIStream___append_line_to "stream::BufferedIStream::(stream::IStream::append_line_to)"
void stream___BufferedIStream___append_line_to(val_t p0, val_t p1);
typedef void (*stream___BufferedIStream___append_line_to_t)(val_t p0, val_t p1);
#define LOCATE_stream___BufferedIStream___eof "stream::BufferedIStream::(stream::IStream::eof)"
val_t stream___BufferedIStream___eof(val_t p0);
typedef val_t (*stream___BufferedIStream___eof_t)(val_t p0);
#define LOCATE_stream___BufferedIStream___fill_buffer "stream::BufferedIStream::fill_buffer"
void stream___BufferedIStream___fill_buffer(val_t p0);
typedef void (*stream___BufferedIStream___fill_buffer_t)(val_t p0);
#define LOCATE_stream___BufferedIStream___end_reached "stream::BufferedIStream::end_reached"
val_t stream___BufferedIStream___end_reached(val_t p0);
typedef val_t (*stream___BufferedIStream___end_reached_t)(val_t p0);
#define LOCATE_stream___BufferedIStream___prepare_buffer "stream::BufferedIStream::prepare_buffer"
void stream___BufferedIStream___prepare_buffer(val_t p0, val_t p1);
typedef void (*stream___BufferedIStream___prepare_buffer_t)(val_t p0, val_t p1);
val_t NEW_IOStream_stream___IOS___init();
#define LOCATE_stream___FDStream___close "stream::FDStream::(stream::IOS::close)"
void stream___FDStream___close(val_t p0);
typedef void (*stream___FDStream___close_t)(val_t p0);
#define LOCATE_stream___FDStream___native_close "stream::FDStream::native_close"
val_t stream___FDStream___native_close(val_t p0, val_t p1);
typedef val_t (*stream___FDStream___native_close_t)(val_t p0, val_t p1);
#define LOCATE_stream___FDStream___native_read_char "stream::FDStream::native_read_char"
val_t stream___FDStream___native_read_char(val_t p0, val_t p1);
typedef val_t (*stream___FDStream___native_read_char_t)(val_t p0, val_t p1);
#define LOCATE_stream___FDStream___native_read "stream::FDStream::native_read"
val_t stream___FDStream___native_read(val_t p0, val_t p1, val_t p2, val_t p3);
typedef val_t (*stream___FDStream___native_read_t)(val_t p0, val_t p1, val_t p2, val_t p3);
#define LOCATE_stream___FDStream___native_write "stream::FDStream::native_write"
val_t stream___FDStream___native_write(val_t p0, val_t p1, val_t p2, val_t p3);
typedef val_t (*stream___FDStream___native_write_t)(val_t p0, val_t p1, val_t p2, val_t p3);
#define LOCATE_stream___FDStream___init "stream::FDStream::init"
void stream___FDStream___init(val_t p0, val_t p1, int* init_table);
typedef void (*stream___FDStream___init_t)(val_t p0, val_t p1, int* init_table);
val_t NEW_FDStream_stream___FDStream___init(val_t p0);
#define LOCATE_stream___FDIStream___read_char "stream::FDIStream::(stream::IStream::read_char)"
val_t stream___FDIStream___read_char(val_t p0);
typedef val_t (*stream___FDIStream___read_char_t)(val_t p0);
#define LOCATE_stream___FDIStream___eof "stream::FDIStream::(stream::IStream::eof)"
val_t stream___FDIStream___eof(val_t p0);
typedef val_t (*stream___FDIStream___eof_t)(val_t p0);
#define LOCATE_stream___FDIStream___init "stream::FDIStream::init"
void stream___FDIStream___init(val_t p0, val_t p1, int* init_table);
typedef void (*stream___FDIStream___init_t)(val_t p0, val_t p1, int* init_table);
val_t NEW_FDIStream_stream___FDIStream___init(val_t p0);
#define LOCATE_stream___FDOStream___write "stream::FDOStream::(stream::OStream::write)"
void stream___FDOStream___write(val_t p0, val_t p1);
typedef void (*stream___FDOStream___write_t)(val_t p0, val_t p1);
#define LOCATE_stream___FDOStream___is_writable "stream::FDOStream::(stream::OStream::is_writable)"
val_t stream___FDOStream___is_writable(val_t p0);
typedef val_t (*stream___FDOStream___is_writable_t)(val_t p0);
#define LOCATE_stream___FDOStream___init "stream::FDOStream::init"
void stream___FDOStream___init(val_t p0, val_t p1, int* init_table);
typedef void (*stream___FDOStream___init_t)(val_t p0, val_t p1, int* init_table);
val_t NEW_FDOStream_stream___FDOStream___init(val_t p0);
#define LOCATE_stream___FDIOStream___init "stream::FDIOStream::init"
void stream___FDIOStream___init(val_t p0, val_t p1, int* init_table);
typedef void (*stream___FDIOStream___init_t)(val_t p0, val_t p1, int* init_table);
val_t NEW_FDIOStream_stream___FDIOStream___init(val_t p0);
#endif
