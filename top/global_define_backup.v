//chiplink
`define chiplink_data_w 8

//APB
`define P_ADDR_W 32
`define P_DATA_W 32 
`define P_STRB_W `P_DATA_W/8
`define P_PROT_W 3

//AXI
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


//SPI
`define SPI_FLASH_START 32'h3000_0000
`define SPI_FLASH_END 32'h3FFF_FFFF

//UART
`define UART_START 32'h1000_0000
`define UART_END 32'h1000_0FFF
