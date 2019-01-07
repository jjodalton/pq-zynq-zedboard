parameter window_bits = 20 ;
module clock_measure (
	input clk_ref,    // Clock: at least 2x faster than the clock to be measured
	input clk_measure, // Clock Enable
	input rst_n,  // Asynchronous reset active low
	input enable,
	output measurement 
	);

reg [window_bits-1:0] count_ref ;
reg [window_bits-1:0] count_measure ;
reg [window_bits-1:0] measurement ;
reg prev_clk_measure ;

always @(posedge clk_ref or negedge rst_n)
begin
	if (!rst_n)
	begin
	 count_ref <= 0 ;
	 count_measure <= 0 ;
	 prev_clk_measure <= 0 ;
	 measurement <= 0 ; // redundant due to behaviour below, but nicer for checking from up
	end 
	else if(enable)
		begin
			prev_clk_measure <= clk_measure ;
			count_ref <= count_ref + 1 ;
			if (count_ref == 0) measurement <= count_measure ;
			if (clk_measure && !prev_clk_measure) count_measure <= count_measure + 1 ;
		end
end


endmodule