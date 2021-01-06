module mux_4to1(
// after 'module' keyword we have name of our module and and ports list. 
  input [3:0] a,
// "input [3:0] a" it define four elements "a" table. Why four element not five or two? Because thanks to this we can assign up to "a" 0b1111 numbers. 0b1111 in dec is 15. So we can assign up to 15.
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
// Ok. "a", "b", "c" and "d" are our inputs. In multiplexer we can select which input we want on our output. We have four inputs. If we want first input it'll be 0b00, second: 0b01, third: 0b10, fourth 0b11. Thanks to this our selector should be two element table.
  input [1:0] sel,
  output [3:0] out // If input is four element table, so output also should be.
);
  assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a); // Explained on the end of file
endmodule // the end of module

/*
assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);

It's easy to understand. The truth table for mux looks like:
| s1| s0|out|
-------------
| 0 | 0 | a |
| 0 | 1 | b |
| 1 | 0 | c |
| 1 | 1 | d |
This truth table in png: https://user-images.githubusercontent.com/43972902/103803417-d0770980-5050-11eb-92b1-65bae9c80bae.png

So sel[1] means "if(sel[1] == 1)" then... 
sel[1] is our input "s1" or "s0". For "if(sel[1] == 1)" we have two possibilities, when
"s0" is equal 0 or 1. So "if(sel[1] == 1)" then "(sel[0] ? d : c)" in this case 
if "s0" is equal 1 then "out" is equal "d" otherwise "out" is equal "c".
*/
