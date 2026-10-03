
module cla_add_sub #(parameter WIDTH =4 ) (
    input [WIDTH-1:0]A,
    input [WIDTH-1:0]B,
    input mode,
    output [WIDTH-1:0] Sum,
    output Cout,
    output Overflow,
    output [WIDTH-1:0] P,
    output [WIDTH-1:0] G
);
wire [WIDTH-1:0]B_xored;
assign B_xored = B^{WIDTH{mode}};
genvar i;
generate
    for(i=0;i<WIDTH;i=i+1)
    begin: hadd_loop
    hadd adding_in (
        .x(A[i]),
        .y(B_xored[i]),
        .sum(P[i]),
        .cout(G[i])
    ); 
    end
endgenerate
wire [WIDTH:0]c_inext;
    ci_one #(.WIDTH(WIDTH)) ci(
        .P(P),
        .G(G),
        .cin(mode),
        .C(c_inext)
    ); 
assign Sum = P^c_inext[WIDTH-1:0];
assign Cout = c_inext[WIDTH];
assign Overflow = (A[WIDTH-1] & B_xored[WIDTH-1] & ~Sum[WIDTH-1]) | (~A[WIDTH-1] & ~B_xored[WIDTH-1] & Sum[WIDTH-1]);
endmodule
