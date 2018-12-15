# 1 "idt.c"
# 1 "/workdir/mp3_group_44/student-distrib//"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "idt.c"
# 1 "multiboot.h" 1
# 19 "multiboot.h"
# 1 "types.h" 1
# 15 "types.h"
typedef int int32_t;
typedef unsigned int uint32_t;

typedef short int16_t;
typedef unsigned short uint16_t;

typedef char int8_t;
typedef unsigned char uint8_t;
# 20 "multiboot.h" 2


typedef struct multiboot_header {
    uint32_t magic;
    uint32_t flags;
    uint32_t checksum;
    uint32_t header_addr;
    uint32_t load_addr;
    uint32_t load_end_addr;
    uint32_t bss_end_addr;
    uint32_t entry_addr;
} multiboot_header_t;


typedef struct elf_section_header_table {
    uint32_t num;
    uint32_t size;
    uint32_t addr;
    uint32_t shndx;
} elf_section_header_table_t;


typedef struct multiboot_info {
    uint32_t flags;
    uint32_t mem_lower;
    uint32_t mem_upper;
    uint32_t boot_device;
    uint32_t cmdline;
    uint32_t mods_count;
    uint32_t mods_addr;
    elf_section_header_table_t elf_sec;
    uint32_t mmap_length;
    uint32_t mmap_addr;
} multiboot_info_t;

typedef struct module {
    uint32_t mod_start;
    uint32_t mod_end;
    uint32_t string;
    uint32_t reserved;
} module_t;



typedef struct memory_map {
    uint32_t size;
    uint32_t base_addr_low;
    uint32_t base_addr_high;
    uint32_t length_low;
    uint32_t length_high;
    uint32_t type;
} memory_map_t;
# 2 "idt.c" 2
# 1 "x86_desc.h" 1
# 29 "x86_desc.h"
typedef struct x86_desc {
    uint16_t padding;
    uint16_t size;
    uint32_t addr;
} x86_desc_t;


typedef struct seg_desc {
    union {
        uint32_t val[2];
        struct {
            uint16_t seg_lim_15_00;
            uint16_t base_15_00;
            uint8_t base_23_16;
            uint32_t type : 4;
            uint32_t sys : 1;
            uint32_t dpl : 2;
            uint32_t present : 1;
            uint32_t seg_lim_19_16 : 4;
            uint32_t avail : 1;
            uint32_t reserved : 1;
            uint32_t opsize : 1;
            uint32_t granularity : 1;
            uint8_t base_31_24;
        } __attribute__ ((packed));
    };
} seg_desc_t;


typedef struct __attribute__((packed)) tss_t {
    uint16_t prev_task_link;
    uint16_t prev_task_link_pad;

    uint32_t esp0;
    uint16_t ss0;
    uint16_t ss0_pad;

    uint32_t esp1;
    uint16_t ss1;
    uint16_t ss1_pad;

    uint32_t esp2;
    uint16_t ss2;
    uint16_t ss2_pad;

    uint32_t cr3;

    uint32_t eip;
    uint32_t eflags;

    uint32_t eax;
    uint32_t ecx;
    uint32_t edx;
    uint32_t ebx;
    uint32_t esp;
    uint32_t ebp;
    uint32_t esi;
    uint32_t edi;

    uint16_t es;
    uint16_t es_pad;

    uint16_t cs;
    uint16_t cs_pad;

    uint16_t ss;
    uint16_t ss_pad;

    uint16_t ds;
    uint16_t ds_pad;

    uint16_t fs;
    uint16_t fs_pad;

    uint16_t gs;
    uint16_t gs_pad;

    uint16_t ldt_segment_selector;
    uint16_t ldt_pad;

    uint16_t debug_trap : 1;
    uint16_t io_pad : 15;
    uint16_t io_base_addr;
} tss_t;


extern x86_desc_t gdt_desc;


extern uint16_t ldt_desc;
extern uint32_t ldt_size;
extern seg_desc_t ldt_desc_ptr;
extern seg_desc_t gdt_ptr;
extern uint32_t ldt;

