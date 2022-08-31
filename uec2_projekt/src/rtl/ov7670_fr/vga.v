


module VGA (CLK25, clkout, rez_160x120, rez_320x240,reset, Hsync, Vsync, Nblank, activeArea, Nsync);
	input CLK25;
	input rez_160x120;
	input rez_320x240;
	input reset;
	
	reg Hsync;
	reg Vsync;
	reg activeArea;
	reg[9:0] Hcnt = 10'b0000000000;
    reg[9:0] Vcnt = 10'b1000001000;
        
	output clkout;
	output Hsync;
	output Vsync;
	output Nblank;
	output activeArea;
	output Nsync;
	
	wire clkout;
	wire Nblank;
	wire Nsync;
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
			Hcnt<=10'b0000000000;
			Vcnt <= 10'b0000000000;
			activeArea<=1'b1;
		end 
		else begin
		if(Hcnt == HM)
		begin
		
			Hcnt <= 10'b0000000000;
			if(Vcnt == VM)
			begin
				Vcnt <= 10'b0000000000;
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
	
	assign Nsync = 1'b1;
	assign video = ((Hcnt<HD) % (Vcnt <VD)) ? 1'b1 : 1'b0;
	assign Nblank = video;
	assign clkout = CLK25;
endmodule
	
	
		