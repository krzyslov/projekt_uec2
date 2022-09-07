module VGA (
input wire CLK25,
output wire clkout, 
input wire rez_160x120,
input wire rez_320x240,
input wire reset, 
output reg Hsync,
output reg Vsync, 
output wire Nblank, 
output reg activeArea, 
output wire Nsync,
output reg [10:0] Hcnt_out,
output reg [10:0] Vcnt_out
);

	
	reg[10:0] Hcnt = 11'b0000000000;
    reg[10:0] Vcnt = 11'b1000001000;
        
	wire video;
	
	parameter HM = 799;
	parameter HD = 640;
	parameter HF = 16;
	parameter HB = 48;
	parameter HR = 96;
	parameter VM = 524;
	parameter VD = 480;
	parameter VF = 10;
	parameter VB = 33;
	parameter VR = 2;
	
	always @(posedge CLK25)
	begin
		if (reset ==1'b1) begin
			Hcnt<=11'b00000000000;
			Vcnt <= 11'b00000000000;
			activeArea<=1'b1;
		end 
		else begin
		if(Hcnt == HM)
		begin
		
			Hcnt <= 11'b00000000000;
			if(Vcnt == VM)
			begin
				Vcnt <= 11'b00000000000;
				activeArea <= 1'b1;
			end
			else
			begin
				if(rez_160x120 == 1'b1)
				begin
					if(Vcnt < 120 - 1)
					begin
						activeArea <= 1'b1;
					end
				end
				else if(rez_320x240 == 1'b1)
				begin
					if(Vcnt < 240 - 1)
					begin
						activeArea <= 1'b1;
					end
				end
				else
				begin
				    if( Vcnt < 480 - 1)
				    begin 
				        activeArea <= 1'b1;
				    end
			    end
			    Vcnt <= Vcnt + 1;
			end 
		end
		else
		begin
		  if(rez_160x120 == 1'b1)
		  begin
		      if(Hcnt == 160 - 1)
		      begin
		          activeArea <= 1'b0;
		      end
		  end
            else if( rez_320x240 == 1'b1 ) 
            begin
                if(Hcnt == 320 - 1)
                begin
                    activeArea <= 1'b0;
                end
            end
            else
            begin
                if(Hcnt == 640 - 1)
                begin
                    activeArea <= 1'b0;
                end
            end
            Hcnt<=Hcnt+1;
        end
	end
	end
	
	always @(posedge CLK25)
	begin
	
		if(reset == 1'b1) begin
			Hsync<=1'b1;
		end
		else begin
		if(Hcnt>=(HD+HF) & Hcnt <= (HD + HF + HR - 1))
		begin
			Hsync <= 1'b0;
		end
		else
		begin
			Hsync <= 1'b1;
		end
	end
	end
	
	
	always @(posedge CLK25)
	begin
		if(reset == 1'b1)begin
			Vsync <=1'b1;
		end
		else begin
		if(Vcnt >= (VD+VF) & Vcnt <= (VD +VF +VR - 1))
		begin
			Vsync <= 1'b0;
		end
		else
		begin
			Vsync <= 1'b1;
		end
	end
	end
	
	always @(posedge CLK25)
	begin
	   if(reset == 1'b1)begin
            Hcnt_out <=11'd0;
            Vcnt_out <= 11'd0;
       end else begin
            Hcnt_out <= Hcnt;
            Vcnt_out <= Vcnt;
       end
	end
	
	assign Nsync = 1'b1;
	assign video = ((Hcnt<HD) % (Vcnt <VD)) ? 1'b1 : 1'b0;
	assign Nblank = video;
	assign clkout = CLK25;
endmodule