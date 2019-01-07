parameter count_width = 10 ;
module pwm_generator(
    input clk,
    input reset_n,
    input [count_width-1:0] period,
    input [count_width-1:0] start_low,
    input [count_width-1:0] start_high,
    input [count_width-1:0] end_low,
    input [count_width-1:0] end_high,
    output pwm_low,
    output pwm_high
    );
    
    
reg [count_width-1:0] counter ;
reg pwm_low ;
reg pwm_high ;

always @(posedge clk)
begin
    // active low reset
    if (!reset_n) begin
        counter <= 0 ;
        pwm_low <= 0 ;
        pwm_high <= 0 ;
    end
    else begin
        if (counter == period) counter <= 0 ;
        else counter <= counter + 1 ;
        
        if (counter == end_low) pwm_low <= 0 ; // give safe 'off' state preference
        else if (counter == start_low) pwm_low <= 1 ;
        
        if (counter == end_high) pwm_high <= 0 ; // give safe 'off' state preference
        else if (counter == start_high) pwm_high <= 1 ; 
    end

end
endmodule