module pixeled_display(
	input [3:0] pixel_r, pixel_g, pixel_b,
	input en,v_disp,h_disp,clk,reset,
	//input cursor, score, gameover, congrats, gameover_en, congrats_en, v_disp, h_disp, on, clk, med, hard, xhard,
	output [11:0] RGB
);

	//temporary method, needs to be replaced by better solution
	
        //assign RGB = (on)?(v_disp&h_disp)?(gameover_en)?((gameover)?12'd4095:12'd3840):(congrats_en)?((congrats)?12'd4095:12'd15):(cursor)?12'd4095:(score)?12'd4095:(F1)?F1:(F2)?F2:(F3)?F3:((xhard)?12'h0ff:(hard)?12'h0fa:(med)?12'h0f6:12'h0f0):12'd0:12'd0;
    assign RGB =(v_disp & h_disp & en) ? {pixel_r,pixel_g,pixel_b} : 0 ;  
endmodule //COLOR_DISPLAY