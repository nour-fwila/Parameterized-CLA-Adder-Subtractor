module ci_one #(parameter WIDTH =4 ) (
input [WIDTH-1:0]P,
input [WIDTH-1:0]G,
input cin,
output [WIDTH:0]C
);

assign C[0] = cin;

genvar i;
generate
    for(i=0;i<WIDTH;i=i+1) 
    begin: loop
        assign C[i+1] = G[i] | P[i] & C[i]; 
    end
endgenerate
endmodule