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
unidadcontrol unidad_control(clk, reset, zero, Opcode, s_inc, s_inm, we, wez, ALUOp);

// Reseteo y configuracion de salidas del tb
initial
begin
  $dumpfile("CPU_tb.vcd");
  $dumpvars;
  reset = 1;
  #30;
  reset = 0;
end

// Bucle de pruebas
initial
begin
  #30;
  $display("Prueba 1: LI");
  #30;
  $display("Prueba 2: ADI");
  #30;
  $display("Prueba 3: SBI");
  #30;
  $display("Prueba 4: ADD");
  #30;
  $display("Prueba 5: SUB");
  #30;
  $display("Prueba 6: AND");
  #30;
  $display("Prueba 7: OR");
  #30;
  $display("Prueba 8: XOR");
  #30;
  $finish;
end
endmodule