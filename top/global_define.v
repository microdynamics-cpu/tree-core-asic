`define UART_PADDR_W 32
//gpio
`define GPIO_W 4
//chiplink
`define chiplink_data_w 32
//APB
`define P_ADDR_W 32
`define P_DATA_W 32 
`define P_STRB_W `P_DATA_W/8

//AXI
//`define A_ID_W    1
`define A_ID_W 4
`define A_ADDR_W 32
`define A_DATA_W 64
`define A_STRB_W `A_DATA_W/8
`define A_SIZE_W 3
`define A_BURST_W 2
`define A_LEN_W 8
`define A_RESP_W 2
`define A_QOS_W 4
`define A_CACHE_W 4
`define A_LOCK_W 1
`define A_PROT_W 3
`define A_USER_W 1
`define A_LAST_W 1

//28bit
`define SPI_FLASH_START 32'h30000000
`define SPI_FLASH_END 32'h3fffffff

//12bit
`define UART_START 32'h10000000
`define UART_END 32'h10000fff

`define SD_CARD_START 32'h41100000
`define SD_CARD_END 32'h411fffff

`define GPIO_START 32'h41200000
`define GPIO_END 32'h412fffff

`define PLIC_START 32'h41300000
`define PLIC_END 32'h413fffff

`define ysyx_210000      5'd1
`define ysyx_210340      5'd2
