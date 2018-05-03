/* verilator lint_off DECLFILENAME */
/* verilator lint_off WIDTH */

module tvmix_calc(clk, palentry, cc_i, cc_q);
//initial begin

	input clk;
	input reg [32-1:0] palentry;
	input reg signed[16-1:0] cc_i;
	input reg signed[16-1:0] cc_q;

always @ (posedge clk)
begin
	reg [16-1:0] pal_luma;
	reg signed [8-1:0] pal_imix;
	reg signed [8-1:0] pal_qmix;

	reg signed[16-1:0] ires;
	reg signed[16-1:0] qres;

	reg [16-1:0] video;


	//palentry = 32'hf000007f;

	// extract bits
	pal_luma <= (palentry >> 16) & 16'hFFFF;
	pal_imix <= (palentry >> 8)  & 8'hFF;
	pal_qmix <= (palentry >> 0)  & 8'hFF;

	$display("luma: %d", pal_luma);
	$display("imix: %d", pal_imix);
	$display("qmix: %d", pal_qmix);


	// incoming color carrier components
	$display("cc_i: %d, cc_q %d", cc_i, cc_q);

	// modulate by palette values
	//ires = ($signed({{0{pal_imix[7]}}, pal_imix[7:0]}) * cc_i) / 64;
	ires = ($signed(pal_imix[7:0]) * cc_i) / 64;
	qres = ($signed(pal_qmix[7:0]) * cc_q) / 64;


	//ires = (pal_imix * cc_i) / 64;
	//qres = (pal_qmix * cc_q) / 64;

	//ires = (pal_imix[7:0] * cc_i) / 64;


	// calculate and print results
	$display("ires: %d, qres: %d", ires, qres);

	video = ires;
	video = pal_luma + ires + qres;

	$display("video: 0x%X", video);


	//$finish;
end
endmodule // hello_world


