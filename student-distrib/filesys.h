
#include "types.h"
#include "multiboot.h"


#ifndef _FILESYS_H
#define _FILESYS_H

#define FILE_NAME_SIZE 32
#define NUM_DIR 63
#define FIRST_DIR_BYTE_OFFSET 64
#define SIZE_DIR_ENTRY 64
#define FOUR_BYTE 4
#define BOOT_RESERVED 52
#define DENTRY_RESERVED 24
#define NUM_DATA_BLOCKS 1023
#define DATA_BLOCK_SIZE 4096

//data block structure for storing info
typedef struct data_block_t{
	uint8_t data[DATA_BLOCK_SIZE];
} data_block_t;

//inode struct for storing data block numbers
typedef struct inode_t{
	uint32_t length; //in bytes
	uint32_t data_block_nums[NUM_DATA_BLOCKS];
} inode_t;


//dentry struct for story directory info
typedef struct dentry_t{
	char file_name[FILE_NAME_SIZE];
	uint32_t file_type;
	uint32_t inode_num;
	int8_t reserved[DENTRY_RESERVED]; 
} dentry_t;

//pointer for accessing info in the boot block
typedef struct boot_block_t{
	uint32_t num_dir;
	uint32_t num_inodes;
	uint32_t num_db;
	int8_t reserved[BOOT_RESERVED]; 
	dentry_t directories[NUM_DIR];
} boot_block_t;




extern int32_t read_dentry_by_name(const uint8_t* fname, dentry_t* dentry);
extern int32_t read_dentry_by_index (uint32_t index, dentry_t* dentry);
extern int32_t read_data(uint32_t inode, uint32_t offset, uint8_t* buf, uint32_t length);


extern int32_t file_read(int32_t fd, void* buf, int32_t nbytes);
extern int32_t file_write(int32_t fd, const void* buf, int32_t nbytes);
extern int32_t file_open(const uint8_t* filename);
extern int32_t file_close(int32_t fd);


extern int32_t dir_read(int32_t fd, void* buf, int32_t nbytes);
extern int32_t dir_write(int32_t fd, const void* buf, int32_t nbytes);
extern int32_t dir_open(const uint8_t* filename);
extern int32_t dir_close(int32_t fd);

extern boot_block_t* boot_block;








#endif /* _FILESYS_H */

