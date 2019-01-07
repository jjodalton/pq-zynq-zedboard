module clock_select(reset_n, vco_clock, manual_clock, clock_select, clock_out) ;

input vco_clock ;
input manual_clock ;
input clock_select ;
input reset_n ;
output clock_out ;

reg clock_gate ;


always @(posedge vco_clock or negedge reset_n)
begin
	if (!reset_n) clock_gate <= 1'b0 ;
	else clock_gate <= clock_select ;
end

assign clock_out = clock_gate ? manual_clock : vco_clock ;


endmodule