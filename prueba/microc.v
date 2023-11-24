module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
//Microcontrolador sin memoria de datos de un solo ciclo
  wire [9:0] Dir_salto, nuevo_PC, PC_actual, sum_aux;
  wire [7:0] Inm, RD2, RD1, WD3, mux_3_out;
  wire [3:0] RA1, WA3, RA2, mux_2_out;
  wire [15:0] Salida_mem;

  assign Dir_salto = Salida_mem[9:0]; 

  memprog memoria(Salida_mem, clk, PC_actual);
  sum sumador(sum_aux, PC_actual, 10'b0000000001);
  mux2#(10) mux_1(nuevo_PC, Dir_salto, sum_aux, s_inc);
  registro#(10) PC(PC_actual, clk, reset, nuevo_PC);

  assign Opcode = Salida_mem[15:10];
  assign Inm = Salida_mem[11:4];
  assign RA2 = Salida_mem[7:4];
  assign WA3 = Salida_mem[3:0];
  assign RA1 = Salida_mem[11:8];

  mux2#(4) mux_2(mux_2_out, RA1, WA3, s_inm);
  regfile banco(RD1, RD2, clk, we, RA1, RA2, WA3, WD3);
  mux2#(8) mux_3(mux_3_out, RD2, Inm, s_inm);
  wire zALU;
  alu alu_(WD3, zALU, RD1, mux_3_out, ALUOp);
  ffd biestable(clk, reset, wez, zALU, zero);
endmodule