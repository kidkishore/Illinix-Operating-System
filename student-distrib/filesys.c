#include "lib.h"
#include "types.h"
#include "filesys.h"
#include "multiboot.h"
#include "pcb.h"

boot_block_t* boot_block = NULL;

/* Function: read_dentry_by_name
 * Inputs: none
 * Return Value: 0 on success or -1 on fail
 * Description: On success, fill in the dentry_t block passed in as 2nd arg with file name, file type, and inode number for the file, return 0
 */
int32_t read_dentry_by_name(const uint8_t* fname, dentry_t* dentry)
{

    int i;
    uint32_t name_length = strlen((int8_t*)fname);
    // printf("%s %d\n", fname, name_length);
    //if any of the arguments are null, or name too long, return fail
    if ((fname == NULL) | (name_length > FILE_NAME_SIZE) | (dentry==NULL))
    {
        return -1;
    }



    //loop through all directory names to determine which one matches our target directory
    for (i = 0; i < boot_block->num_dir; i++)
    {
		uint32_t file_name_length = strlen((char*)(boot_block->directories[i].file_name));
		
        //compare the longer string
        if(name_length > file_name_length){
            file_name_length = name_length;
        }

        //shorten length of comparision if needed
		if (file_name_length > FILE_NAME_SIZE)
			file_name_length = FILE_NAME_SIZE;

        
	
        // printf("%s %d %d\n", boot_block->directories[i].file_name, strncmp((int8_t*)fname, (char*)(boot_block->directories[i].file_name), name_length), name_length);
        if (!strncmp((int8_t*)fname, (char*)(boot_block->directories[i].file_name), file_name_length))
        {
            //once we've found the directory with the matching name, do the same thing as reading directory with specific index
            return read_dentry_by_index(i, dentry);
        }
    }

    return -1;
}


/* Function: read_dentry_by_index
 * Inputs: none
 * Return Value: 0 on success or -1 on fail
 * Description: On success, fill in the dentry_t block passed in as 2nd arg with file name, file type, and inode number for the file, return 0
 */
int32_t read_dentry_by_index(uint32_t index, dentry_t* dentry)
{

    if ((index < 0) || (dentry == NULL) || (index > NUM_DIR))
    {
        return -1;
    }


    strncpy(dentry->file_name, boot_block->directories[index].file_name, FILE_NAME_SIZE);
    dentry->file_type = boot_block->directories[index].file_type;
    dentry->inode_num = boot_block->directories[index].inode_num;

    return 0;
}

/* Function: read_data
 * Inputs: none
 * Return Value: 0 on success or -1 on fail
 * Description: On success, fill in buffer with length number of bytes, starting from position offset in the file with inode number inode
 */
int32_t read_data(uint32_t inode, uint32_t offset, uint8_t* buf, uint32_t length)
{

    int i;

    //check for invalid inode number
    if ((inode < 0) | (inode > boot_block->num_inodes))
    {
        return -1;
    }

    //point to the inode we want (add 1 to inode index to skip boot block)
    inode_t* curr_inode = (void*)boot_block + (inode + 1) * DATA_BLOCK_SIZE;
    
	i = 0;
    //loop through each byte we want to read
	while ((offset < curr_inode->length) && (i < length)) {
		
        //determine current data block index we're interested in
		uint32_t block_index = curr_inode->data_block_nums[offset / DATA_BLOCK_SIZE];

        //determine current data block offset from beginning of filesystem
		uint32_t block_offset = 1 + boot_block->num_inodes + block_index;

        //get current data block
		data_block_t* curr_datablock = (void*)boot_block + block_offset * DATA_BLOCK_SIZE;

        //get byte in current datablock we're at
		buf[i] = curr_datablock->data[offset % DATA_BLOCK_SIZE];

	    offset++;
		i++;
	}




    return i;
}

/* Function: file_read
 * Inputs: fd, buffer, bytes ti read
 * Return Value: number of bytes read
 * Description: Read count bytes of data from file into buffer (use read_data)
 ****DO NOT assume data blocks are contiguous
 */
int32_t file_read(int32_t fd, void* buf, int32_t nbytes)
{

    if(fd < 0 || (fd >= FD_ARRAY_SIZE)){
        return -1;
    }

    pcb_t *curr_pcb = get_pcb();
    int32_t bytes_read;

    bytes_read = read_data(curr_pcb->fd_array[fd].inode_num, curr_pcb->fd_array[fd].file_pos, buf,  nbytes);

    //update file offest
    curr_pcb->fd_array[fd].file_pos = curr_pcb->fd_array[fd].file_pos + bytes_read;


    

    return bytes_read;
}

/* Function: file_write
 * Inputs: none
 * Return Value: -1
 * Description: Do nothing, return -1
 */
int32_t file_write(int32_t fd, const void* buf, int32_t nbytes)
{
    if(fd < 0 || (fd >= FD_ARRAY_SIZE)){
        return -1;
    }


    return -1;
}

/* Function: file_open
 * Inputs: none
 * Return Value: return 0
 * Description: Initialize temporary structures
 */
int32_t file_open(const uint8_t* filename)
{
    return 0;
}

/* Function: file_close
 * Inputs: none
 * Return Value: return 0
 * Description: Undo all things done in file_open function
 */
int32_t file_close(int32_t fd)
{
    return 0;
}

/* Function: dir_read
 * Inputs: filename
 * Return Value: return 0
 * Description: Reads filename by filename, including "."
 In read_dentry_by_index, index is NOT inode number 
 */
int32_t dir_read(int32_t fd, void* buf, int32_t nbytes)
{

    if(fd < 0 || (fd >= FD_ARRAY_SIZE)){
        return -1;
    }


    pcb_t *curr_pcb = get_pcb();

	char* temp = (char*)buf;

    int i;
    dentry_t dentry;
    int32_t success;
    int32_t bytes_read;
    bytes_read = 0;

    success = read_dentry_by_index(curr_pcb->fd_array[fd].file_pos, &dentry);

    if(success == -1){
        return -1;
    }

    for(i = 0;i < FILE_NAME_SIZE; i++){
        if((dentry.file_name[i]) != NULL && (i < nbytes)){
            temp[i] = dentry.file_name[i];                     //FIX THIS
            bytes_read += 1;
        }
        else{
            temp[i] = NULL;
        }
    }

    curr_pcb->fd_array[fd].file_pos += 1;

    return bytes_read;
}

/* Function: dir_write
 * Inputs: none
 * Return Value: return -1
 * Description: Do nothing, return -1
 */
int32_t dir_write(int32_t fd, const void* buf, int32_t nbytes)
{

    if(fd < 0 || (fd >= FD_ARRAY_SIZE)){
        return -1;
    }

    return -1;
}

/* Function: dir_write
 * Inputs: none
 * Return Value: return 0
 * Description: Opens a directory file (note filetypes)
 */
int32_t dir_open(const uint8_t* filename)
{
    return 0;
}

/* Function: dir_close
 * Inputs: none
 * Return Value: return -1
 * Description: (Probably) does nothing, return 0
 */
int32_t dir_close(int32_t fd)
{

    if(fd < 0 || (fd >= FD_ARRAY_SIZE)){
        return -1;
    }

    return 0;
}

