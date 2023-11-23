module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
//Microcontrolador sin memoria de datos de un solo ciclo
  wire [3:0] RA1, RA2, WA3, salida_mux_2;
  wire [7:0] Inm, RD1, RD2, WD3, salida_mux_3;
  wire [9:0] nuevo_pc, pc_actual, Dir_salto, salida_sum;
  wire [15:0] salida_memoria;
  wire zALU; // flag de zero

  sum(salida_sum, 10'b1, pc_actual);

  mux2 #(10) mux_1(nuevo_pc, Dir_salto, salida_sum);
  mux2 #(4) mux_2(salida_mux_2, RA1, WA3);
  mux2 #(8) mux_3(salida_mux_3, RD2, Inm);

  alu(zALU, WD3, salida_mux_3, RD1, ALUOp);

  ffd(clk, reset, zALU, wez, zero); // zALU valor wez Activador

  registro #(10)
endmodule
