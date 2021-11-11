module core_tb(
    input clk,
    input rst
);

    wire [31:0] fet_pcro;
    wire fet_valid;
    wire insm_ready;
    wire insm_valid;
    wire [31:0] insm_pcro;
    wire [31:0] insm_insmemaddr_o;
    wire insm_insmemcke_o;
    wire [31:0] insm_inst;
    wire [31:0] insr_dout;

    wire decode_ready;
    wire decode_valid;
    wire [4:0] decode_r0num;
    wire [4:0] decode_r1num;
    wire [4:0] decode_rdnum;
    wire decode_r0valid;
    wire decode_r1valid;
    wire decode_rdreserve;
    wire [31:0] decode_pc;
    wire [31:0] decode_inst;
    wire [31:0] decode_r0data;
    wire [31:0] decode_r1data;

    wire [31:0] regfile_r_opr0;
    wire [31:0] regfile_r_opr1;
    wire regfile_reserved_flg;

    wire execute_ready;
    wire execute_valid;
    wire [31:0] execute_pc;
    wire [31:0] execute_inst;
    wire [31:0] execute_r0data;
    wire [31:0] execute_r1data;
    wire [31:0] execute_result;
    wire [31:0] execute_jumpaddr;
    wire execute_jumptaken;
    wire [31:0] execute_datamemaddr;
    wire [31:0] execute_datamemdata;
    wire execute_datamemwrite;
    wire [1:0] execute_datamemwidth;

    wire datam_ready;
    wire datam_valid;
    wire [31:0] datam_pc;
    wire [31:0] datam_inst;
    wire [31:0] datam_r0data;
    wire [31:0] datam_r1data;
    wire [31:0] datam_result;

    wire [31:0] dataram_data;

    wire writeback_ready;
    wire writeback_rdvalid;
    wire [4:0] writeback_rdnum;
    wire [31:0] writeback_rddata;

    fetch fet(
        .clk(clk),
        .rst(rst),

        .valid_ro(fet_valid),
        .ready_i(insm_ready),

        .pc_ro(fet_pcro),

        .branch_addr_i(execute_jumpaddr),
        .branch_taken_i(execute_jumptaken)
    );

    insm insm(
        .clk(clk),
        .rst(rst),

        .valid_i(fet_valid),
        .ready_o(insm_ready),
        
        .valid_ro(insm_valid),
        .ready_i(decode_ready),

        .pc_i(fet_pcro),
        .pc_ro(insm_pcro),

        .insmemaddr_o(insm_insmemaddr_o),
        .insmemdata_i(insr_dout),
        .insmemcke_o(insm_insmemcke_o),

        .inst_o(insm_inst),
        .jump_taken_i(execute_jumptaken)
    );

    insrom insr(
        .clk(clk),
        .rst(rst),
        .cke(insm_insmemcke_o),
        .addr(fet_pcro),
        .dout(insr_dout)
    );



    decode decode(
        .clk(clk),
        .rst(rst),

        .valid_i(insm_valid),
        .ready_o(decode_ready),

        .valid_ro(decode_valid),
        .ready_i(execute_ready),

        .r0num_o(decode_r0num),
        .r0valid_o(decode_r0valid),
        .r1num_o(decode_r1num),
        .r1valid_o(decode_r1valid),
        .rdnum_o(decode_rdnum),
        .rdreserve_o(decode_rdreserve),
        .r0data_i(regfile_r_opr0),
        .r1data_i(regfile_r_opr1),
        .rsreserved_i(regfile_reserved_flg),

        .pc_i(insm_pcro),
        .inst_i(insm_inst),

        .pc_ro(decode_pc),
        .inst_ro(decode_inst),
        .r0data_ro(decode_r0data),
        .r1data_ro(decode_r1data),

        .jump_taken_i(execute_jumptaken)
    );

  

    register_file regfile(
        .clk(clk),
        .rst(rst),
        .r0_i(decode_r0num),
        .r0v_i(decode_r0valid),
        .r1_i(decode_r1num),
        .r1v_i(decode_r1valid),
        .r_opr0_o(regfile_r_opr0),
        .r_opr1_o(regfile_r_opr1),
        .reserved_flg_o(regfile_reserved_flg),

        .rd_i(decode_rdnum),
        .reserve_flg_i(decode_rdreserve),

        .wb_i(writeback_rdvalid),
        .wb_r_i(writeback_rdnum),
        .result_i(writeback_rddata)
    );



    execute execute(
        .clk(clk),
        .rst(rst),

        .valid_i(decode_valid),
        .ready_o(execute_ready),
        
        .valid_ro(execute_valid),
        .ready_i(datam_ready),

        .pc_i(decode_pc),
        .inst_i(decode_inst),
        .r0data_i(decode_r0data),
        .r1data_i(decode_r1data),

        .pc_ro(execute_pc),
        .inst_ro(execute_inst),
        .r0data_ro(execute_r0data),
        .r1data_ro(execute_r1data),
        .result_ro(execute_result),
        
        .jumpaddr_o(execute_jumpaddr),
        .jumptaken_o(execute_jumptaken),

        .datamemaddr_o(execute_datamemaddr), 
        .datamemdata_o(execute_datamemdata),
        .datamemwrite_o(execute_datamemwrite),
        .datamemwidth_o(execute_datamemwidth)
    );


    
    datam datam(
        .clk(clk),
        .rst(rst),

        .valid_i(execute_valid),
        .ready_o(datam_ready),

        .valid_ro(datam_valid),
        .ready_i(writeback_ready),

        .pc_i(execute_pc),
        .inst_i(execute_inst),
        .r0data_i(execute_r0data),
        .r1data_i(execute_r1data),
        .result_i(execute_result),

        .pc_ro(datam_pc),
        .inst_ro(datam_inst),
        .r0data_ro(datam_r0data),
        .r1data_ro(datam_r1data),
        .result_ro(datam_result),

        .datamemdata_i(dataram_data)
    );


    dataram dataram(
        .clk(clk),
        .addr(execute_datamemaddr),
        .width(execute_datamemwidth),
        .write(execute_datamemwrite),
        .din(execute_datamemdata),
        .dout(dataram_data)
    );



    writeback writeback(
        .clk(clk),
        .rst(rst),

        .valid_i(datam_valid),
        .ready_o(writeback_ready),
        
        .pc_i(datam_pc),
        .inst_i(datam_inst),
        .r0data_i(datam_r0data),
        .r1data_i(datam_r1data),
        .result_i(datam_result),

        .rdvalid_o(writeback_rdvalid),
        .rdnum_o(writeback_rdnum),
        .rddata_o(writeback_rddata)
    );
    
