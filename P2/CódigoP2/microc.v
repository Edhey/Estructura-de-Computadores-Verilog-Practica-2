// Himar Edhey Hernández Alonso y Aarón Jano Barreto

module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
//Microcontrolador sin memoria de datos de un solo ciclo
  wire [3:0] RA1, RA2, WA3, salida_mux_2;
  wire [7:0] Inm, RD1, RD2, WD3, salida_mux_3;
  wire [9:0] nuevo_pc, pc_actual, Dir_salto, salida_sum;
  wire [15:0] salida_memoria;
  wire zALU; // flag de zero

  assign Opcode = salida_memoria[15:10];
  // Instrucción de operación aritmética o lógica:
  assign RA1 = salida_memoria[11:8];
  assign RA2 = salida_memoria[7:4];
  assign WA3 = salida_memoria[3:0];
  // Instrucción de operación aritmética o lógica con constante inmediata:
  assign Inm = salida_memoria[11:4];
  // Instrucciones de saltos (absolutos):
  assign Dir_salto = salida_memoria[9:0];

  sum sum_pc(salida_sum, 10'b1, pc_actual);

  mux2 #(10) mux_1(nuevo_pc, Dir_salto, salida_sum, s_inc);
  mux2 #(4) mux_2(salida_mux_2, RA1, WA3, s_inm);
  mux2 #(8) mux_3(salida_mux_3, RD2, Inm, s_inm);

  alu ALU(WD3, zALU, RD1, salida_mux_3, ALUOp);

  ffd biestable_d(clk, reset, zALU, wez, zero); // Comprobar wez

  registro #(10) PC(pc_actual, clk, reset, nuevo_pc);

  regfile banco_registros(RD1, RD2, clk, we, salida_mux_2, RA2, WA3, WD3);

  memprog memoria_de_programa(salida_memoria, clk, pc_actual);

endmodule