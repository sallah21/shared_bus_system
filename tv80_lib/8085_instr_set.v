//MCS-85 instruction set   
`define MOV_B_B 8'b01000000
`define MOV_B_C 8'b01000001
`define MOV_B_D 8'b01000010
`define MOV_B_E 8'b01000011
`define MOV_B_H 8'b01000100
`define MOV_B_L 8'b01000101
`define MOV_B_M 8'b01000110
`define MOV_B_A 8'b01000111
`define MOV_C_B 8'b01001000
`define MOV_C_C 8'b01001001
`define MOV_C_D 8'b01001010
`define MOV_C_E 8'b01001011
`define MOV_C_H 8'b01001100
`define MOV_C_L 8'b01001101
`define MOV_C_M 8'b01001110
`define MOV_C_A 8'b01001111
`define MOV_D_B 8'b01010000
`define MOV_D_C 8'b01010001
`define MOV_D_D 8'b01010010
`define MOV_D_E 8'b01010011
`define MOV_D_H 8'b01010100
`define MOV_D_L 8'b01010101
`define MOV_D_M 8'b01010110
`define MOV_D_A 8'b01010111
`define MOV_E_B 8'b01011000
`define MOV_E_C 8'b01011001
`define MOV_E_D 8'b01011010
`define MOV_E_E 8'b01011011
`define MOV_E_H 8'b01011100
`define MOV_E_L 8'b01011101
`define MOV_E_M 8'b01011110
`define MOV_E_A 8'b01011111
`define MOV_H_B 8'b01100000
`define MOV_H_C 8'b01100001
`define MOV_H_D 8'b01100010
`define MOV_H_E 8'b01100011
`define MOV_H_H 8'b01100100
`define MOV_H_L 8'b01100101
`define MOV_H_M 8'b01100110
`define MOV_H_A 8'b01100111
`define MOV_L_B 8'b01101000
`define MOV_L_C 8'b01101001
`define MOV_L_D 8'b01101010
`define MOV_L_E 8'b01101011
`define MOV_L_H 8'b01101100
`define MOV_L_L 8'b01101101
`define MOV_L_M 8'b01101110
`define MOV_L_A 8'b01101111
`define MOV_M_B 8'b01110000
`define MOV_M_C 8'b01110001
`define MOV_M_D 8'b01110010
`define MOV_M_E 8'b01110011
`define MOV_M_H 8'b01110100
`define MOV_M_L 8'b01110101
`define MOV_M_M 8'b01110110
`define MOV_M_A 8'b01110111
`define MOV_A_B 8'b01111000
`define MOV_A_C 8'b01111001
`define MOV_A_D 8'b01111010
`define MOV_A_E 8'b01111011
`define MOV_A_H 8'b01111100
`define MOV_A_L 8'b01111101
`define MOV_A_M 8'b01111110
`define MOV_A_A 8'b01111111
`define MVI_B	8'b00000110
`define MVI_C	8'b00001110
`define MVI_D	8'b00010110
`define MVI_E	8'b00011110
`define MVI_H	8'b00100110
`define MVI_L	8'b00101110
`define MVI_M	8'b00110110
`define MVI_A	8'b00111110
`define LXI_B	8'b00000001
`define LXI_D	8'b00010001
`define LXI_H	8'b00100001
`define LXI_SP	8'b00110001
`define LDA		8'b00111010
`define STA		8'b00110010
`define LHLD	8'b00101010
`define SHLD	8'b00100010
`define LDAX_B	8'b00001010
`define LDAX_D	8'b00011010
`define STAX_B	8'b00000010
`define STAX_D	8'b00010010
`define XCHG	8'b11101011
`define ADD_B	8'b10000000
`define ADD_C	8'b10000001
`define ADD_D	8'b10000010
`define ADD_E	8'b10000011
`define ADD_H	8'b10000100
`define ADD_L	8'b10000101
`define ADD_M	8'b10000110
`define ADD_A	8'b10000111
`define ADC_B	8'b10001000
`define ADC_C	8'b10001001
`define ADC_D	8'b10001010
`define ADC_E	8'b10001011
`define ADC_H	8'b10001100
`define ADC_L	8'b10001101
`define ADC_M	8'b10001110
`define ADC_A	8'b10001111
`define SUB_B	8'b10010000
`define SUB_C	8'b10010001
`define SUB_D	8'b10010010
`define SUB_E	8'b10010011
`define SUB_H	8'b10010100
`define SUB_L	8'b10010101
`define SUB_M	8'b10010110
`define SUB_A	8'b10010111
`define SBB_B	8'b10011000
`define SBB_C	8'b10011001
`define SBB_D	8'b10011010
`define SBB_E	8'b10011011
`define SBB_H	8'b10011100
`define SBB_L	8'b10011101
`define SBB_M	8'b10011110
`define SBB_A	8'b10011111
`define ANA_B	8'b10100000
`define ANA_C	8'b10100001
`define ANA_D	8'b10100010
`define ANA_E	8'b10100011
`define ANA_H	8'b10100100
`define ANA_L	8'b10100101
`define ANA_M	8'b10100110
`define ANA_A	8'b10100111
`define XRA_B	8'b10101000
`define XRA_C	8'b10101001
`define XRA_D	8'b10101010
`define XRA_E	8'b10101011
`define XRA_H	8'b10101100
`define XRA_L	8'b10101101
`define XRA_M	8'b10101110
`define XRA_A	8'b10101111
`define ORA_B	8'b10110000
`define ORA_C	8'b10110001
`define ORA_D	8'b10110010
`define ORA_E	8'b10110011
`define ORA_H	8'b10110100
`define ORA_L	8'b10110101
`define ORA_M	8'b10110110
`define ORA_A	8'b10110111
`define CMP_B	8'b10111000
`define CMP_C	8'b10111001
`define CMP_D	8'b10111010
`define CMP_E	8'b10111011
`define CMP_H	8'b10111100
`define CMP_L	8'b10111101
`define CMP_M	8'b10111110
`define CMP_A	8'b10111111
`define ADI		8'b11000110
`define ACI		8'b11001110
`define SUI		8'b11010110
`define SBI		8'b11011110
`define ANI		8'b11100110
`define XRI		8'b11101110
`define ORI		8'b11110110
`define CPI		8'b11111110
`define DAA		8'b00100111
`define RLC		8'b00000111
`define RRC		8'b00001111
`define RAL		8'b00010111
`define RAR		8'b00011111
`define CMA		8'b00101111
`define STC		8'b00110111
`define CMC		8'b00111111
`define INR_B	8'b00000100
`define INR_C	8'b00001100
`define INR_D	8'b00010100
`define INR_E	8'b00011100
`define INR_H	8'b00100100
`define INR_L	8'b00101100
`define INR_M	8'b00110100
`define INR_A	8'b00111100
`define DCR_B	8'b00000101
`define DCR_C	8'b00001101
`define DCR_D	8'b00010101
`define DCR_E	8'b00011101
`define DCR_H	8'b00100101
`define DCR_L	8'b00101101
`define DCR_M	8'b00110101
`define DCR_A	8'b00111101
`define INX_B	8'b00000011
`define INX_D	8'b00010011
`define INX_H	8'b00100011
`define INX_SP	8'b00110011
`define DCX_B	8'b00001011
`define DCX_D	8'b00011011
`define DCX_H	8'b00101011
`define DCX_SP	8'b00111011
`define DAD_B	8'b00001001
`define DAD_D	8'b00011001
`define DAD_H	8'b00101001
`define DAD_SP	8'b00111001
`define JMP		8'b11000011
`define JNZ		8'b11000010
`define JZ		8'b11001010
`define JNC		8'b11010010
`define JC		8'b11011010
`define JPO		8'b11100010
`define JPE		8'b11101010
`define JP		8'b11110010
`define JM		8'b11111010
`define CALL	8'b11001101
`define CNZ		8'b11000100
`define CZ		8'b11001100
`define CNC		8'b11010100
`define CC		8'b11011100
`define CPO		8'b11100100
`define CPE		8'b11101100
`define CP		8'b11110100
`define CM		8'b11111100
`define RET		8'b11001001
`define RNZ		8'b11000000
`define RZ		8'b11001000
`define RNC		8'b11010000
`define RC		8'b11011000
`define RPO		8'b11100000
`define RPE		8'b11101000
`define RP		8'b11110000
`define RM		8'b11111000
`define RST_0	8'b11000111
`define RST_1	8'b11001111
`define RST_2	8'b11010111
`define RST_3	8'b11011111
`define RST_4	8'b11100111
`define RST_5	8'b11101111
`define RST_6	8'b11110111
`define RST_7	8'b11111111
`define PCHL	8'b11101001
`define PUSH_B	8'b11000101
`define PUSH_D	8'b11010101
`define PUSH_H	8'b11100101
`define PUSH_PSW	8'b11110101
`define POP_B	8'b11000001
`define POP_D	8'b11010001
`define POP_H	8'b11100001
`define POP_PSW	8'b11110001
`define XTHL	8'b11100011
`define SPHL	8'b11111001
`define IN		8'b11011011
`define OUT		8'b11010011
`define EI		8'b11111011
`define DI		8'b11110011
`define HLT		8'b01110110
`define NOP		8'b00000000
`define LD_I_A	16'h47ED
`define LD_A_I	16'h57ED
`define IM0		16'h46ED
`define IM1		16'h56ED
`define IM2		16'h5EED
`define LDI_X	16'h2ADD
`define LDI_Y	16'h2AFD
`define LD_X_B	16'h70DD
`define LD_X_C	16'h71DD
`define LD_X_D	16'h72DD
`define LD_X_E	16'h73DD
`define LD_X_H	16'h74DD
`define LD_X_L	16'h75DD
`define LD_X_A	16'h77DD
`define LD_B_X	16'h46DD
`define LD_C_X	16'h4EDD
`define LD_D_X	16'h56DD
`define LD_E_X	16'h5EDD
`define LD_H_X	16'h66DD
`define LD_L_X	16'h6EDD
`define LD_A_X	16'h7EDD

`define LD_Y_B	16'h70FD
`define LD_Y_C	16'h71FD
`define LD_Y_D	16'h72FD
`define LD_Y_E	16'h73FD
`define LD_Y_H	16'h74FD
`define LD_Y_L	16'h75FD
`define LD_Y_A	16'h77FD
`define LD_B_Y	16'h46FD
`define LD_C_Y	16'h4EFD
`define LD_D_Y	16'h56FD
`define LD_E_Y	16'h5EFD
`define LD_H_Y	16'h66FD
`define LD_L_Y	16'h6EFD
`define LD_A_Y	16'h7EFD
`define LDI		16'hA0ED
`define LDIR	16'hB0ED
`define LDD		16'hA8ED
`define LDDR	16'hB8ED
`define Z80_CPI		16'hA1ED
`define Z80_CPIR	16'hB1ED
`define Z80_CPD		16'hA9ED
`define Z80_CPDR	16'hB9ED