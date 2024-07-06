module cdc_bit_sync #(
    parameter SYNC_DEPTH    = 2,
    parameter MCP_DELAY     = 2
)(
    input logic     clk,
    input logic     d_in,
    output logic    q_out
)

logic [MCP_DELAY-1:0] d_temp;

always_ff @(posedge clk) begin
    d_temp[0] <= d_in;
end

generate for (genvar i=1; i<SYNC_DEPTH; i++) begin
    always_ff @(posedge clk) begin
        d_temp[i] <= d_temp[i-1];
end endgenerate

endmodule