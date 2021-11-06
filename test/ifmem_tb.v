module ifmem_tb(
    input clk,
    input rst,
    input branch_taken,
    input [31:0] branch_addr,
    input decode_ready
);

    wire [31:0] fet_pcro;
    wire fet_valid;
    wire insm_ready;
    wire insm_valid;
    wire [31:0] insm_pcro;
    wire [31:0] insm_insmemaddr_o;
    wire [31:0] insm_inst;
    wire [31:0] insr_dout;
    wire decode_ready;

    fetch fet(
        .clk(clk),
        .rst(rst),

        .valid_ro(fet_valid),
        .ready_i(insm_ready),

        .pc_ro(fet_pcro),

        .branch_addr_i(branch_addr),
        .branch_taken_i(branch_taken)
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

        .inst_o(insm_inst)
    );

    insrom insr(
        .clk(clk),
        .addr(fet_pcro),
        .dout(insr_dout)
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
        reg decode_ready;

        ifmem_tb ckt_instance(
                .rst(p_reset),
                .clk(m_clock),
                .branch_taken(branch_taken),
                .branch_addr(branch_addr),
                .decode_ready(decode_ready)
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
                        branch_taken <= 1'b0;
                        branch_addr <= 32'b0;
                        decode_ready <= 1'b1;
                end else begin
                        if(counter == 32'd10000) begin
                                $finish;
                        end
                        if(counter == 32'd5) begin
                            branch_taken <= 1'b1;
                            branch_addr <= 32'd40;
                        end
                        if(counter == 32'd6) begin
                            branch_taken <= 1'b0;
                        end
                        if(counter == 32'd10) begin
                            decode_ready <= 1'b0;
                        end
                        if(counter == 32'd11) begin
                            decode_ready <= 1'b1;
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