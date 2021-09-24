module encoder #(
  parameter LED_N = 8,
  parameter DEBONUCE_N = 14
) (
  input wire clk,
  input wire rst,
  input wire a,
  input wire b,
  output wire [LED_N-1:0]led
);
  wire a_r;
  reg a_r_q;
  assign a_r = a_r_q;
  wire b_r;
  reg b_r_q;
  assign b_r = b_r_q;
  reg [LED_N-1:0]led_reg;
  assign led = led_reg;
  
  wire [LED_N-1:0]led_out;
  wire a_d, a_e, b_d;

  always@(posedge clk or negedge rst)
    if (!rst) begin
      a_r_q <= 0;
      b_r_q <= 0;
      led_reg <= 0;
    end 
  else 
    begin
      a_r_q <= a;
      b_r_q <= b;
      led_reg <= led_out;
    end

  debounce #(.N(DEBONUCE_N)) db_a (
    .clk(clk),
    .rst(rst),
    .d(a_r),
    .q(a_d)
  );

  debounce #(.N(DEBONUCE_N)) db_b (
    .clk(clk),
    .rst(rst),
    .d(b_r),
    .q(b_d)
  );

  edge_detector ed_a (
    .clk(clk),
    .rst(rst),
    .d(a_d),
    .q(a_e)
  );

  counter_dir #(.N(LED_N)) dut (
    .clk(clk),
    .rst(rst),
    .ce(a_e),
    .dir(b_d),
    .q(led_out)
  );
endmodule
