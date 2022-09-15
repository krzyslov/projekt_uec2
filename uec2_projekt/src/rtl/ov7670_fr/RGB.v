//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia GÛrniczo-Hutnicza w Krakowie
// Engineer: Maciej Warcholak
// èrÛd≥o modu≥u: https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html
// T≥umaczone z jÍzyka vhdl i przerabiane do poprawnego dzia≥ania oraz dodatkowo modyfikowane dla
// nowych funkcjonalnoúci
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

module RGB (Din, Nblank, reset, R, G, B,Grayscale);

   input[11:0] Din;
   input Nblank; 
   input reset;
   output [7:0] R ; 
   wire[7:0] R;
   output [7:0] G ; 
   wire [7:0] G;
   output [7:0] B ; 
   wire [7:0] B;
   output [7:0] Grayscale ; 
   wire [7:0] Grayscale; 

   assign R = (Nblank == 1'b1 && reset == 1'b0) ? {Din[11:8], Din[11:8]} : 8'b00000000 ;
   assign G = (Nblank == 1'b1 && reset == 1'b0) ? {Din[7:4], Din[7:4]} : 8'b00000000 ;
   assign B = (Nblank == 1'b1 && reset == 1'b0 ) ? {Din[3:0], Din[3:0]} : 8'b00000000 ;
   assign Grayscale = (Nblank == 1'b1 && reset == 1'b0 ) ? {16*(Din[11:8] + Din[7:4] + Din[3:0])/3} : 8'b00000000 ; 
    

    

endmodule
