module unidadcontrol #(parameter retardo = 1) (input wire clk, reset, zero,
                                               input wire [5:0] Opcode, 
                                               output reg s_inc, s_inm, we3, wez_out,
                                               output reg [2:0] ALUOp);
  
  always @(posedge clk, posedge reset) begin
    #retardo

    // if (reset) begin
    //   s_inc = 1'b1;
    //   s_inm = 1'bx;
    //   we3 = 1'bx;
    //   wez_out = 1'bx; 
    //   ALUOp = 3'bxxx;
    // end 
    // else begin
      
    if (Opcode[5:2] == 4'b1111) begin
      case (Opcode[1:0])
        // Jump Incondicional (111100)
        2'b00: 
        begin
          s_inc = 1'b0;
          we3 = 1'b0;
          s_inm = 1'b0;
          wez_out = 1'b0;
          ALUOp = 3'b000;
        end
        // JumpZero Condicional (Salta con flag de zero) (111101)
        2'b01:
        begin
          s_inc = ~zero;
          we3 = 1'b0;
          s_inm = 1'b0;
          wez_out = 1'b0;
          ALUOp = 3'b000;          
        end
        // JumpNotZero Condicional (Salta sin flag de zero) (111110)
        2'b10:
        begin
          s_inc = zero;
          we3 = 1'b0;
          s_inm = 1'b0;
          wez_out = 1'b0;
          ALUOp = 3'b000;
        end
        // Caso desconocido
        default:
        begin
          s_inc = 1'bx;  
          we3 = 1'bx;
          s_inm = 1'bx;
          we3 = 1'bx;
          wez_out = 1'bx;
          ALUOp = 3'bxxx;
        end
      endcase
    
    // Instrucciones de operación aritmética o lógica No Inmediata
    end else if (Opcode[5] == 1'b0) begin
      //  El nuevo PC será el PC previo incrementado en 1 siempre
      s_inc = 1;
      s_inm = 0;
      we3 = 1;
      wez_out = 1'b1;
      ALUOp = Opcode[4:2];
    // Instrucciones de operación aritmética o lógica Inmediata
    end else begin
      case (Opcode[5:2])
        // LI (1000)
        4'b1000: 
        begin
          s_inm = 1;
          s_inc = 1;
          we3 = 1;
          ALUOp = 3'b000;
          wez_out = 1'b0;
        end
    
        // ADI (1001)
        4'b1001:    
        begin
          s_inm = 1;
          s_inc = 1;
          we3 = 1;
          ALUOp = 3'b010;
          wez_out = 1'b1;
        end
    
        // SBI (1010)
        4'b1010:    
        begin
          s_inm = 1;
          s_inc = 1;
          we3 = 1;
          ALUOp = 3'b011;
          wez_out = 1'b1;
        end
    
        // NAI (1011)
        4'b1011: 
        begin
          s_inm = 1;
          s_inc = 1;
          we3 = 1;
          ALUOp = 3'b110;
          wez_out = 1'b1;
        end
    
        // Caso desconocido
        default: 
        begin
          s_inc = 1'bx;
          s_inm = 1'bx;
          we3 = 1'bx;
          ALUOp = 3'bx;
          wez_out = 1'bx;
        end
      endcase
    end
  end
endmodule