endmodule

module top;
        parameter tCYC=2;
        parameter tPD=(tCYC/10);

        reg p_reset;
        reg m_clock;

        reg [31:0] counter;

        reg branch_taken;
        reg [31:0] branch_addr;

        core_tb ckt_instance(
                .rst(p_reset),
                .clk(m_clock)
        );

        initial forever #(tCYC/2) m_clock = ~m_clock;

        initial begin
                $dumpfile("ckt.vcd");
                $dumpvars(0,top);
        end

        initial begin
                #(tPD)
                        p_reset = 1;
                        m_clock = 0;
                #(tCYC)
                        p_reset = 0;
        end

        always @(posedge m_clock or posedge p_reset) begin
                if(p_reset) begin
                        counter <= 32'b0;
                end else begin
                        if(counter == 32'd10000) begin
                                $finish;
                        end
                        counter <= counter + 1'b1;
                        // $display("########## counter : %d ###############",counter);
                        // $display("EX : (iaddr : %x),(inst : %x)",ckt_instance.execute.inst_addr_r,ckt_instance.execute.inst_r);
                        // $display("EX : (valid_o : %b),(ready_o : %b)",ckt_instance.execute.valid_o,ckt_instance.execute.ready_o);
                        // $display("EX : (ramdata_o : %x),(ramaddr_o : %x),(ramwrite : %b)",ckt_instance.execute.dataram_data_o,ckt_instance.execute.dataram_addr_o,ckt_instance.execute.dataram_we_o);
                        // $display("r0 : %x", ckt_instance.register_file.data0);
                        // $display("r1 : %x", ckt_instance.register_file.data1);
                        // $display("r2 : %x", ckt_instance.register_file.data2);
                        // $display("r3 : %x", ckt_instance.register_file.data3);
                        // $display("r4 : %x", ckt_instance.register_file.data4);
                        // $display("r5 : %x", ckt_instance.register_file.data5);
                        // $display("r6 : %x", ckt_instance.register_file.data6);
                        // $display("r7 : %x", ckt_instance.register_file.data7);
                        // $display("r8 : %x", ckt_instance.register_file.data8);
                        // $display("r9 : %x", ckt_instance.register_file.data9);
                        // $display("r10 : %x", ckt_instance.register_file.data10);
                        // $display("r11 : %x", ckt_instance.register_file.data11);
                        // $display("r12 : %x", ckt_instance.register_file.data12);
                        // $display("r13 : %x", ckt_instance.register_file.data13);
                        // $display("r14 : %x", ckt_instance.register_file.data14);
                        // $display("r15 : %x", ckt_instance.register_file.data15);
                        // $display("r16 : %x", ckt_instance.register_file.data16);
                        // $display("r17 : %x", ckt_instance.register_file.data17);
                        // $display("r18 : %x", ckt_instance.register_file.data18);
                        // $display("r19 : %x", ckt_instance.register_file.data19);
                        // $display("r20 : %x", ckt_instance.register_file.data20);
                        // $display("r21 : %x", ckt_instance.register_file.data21);
                        // $display("r22 : %x", ckt_instance.register_file.data22);
                        // $display("r23 : %x", ckt_instance.register_file.data23);
                        // $display("r24 : %x", ckt_instance.register_file.data24);
                        // $display("r25 : %x", ckt_instance.register_file.data25);
                        // $display("r26 : %x", ckt_instance.register_file.data26);
                        // $display("r27 : %x", ckt_instance.register_file.data27);
                        // $display("r28 : %x", ckt_instance.register_file.data28);
                        // $display("r29 : %x", ckt_instance.register_file.data29);
                        // $display("r30 : %x", ckt_instance.register_file.data30);
                        // $display("r31 : %x", ckt_instance.register_file.data31);
                        
                end
        end
        

endmodule