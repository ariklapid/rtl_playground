//
//
// Author:	ariklapid7
// Last update:	2024, July 03
//
//
module sync2d (
	input logic	clk,
	input logic	d_in,
	output logic	q_out
);

`ifndef SYNTH

localparam int RANDOM_DELAY = ($urandom % 3) + 1;
logic [RANDOM_DELAY-1:0] d_temp;
logic [RANDOM_DELAY-1:0] q_temp;


// One sample is always there
always_ff @(posedge clk) begin
	q_temp[0] <= d_in;
end

generate for (genvar i=1; i<RANDOM_DELAY; i++) begin: g_sync2d_rndm_dly
	always_ff @(posedge clk) begin
		q_temp[i] <= q_temp[i-1];
	end
end endgenerate

assign q_out = q_temp[RANDOM_DELAY-1];

`else
sync2d_libcell sync2d_libcell (
	.clk	(clk),
	.d_in	(d_in),
	.q_out	(q_out)
);
`endif


endmodule