extern uint32_t tss_size;
extern seg_desc_t tss_desc_ptr;
extern tss_t tss;
# 149 "x86_desc.h"
typedef union idt_desc_t {
    uint32_t val[2];
    struct {
        uint16_t offset_15_00;
        uint16_t seg_selector;
        uint8_t reserved4;
        uint32_t reserved3 : 1;
        uint32_t reserved2 : 1;
        uint32_t reserved1 : 1;
        uint32_t size : 1;
        uint32_t reserved0 : 1;
        uint32_t dpl : 2;
        uint32_t present : 1;
        uint16_t offset_31_16;
    } __attribute__ ((packed));
} idt_desc_t;


extern idt_desc_t idt[256];

extern x86_desc_t idt_desc_ptr;
# 3 "idt.c" 2
# 1 "lib.h" 1
# 10 "lib.h"
int32_t printf(int8_t *format, ...);
void putc(uint8_t c);
void putc_at(uint8_t c, int x, int y);
int32_t puts(int8_t *s);
int8_t *itoa(uint32_t value, int8_t* buf, int32_t radix);
int8_t *strrev(int8_t* s);
uint32_t strlen(const int8_t* s);
void clear(void);
void bksp(void);

void* memset(void* s, int32_t c, uint32_t n);
void* memset_word(void* s, int32_t c, uint32_t n);
void* memset_dword(void* s, int32_t c, uint32_t n);
void* memcpy(void* dest, const void* src, uint32_t n);
void* memmove(void* dest, const void* src, uint32_t n);
int32_t strncmp(const int8_t* s1, const int8_t* s2, uint32_t n);
int8_t* strcpy(int8_t* dest, const int8_t*src);
int8_t* strncpy(int8_t* dest, const int8_t*src, uint32_t n);


int32_t bad_userspace_addr(const void* addr, int32_t len);
int32_t safe_strncpy(int8_t* dest, const int8_t* src, int32_t n);




static inline uint32_t inb(port) {
    uint32_t val;
    asm volatile ("             \n            xorl %0, %0         \n            inb  (%w1), %b0     \n            "



            : "=a"(val)
            : "d"(port)
            : "memory"
    );
    return val;
}




static inline uint32_t inw(port) {
    uint32_t val;
    asm volatile ("             \n            xorl %0, %0         \n            inw  (%w1), %w0     \n            "



            : "=a"(val)
            : "d"(port)
            : "memory"
    );
    return val;
}



static inline uint32_t inl(port) {
    uint32_t val;
    asm volatile ("inl (%w1), %0"
            : "=a"(val)
            : "d"(port)
            : "memory"
    );
    return val;
}
# 4 "idt.c" 2
# 1 "i8259.h" 1
# 35 "i8259.h"
void i8259_init(void);

void enable_irq(uint32_t irq_num);

void disable_irq(uint32_t irq_num);

void send_eoi(uint32_t irq_num);
# 5 "idt.c" 2
# 1 "debug.h" 1
# 6 "idt.c" 2
# 1 "tests.h" 1




void launch_tests();

void rtc_test();
# 7 "idt.c" 2
# 1 "idt.h" 1







void load_idt();
void divide_zero_exception();
void single_step_exception();
void nmi_exception();
void breakpoint_exception();
void overflow_exception();
void bounds_exception();
void invalid_opcode_exception();
void coprocessor_exception();
void double_fault_exception();
void segment_overrun_exception();
void invalid_tss_exception();
void segment_not_present_exception();
void stack_fault_exception();
void general_protection_exception();
void page_fault_exception();
void math_fault_exception();
void alignment_check_exception();
void machine_check_exception();
void simd_exception();
void kb_interrupt();
void kb_interrupt_do();
void rtc_interrupt();
void sys_call();
# 8 "idt.c" 2
# 1 "system.h" 1





# 1 "paging.h" 1
# 19 "paging.h"
extern uint32_t page_dir[1024] __attribute__((aligned(4096)));


extern uint32_t page_table[1024] __attribute__((aligned(4096)));

extern void create_page(uint32_t curr_process);

