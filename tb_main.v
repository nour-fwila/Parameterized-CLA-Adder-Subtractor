module cla_tb #(parameter WIDTH =4 ) ();
    reg signed  [WIDTH-1:0]A;
    reg signed  [WIDTH-1:0]B;
    reg mode;
    wire signed  [WIDTH-1:0] Sum;
    wire Cout;
    wire Overflow;
    wire [WIDTH-1:0] P;
    wire [WIDTH-1:0] G;
    cla_add_sub #(.WIDTH(WIDTH)) uut (
        .A(A),
        .B(B),
        .mode(mode),
        .Sum(Sum),
        .Cout(Cout),
        .Overflow(Overflow),
        .P(P),
        .G(G)
    );
    initial begin
        $dumpfile("cla_add_sub_tb.vcd");
        $dumpvars(0, cla_tb);
    end
    initial begin
        $monitor("%4t |   %b  | %d | %d | %d  |  %b   |    %b", 
                 $time, mode, A, B, Sum, Cout, Overflow);
        A = 4'sd5;
        B=4'sd3;
        mode = 1'b0;
        #10;
        A=4'sd6;
        B=-4'sd3;
        #10;
        A=4'sd2;
        B=4'sd8;
        #10;
        mode = 1'b1;
        #10;
        $finish;

    end

endmodule
