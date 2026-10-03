//half adder
module hadd(
    input x,y,
    output  sum,cout
);
assign sum=x^y;
assign cout=x&y;
endmodule