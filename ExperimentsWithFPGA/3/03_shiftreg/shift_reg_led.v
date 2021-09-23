module shift_reg_led #(
  parameter LED_N = 8
) (
  input wire clk,
  input wire rst,
  input wire ce_in,
  input wire d_in,
  output wire [LED_N-1:0]led
);
  reg ce_in_r, d_in_r;
  wire [LED_N-1:0]led_out;
  wire ce, ce_db;
  reg [LED_N-1:0]led_reg;
  assign led = led_reg;

  always@(posedge clk or negedge rst)
    if(!rst)
      begin
        ce_in_r <= 1'b0;
        d_in_r <= 1'b0;
        led_reg <= 1'b0;
      end 
  else
    begin
      ce_in_r <= ce_in;
      d_in_r <= d_in;
      led_reg <= led_out;
    end

  debounce #(.N(20)) db (
    .clk(clk),
    .rst(rst),
    .d(ce_in_r),
    .q(ce_db)
  );

  edge_detector ed (
    .clk(clk),
    .rst(rst),
    .d(ce_db),
    .q(ce)
  );

  shift_reg #(.N(LED_N)) sreg (
    .clk(clk),
    .rst(rst),
    .ce(ce),
    .d(d_in_r),
    .q(led_out)
  );
endmodule
