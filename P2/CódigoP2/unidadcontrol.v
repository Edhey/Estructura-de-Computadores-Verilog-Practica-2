module unidadcontrol #(parameter retardo = 1) (input wire clk, reset, wez_in,
                                               input wire [5:0] Opcode, 
                                               output wire s_inc, s_inm, we3, wez_out,
                                               output wire [2:0] ALUOp);
  
  always @(posedge clk, posedge reset) begin
    assign wez_out = wez_in;

    if (reset) begin
      s_inc = 1'b0;
      s_inm = 1'b0;
      we3 = 1'b0;
      ALUOp = 3'b000;
    end

    if (Opcode[5:2] == 4'b1111) begin
      case (Opcode[1:0])
        // Jump Incondicional (111100)
        2'b00: 
          s_inc = 1'b0;
        // JumpZero Condicional (Salta con 0) (111101)
        2'b01:
          s_inc = (wez_in == 0) ? 1 : 0;
        // JumpNotZero Condicional (Salta con 1) (111110)
        2'b10:
          s_inc = (wez_in == 0) ? 0 : 1;
        // Caso desconocido
        default: 
          s_inc = 1'bx;  
      endcase
    end

    // Instrucciones de operación aritmética o lógica No Inmediata
    if (Opcode[5] == 1'b0) begin
      //  El nuevo PC será el PC previo incrementado en 1 siempre
      s_inc = 1;
      s_inm = 0;
      we3 = 1;
      ALUOp = Opcode[4:2];
    end

    // Instrucciones de operación aritmética o lógica Inmediata
    case (Opcode[5:2])
      // LI (1000)
      4'b1000: 
        s_inm = 1;
        s_inc = 1;
        we3 = 1;
        ALUOp = 3'b000;

      // ADI (1001)
      4'b1001:    
        s_inm = 1;
        s_inc = 1;
        we3 = 1;
        ALUOp = 3'b010;

      // SBI (1010)
      4'b1010:    
        s_inm = 1;
        s_inc = 1;
        we3 = 1;
        ALUOp = 3'b011;

      // NAI (1011)
      4'b1011: 
        s_inm = 1;
        s_inc = 1;
        we3 = 1;
        ALUOp = 3'b110;

      // Caso desconocido
      default: 
        s_inc = 1'bx;
        s_inm = 1'bx;
        we3 = 1'bx;
        ALUOp = 3'bx;
    endcase
  end
endmodule