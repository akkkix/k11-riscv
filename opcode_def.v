//parameter OP_LUI	=	7'b01101_11;
parameter BOP_LUI   =   7'b01101_11;

//parameter OP_AUIPC	=	7'b00101_11;
parameter BOP_AUIPC =   7'b00101_11;

// parameter OP_ADDI	=	7'b00100_11;
// parameter OP_SLTI	=	7'b00100_11;
// parameter OP_SLTIU	=	7'b00100_11;
// parameter OP_XORI	=	7'b00100_11;
// parameter OP_ORI	=	7'b00100_11;
// parameter OP_ANDI	=	7'b00100_11;
// parameter OP_SLLI	=	7'b00100_11;
// parameter OP_SRLI	=	7'b00100_11;
// parameter OP_SRAI	=	7'b00100_11;
parameter BOP_OPIMM =   7'b00100_11;
// parameter FUNCT3_ADDI   =   3'b000;
// parameter FUNCT3_SLTI   =   3'b010;
// parameter FUNCT3_SLTIU  =   3'b011;
// parameter FUNCT3_XORI   =   3'b100;
// parameter FUNCT3_ORI    =   3'b110;
// parameter FUNCT3_ANDI   =   3'b111;
// parameter FUNCT3_SLLI   =   3'b001;
// parameter FUNCT3_SRLI   =   3'b101;
// parameter FUNCT3_SRAI   =   3'b101;

// parameter OP_ADD	=	7'b01100_11;
// parameter OP_SUB	=	7'b01100_11;
// parameter OP_SLL	=	7'b01100_11;
// parameter OP_SLT	=	7'b01100_11;
// parameter OP_SLTU	=	7'b01100_11;
// parameter OP_XOR	=	7'b01100_11;
// parameter OP_SRL	=	7'b01100_11;
// parameter OP_SRA	=	7'b01100_11;
// parameter OP_OR	    =	7'b01100_11;
// parameter OP_AND	=	7'b01100_11;
parameter BOP_OP    =   7'b01100_11;
parameter FUNCT3_ADD    =   3'b000;
parameter FUNCT3_SUB    =   3'b000;
parameter FUNCT3_SLL    =   3'b001;
parameter FUNCT3_SLT    =   3'b010;
parameter FUNCT3_SLTU   =   3'b011;
parameter FUNCT3_XOR    =   3'b100;
parameter FUNCT3_SRL    =   3'b101;
parameter FUNCT3_SRA    =   3'b101;
parameter FUNCT3_OR     =   3'b110;
parameter FUNCT3_AND    =   3'b111;
parameter FUNCT7_ADD    =   7'b00000_00;
parameter FUNCT7_SUB    =   7'b01000_00;
parameter FUNCT7_SRL    =   7'b00000_00;
parameter FUNCT7_SRA    =   7'b01000_00;
parameter FUNCT7_AND    =   7'b00000_00;
parameter FUNCT7_OR     =   7'b00000_00;
parameter FUNCT7_XOR    =   7'b00000_00;
parameter FUNCT7_SLL    =   7'b00000_00;
parameter FUNCT7_SLT    =   7'b00000_00;
parameter FUNCT7_SLTU   =   7'b00000_00;

// M_extension
parameter FUNCT7_MULDIV =   7'b00000_01;
parameter FUNCT3_MUL    =   3'b000;
parameter FUNCT3_MULH   =   3'b001;
parameter FUNCT3_MULHSU =   3'b010;
parameter FUNCT3_MULHU  =   3'b011;
parameter FUNCT3_DIV    =   3'b100;
parameter FUNCT3_DIVU   =   3'b101;
parameter FUNCT3_REM    =   3'b110;
parameter FUNCT3_REMU   =   3'b111;

parameter OP_FENCE	=	7'b00011_11;
/*
parameter OP_FENCEI	=	7'b00011_11;
*/
parameter BOP_MISCMEM   =   7'b00011_11;

/*
parameter OP_CSRRW	=	7'b11100_11;
parameter OP_CSRRS	=	7'b11100_11;
parameter OP_CSRRC	=	7'b11100_11;
parameter OP_CSRRWI	=	7'b11100_11;
parameter OP_CSRRSI	=	7'b11100_11;
parameter OP_CSRRCI	=	7'b11100_11;
*/
parameter OP_ECALL	=	7'b11100_11;
parameter OP_EBREAK	=	7'b11100_11;
/*
parameter OP_URET	=	7'b11100_11;
parameter OP_SRET	=	7'b11100_11;
parameter OP_MRET	=	7'b11100_11;
parameter OP_WFI	=	7'b11100_11;
parameter OP_SFENCEVMA	=	7'b11100_11;
*/
parameter BOP_SYSTEM    =   7'b11100_11;

// parameter OP_LB	    =	7'b00000_11;
// parameter OP_LH	    =	7'b00000_11;
// parameter OP_LW	    =	7'b00000_11;
// parameter OP_LBU	=	7'b00000_11;
// parameter OP_LHU	=	7'b00000_11;
parameter BOP_LOAD  =   7'b00000_11;
parameter FUNCT3_LB =   3'b000;
parameter FUNCT3_LH =   3'b001;
parameter FUNCT3_LW =   3'b010;
parameter FUNCT3_LBU    =   3'b100;
parameter FUNCT3_LHU    =   3'b101;

// parameter OP_SB	    =	7'b01000_11;
// parameter OP_SH	    =	7'b01000_11;
// parameter OP_SW	    =	7'b01000_11;
parameter BOP_STORE =   7'b01000_11;
parameter FUNCT3_SB =   3'b000;
parameter FUNCT3_SH =   3'b001;
parameter FUNCT3_SW =   3'b010;

//parameter OP_JAL	=	7'b11011_11;
parameter BOP_JAL   =   7'b11011_11;

//parameter OP_JALR	=	7'b11001_11;
parameter BOP_JALR  =   7'b11001_11;

// parameter OP_BEQ	=	7'b11000_11;
// parameter OP_BNE	=	7'b11000_11;
// parameter OP_BLT	=	7'b11000_11;
// parameter OP_BGE	=	7'b11000_11;
// parameter OP_BLTU	=	7'b11000_11;
// parameter OP_BGEU	=	7'b11000_11;
parameter BOP_BRANCH    =   7'b11000_11;
parameter FUNCT3_BEQ    =   3'b000;
parameter FUNCT3_BNE    =   3'b001;
parameter FUNCT3_BLT    =   3'b100;
parameter FUNCT3_BGE    =   3'b101;
parameter FUNCT3_BLTU   =   3'b110;
parameter FUNCT3_BGEU   =   3'b111;
