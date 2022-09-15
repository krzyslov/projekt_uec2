//////////////////////////////////////////////////////////////////////////////////
// Company: Akademia Górniczo-Hutnicza w Krakowie
// Engineer: Maciej Warcholak, Benedykt Bekasiak
// Create Date: 15.09.2022 10:18:28
// Project Name: Ardudido
// Tool Versions: Vivado 2017.3
//////////////////////////////////////////////////////////////////////////////////

module Distance_meter(
    input wire clk_100MHz,
    input wire reset,
    output reg [8:0] distance_cm,
    output reg [4:0] speaker_note,
    input wire Echo_in,
    output reg Trig_out
    );
    
    reg [24:0] trig_cnt = 0;
    reg [24:0] trig_cnt_nxt = 0;
    reg [20:0] echo_cnt  = 0;
    reg [20:0] echo_cnt_nxt  = 0;
    reg [8:0] distance_cm_nxt = 0;
    reg [8:0] distance_buffer_cm = 0;
    reg [20:0] distance_buffer_nxt_cm = 0;
    reg [4:0] speaker_note_nxt;
    reg Trig_nxt  = 0;
    
    
    always @* begin
        if (trig_cnt <= 25'd100) begin
            trig_cnt_nxt = trig_cnt + 1;
            Trig_nxt = 1'b0;
        end else if (trig_cnt <= 25'd600) begin
            Trig_nxt = 1'b1;
            trig_cnt_nxt = trig_cnt + 1;
        end else if (trig_cnt <=  25'd12750000) begin
            trig_cnt_nxt = trig_cnt + 1;
            Trig_nxt = 1'b0;
        end else begin
            trig_cnt_nxt = 0;
            Trig_nxt = 1'b0;
        end
        
        
        if ( Echo_in == 1) begin
            echo_cnt_nxt = echo_cnt + 20'd2;
            distance_cm_nxt = echo_cnt/(11'd58*100);
            speaker_note_nxt = distance_buffer_cm[8:0] / 31;
        end else begin
            echo_cnt_nxt = 0;
            distance_cm_nxt = distance_buffer_cm;// / 11'd58;
            speaker_note_nxt = distance_buffer_cm[8:0] / 31;
        end
        
    end
    
    always @(posedge clk_100MHz) begin
           if(reset)begin
                distance_cm <= 0;
                Trig_out <= 0;
                echo_cnt <= 0;
                trig_cnt <= 0;
                speaker_note <= 0;
                distance_buffer_cm <= 0;
           end else begin
                distance_cm <= (distance_cm_nxt[8:0]);
                distance_buffer_cm <= distance_cm_nxt;
                Trig_out <= Trig_nxt;
                echo_cnt <= echo_cnt_nxt; 
                trig_cnt <= trig_cnt_nxt;
                speaker_note <= speaker_note_nxt;
           end
        end
    
endmodule