void paging_init();
void paging_enable();
extern void create_page(uint32_t curr_process);
# 7 "system.h" 2
# 1 "filesys.h" 1
# 20 "filesys.h"
typedef struct data_block_t{
 uint8_t data[4096];
} data_block_t;


typedef struct inode_t{
 uint32_t length;
 uint32_t data_block_nums[1023];
} inode_t;



typedef struct dentry_t{
 char file_name[32];
 uint32_t file_type;
 uint32_t inode_num;
 int8_t reserved[24];
} dentry_t;


typedef struct boot_block_t{
 uint32_t num_dir;
 uint32_t num_inodes;
 uint32_t num_db;
 int8_t reserved[52];
 dentry_t directories[63];
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
# 8 "system.h" 2
# 25 "system.h"
__attribute__((regparm(0))) int32_t halt (uint8_t status);
extern int32_t sys_execute(const uint8_t* _command);
__attribute__((regparm(0))) int32_t execute (const uint8_t* command);
__attribute__((regparm(0))) int32_t read (int32_t fd, void* buf, int32_t nbytes);
__attribute__((regparm(0))) int32_t write (int32_t fd, const void* buf, int32_t nbytes);
__attribute__((regparm(0))) int32_t open (const uint8_t* filename);
__attribute__((regparm(0))) int32_t close (int32_t fd);



int32_t check_validity(uint8_t* program, dentry_t* dentry);
void load_file(dentry_t* dentry);
void parse_args(uint8_t* program, uint8_t* args, const uint8_t* command);
# 9 "idt.c" 2
# 1 "dev/terminal.h" 1



# 1 "dev/../types.h" 1
# 5 "dev/terminal.h" 2
# 1 "dev/../x86_desc.h" 1
# 6 "dev/terminal.h" 2
# 1 "dev/../lib.h" 1
# 7 "dev/terminal.h" 2
# 1 "dev/../debug.h" 1
# 8 "dev/terminal.h" 2

extern int32_t terminal_read (int32_t fd, void* buf, int32_t nbytes);
extern int32_t terminal_write (int32_t fd, const void* buf, int32_t nbytes);
extern int32_t terminal_open (const uint8_t* filename);
extern int32_t terminal_close (int32_t fd);
extern int32_t null_func();
# 10 "idt.c" 2







void load_idt(){

 int i;
 i=0;

 while(i<256) {

  if(i==15){
   i++;
   continue;
  }



  idt[i].seg_selector = 0x0010;
  idt[i].dpl = 0;
  idt[i].present = 1;
  idt[i].size = 1;

  idt[i].reserved4 = 0;
  idt[i].reserved3 = 0;
  idt[i].reserved2 = 1;
  idt[i].reserved1 = 1;
  idt[i].reserved0 = 0;




  if(i<32){

   idt[i].reserved3 = 1;

     }

      if (i == 33 || i == 40) {


        idt[i].seg_selector = 0x0010;
        idt[i].present = 1;
        idt[i].dpl = 0;
        idt[i].reserved3 = 0;
        idt[i].reserved2 = 1;
        idt[i].reserved1 = 1;
        idt[i].reserved0 = 0;
        idt[i].size = 1;
      } else if( i == 0x80) {

        idt[i].dpl = 3;
        idt[i].reserved3 = 1;
        idt[i].reserved2 = 1;
        idt[i].reserved1 = 1;
        idt[i].size = 1;
      }
     i++;
 }

    do { idt[0].offset_31_16 = ((uint32_t)(divide_zero_exception) & 0xFFFF0000) >> 16; idt[0].offset_15_00 = ((uint32_t)(divide_zero_exception) & 0xFFFF); } while (0);
    do { idt[1].offset_31_16 = ((uint32_t)(single_step_exception) & 0xFFFF0000) >> 16; idt[1].offset_15_00 = ((uint32_t)(single_step_exception) & 0xFFFF); } while (0);
    do { idt[2].offset_31_16 = ((uint32_t)(nmi_exception) & 0xFFFF0000) >> 16; idt[2].offset_15_00 = ((uint32_t)(nmi_exception) & 0xFFFF); } while (0);
    do { idt[3].offset_31_16 = ((uint32_t)(breakpoint_exception) & 0xFFFF0000) >> 16; idt[3].offset_15_00 = ((uint32_t)(breakpoint_exception) & 0xFFFF); } while (0);
    do { idt[4].offset_31_16 = ((uint32_t)(overflow_exception) & 0xFFFF0000) >> 16; idt[4].offset_15_00 = ((uint32_t)(overflow_exception) & 0xFFFF); } while (0);
    do { idt[5].offset_31_16 = ((uint32_t)(bounds_exception) & 0xFFFF0000) >> 16; idt[5].offset_15_00 = ((uint32_t)(bounds_exception) & 0xFFFF); } while (0);
    do { idt[6].offset_31_16 = ((uint32_t)(invalid_opcode_exception) & 0xFFFF0000) >> 16; idt[6].offset_15_00 = ((uint32_t)(invalid_opcode_exception) & 0xFFFF); } while (0);
    do { idt[7].offset_31_16 = ((uint32_t)(coprocessor_exception) & 0xFFFF0000) >> 16; idt[7].offset_15_00 = ((uint32_t)(coprocessor_exception) & 0xFFFF); } while (0);
    do { idt[8].offset_31_16 = ((uint32_t)(double_fault_exception) & 0xFFFF0000) >> 16; idt[8].offset_15_00 = ((uint32_t)(double_fault_exception) & 0xFFFF); } while (0);
    do { idt[9].offset_31_16 = ((uint32_t)(segment_overrun_exception) & 0xFFFF0000) >> 16; idt[9].offset_15_00 = ((uint32_t)(segment_overrun_exception) & 0xFFFF); } while (0);
    do { idt[10].offset_31_16 = ((uint32_t)(invalid_tss_exception) & 0xFFFF0000) >> 16; idt[10].offset_15_00 = ((uint32_t)(invalid_tss_exception) & 0xFFFF); } while (0);
    do { idt[11].offset_31_16 = ((uint32_t)(segment_not_present_exception) & 0xFFFF0000) >> 16; idt[11].offset_15_00 = ((uint32_t)(segment_not_present_exception) & 0xFFFF); } while (0);
    do { idt[12].offset_31_16 = ((uint32_t)(stack_fault_exception) & 0xFFFF0000) >> 16; idt[12].offset_15_00 = ((uint32_t)(stack_fault_exception) & 0xFFFF); } while (0);
    do { idt[13].offset_31_16 = ((uint32_t)(general_protection_exception) & 0xFFFF0000) >> 16; idt[13].offset_15_00 = ((uint32_t)(general_protection_exception) & 0xFFFF); } while (0);
    do { idt[14].offset_31_16 = ((uint32_t)(page_fault_exception) & 0xFFFF0000) >> 16; idt[14].offset_15_00 = ((uint32_t)(page_fault_exception) & 0xFFFF); } while (0);
    do { idt[16].offset_31_16 = ((uint32_t)(math_fault_exception) & 0xFFFF0000) >> 16; idt[16].offset_15_00 = ((uint32_t)(math_fault_exception) & 0xFFFF); } while (0);
    do { idt[17].offset_31_16 = ((uint32_t)(alignment_check_exception) & 0xFFFF0000) >> 16; idt[17].offset_15_00 = ((uint32_t)(alignment_check_exception) & 0xFFFF); } while (0);
    do { idt[18].offset_31_16 = ((uint32_t)(machine_check_exception) & 0xFFFF0000) >> 16; idt[18].offset_15_00 = ((uint32_t)(machine_check_exception) & 0xFFFF); } while (0);
    do { idt[19].offset_31_16 = ((uint32_t)(simd_exception) & 0xFFFF0000) >> 16; idt[19].offset_15_00 = ((uint32_t)(simd_exception) & 0xFFFF); } while (0);
    do { idt[33].offset_31_16 = ((uint32_t)(kb_interrupt) & 0xFFFF0000) >> 16; idt[33].offset_15_00 = ((uint32_t)(kb_interrupt) & 0xFFFF); } while (0);
   do { idt[40].offset_31_16 = ((uint32_t)(rtc_interrupt) & 0xFFFF0000) >> 16; idt[40].offset_15_00 = ((uint32_t)(rtc_interrupt) & 0xFFFF); } while (0);
    do { idt[0x80].offset_31_16 = ((uint32_t)(sys_call) & 0xFFFF0000) >> 16; idt[0x80].offset_15_00 = ((uint32_t)(sys_call) & 0xFFFF); } while (0);
}


int32_t caps_enabled = 0;
int32_t shift_pressed = 0;
int32_t ctrl_pressed = 0;
int32_t alt_pressed = 0;
int32_t meta_pressed = 0;
int32_t enter_pressed = 0;

char char_map[57] = {
  '?', '?', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '?', ' ',
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', '?', 'a', 's',
  'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', '?', '\\', 'z', 'x', 'c', 'v',
  'b', 'n', 'm', ',', '.', '/', '?', '?', ' '};

char char_map_caps[57] = {
  '?', '?', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '?', ' ',
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n', '?', 'A', 'S',
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '~', '?', '|', 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', ',', '.', '?', '?', '?', ' '};
# 137 "idt.c"
int32_t x = 0, y = 0;






void kb_interrupt_do(int irq, void *dev_id ) {
  unsigned char status, input;
  status = inb(0x64);
  input = inb(0x60);

  char character;

  if (((input >= 0x81 && input <= 0xD8))) {
    if (((input == 0x9D)))
      ctrl_pressed = 0;
    if (((input == 0xAA) || (input == 0xB6)))
      shift_pressed = 0;
    if ((input == 0xB8))
      alt_pressed = 0;
    goto kb_handle_done;
  }
  if (((input == 42) || (input == 54))) {
    shift_pressed = 1;
    goto kb_handle_done;
  }
  if (((input == 0x38) || (input == 0x36))) {
    alt_pressed = 1;
    goto kb_handle_done;
  }
  if (((input == 0x1D) || (input == 0xE0))) {
    ctrl_pressed = 1;
    goto kb_handle_done;
  }
  if ((input == 0x1c)) {
    enter_pressed = 1;
    character = '\n';
    terminal_write(0, &character, 1);
    goto kb_handle_done;
  }
  if ((input == 0x3A)) {
    caps_enabled = 1 - caps_enabled;
    goto kb_handle_done;
  }

  if ((input == 0x0e)) {
    character = 8;
    terminal_write(0, &character, 1);
    goto kb_handle_done;
  }

  if (alt_pressed || ctrl_pressed || meta_pressed) {
    if (ctrl_pressed && (input == 0x26)) {
      character = 25;
      terminal_write(0, &character, 1);
    }
    goto kb_handle_done;
  } else {
    if ((char_map[input] <= 'z' && char_map[input] >= 'a')) {
      character = shift_pressed ^ caps_enabled ? char_map_caps[input] : char_map[input];
    } else {
      character = shift_pressed ? char_map_caps[input] : char_map[input];
    }
    terminal_write(0, &character, 1);
  }

  kb_handle_done:
  send_eoi(1);
}
# 217 "idt.c"
void divide_zero_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("divide by zero exception.\n");

}







void single_step_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Single step exception.\n");

}






void nmi_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("NMI exception.\n");

}
# 253 "idt.c"
void breakpoint_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Breakpoint exception.\n");

}







void overflow_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Overflow exception.\n");

}







void bounds_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Bounds exception.\n");

}







void invalid_opcode_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Invalid opcode exception.\n");

}






void coprocessor_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Coprocessor exception.\n");

}






void double_fault_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Double fault exception.\n");

}






void segment_overrun_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Segment overrun exception.\n");

}






void invalid_tss_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Invalid tss exception.\n");

}






void segment_not_present_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Segment not present exception.\n");

}







void stack_fault_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Stack fault exception.\n");

}







void general_protection_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("General protection exception.\n");

}






void page_fault_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Page fault exception.\n");

}






void math_fault_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Math fault exception.\n");

}







void alignment_check_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Alignment check exception.\n");

}







void machine_check_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Machine check exception.\n");

}







void simd_exception(){
  do { asm volatile ("cli" : : : "memory", "cc" ); } while (0);
  printf("Simd exception.\n");

}
