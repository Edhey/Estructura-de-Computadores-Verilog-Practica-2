// Testbench para el microc
`timescale 1 ns / 10 ps 
module microc_tb;
// declaracion de variables
reg clk, reset;
wire s_inc, s_inm, we, wez;
wire [2:0] ALUOp;
wire [5:0] Opcode;
wire zero;

// señal de reloj
always
begin
  clk = 1;
  #30;
  clk = 0;
  #30;
end

//instanciacion del camino de datos
microc micro(Opcode, zero, clk, reset, s_inc, s_inm, we, wez, ALUOp);

//instanciacion de la unidad de control
unidadcontrol #(30) unidad_control(clk, reset, zero, Opcode, s_inc, s_inm, we, wez, ALUOp);

// Reseteo y configuracion de salidas del tb
initial
begin
  $dumpfile("CPU_tb.vcd");
  $dumpvars;
  reset = 1;
  #20;
  reset = 0;
end

// Bucle de pruebas
initial
begin
  #1100;
  $finish;
end
endmodule