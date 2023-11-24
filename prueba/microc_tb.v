`timescale 1 ns / 10 ps 
module microc_tb;
// declaracion de variables
reg clk, reset, s_inc, s_inm, we, wez;
reg [2:0] ALUOp;
wire [5:0] Opcode;
wire zero;


always
begin
  clk = 1;
  #30;
  clk = 0;
  #30;
end

//instanciacion del camino de datos
microc micro(Opcode, zero, clk, reset, s_inc, s_inm, we, wez, ALUOp);

// Reseteo y configuracion de salidas del tb
initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;
  #30;
  reset = 0;
end

// bloque simulacion seÃ±ales control por ciclo
initial
begin
  #30
  s_inm = 1;
  we = 1;
  ALUOp = 3'b000;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 1;
  we = 1;
  ALUOp = 3'b000;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 1;
  we = 1;
  ALUOp = 3'b000;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 1;
  we = 1;
  ALUOp = 3'b000;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 0;
  we = 1;
  ALUOp = 3'b010;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 0;
  we = 0;
  ALUOp = 3'b000;
  s_inc = 0;
  wez = 0;

  #60
  s_inm = 0;
  we = 1;
  ALUOp = 3'b010;
  s_inc = 1;
  wez = 1;
  
  #60
  s_inm = 1;
  we = 1;
  ALUOp = 3'b011;
  s_inc = 1;
  wez = 1;
  
  #60
  s_inm = 0;
  we = 0;
  ALUOp = 3'b000;
  s_inc = 0;
  wez = 0;

  #60
  s_inm = 0;
  we = 1;
  ALUOp = 3'b100;
  s_inc = 1;
  wez = 1;
  
  #60
  s_inm = 0;
  we = 0;
  ALUOp = 3'b000;
  s_inc = 1;
  wez = 0;

  #60
  s_inm = 1;
  we = 1;
  ALUOp = 3'b010;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 0;
  we = 1;
  ALUOp = 3'b010;
  s_inc = 1;
  wez = 1;

  #60
  s_inm = 1;
  we = 1;
  ALUOp = 3'b011;
  s_inc = 1;
  wez = 1;
  
  #60
  s_inm = 0;
  we = 0;
  ALUOp = 3'b000;
  s_inc = 1;
  wez = 0;
  
  #60
  s_inm = 0;
  we = 1;
  ALUOp = 3'b110;
  s_inc = 1;
  wez = 1;

  
  #60
  s_inm = 0;
  we = 0;
  ALUOp = 3'b000;
  s_inc = 0;
  wez = 0;
  $finish;
end
endmodule