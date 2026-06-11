module de10lite_real_encoder_hex0 (
    input  wire       MAX10_CLK1_50,
    input  wire [1:0] ENC,
    output reg  [6:0] HEX0
);

    reg enc0_sync_0 = 1'b0;
    reg enc0_sync_1 = 1'b0;
    reg enc1_sync_0 = 1'b0;
    reg enc1_sync_1 = 1'b0;

    reg enc0_prev = 1'b0;

    reg [7:0] edge_count = 8'd0;
    reg [3:0] display_count = 4'h0;

    always @(posedge MAX10_CLK1_50) begin
        // Synchronise encoder inputs
        enc0_sync_0 <= ENC[0];
        enc0_sync_1 <= enc0_sync_0;
        enc1_sync_0 <= ENC[1];
        enc1_sync_1 <= enc1_sync_0;

        // Count only on rising edge of channel A
        if (enc0_prev == 1'b0 && enc0_sync_1 == 1'b1) begin
            if (edge_count == 8'd15) begin
                edge_count <= 8'd0;

                if (enc1_sync_1 == 1'b0)
                    display_count <= display_count + 1'b1;
                else
                    display_count <= display_count - 1'b1;
            end else begin
                edge_count <= edge_count + 1'b1;
            end
        end

        enc0_prev <= enc0_sync_1;
    end

    always @(*) begin
        case (display_count)
            4'h0: HEX0 = 7'b1000000;
            4'h1: HEX0 = 7'b1111001;
            4'h2: HEX0 = 7'b0100100;
            4'h3: HEX0 = 7'b0110000;
            4'h4: HEX0 = 7'b0011001;
            4'h5: HEX0 = 7'b0010010;
            4'h6: HEX0 = 7'b0000010;
            4'h7: HEX0 = 7'b1111000;
            4'h8: HEX0 = 7'b0000000;
            4'h9: HEX0 = 7'b0010000;
            4'hA: HEX0 = 7'b0001000;
            4'hB: HEX0 = 7'b0000011;
            4'hC: HEX0 = 7'b1000110;
            4'hD: HEX0 = 7'b0100001;
            4'hE: HEX0 = 7'b0000110;
            4'hF: HEX0 = 7'b0001110;
            default: HEX0 = 7'b1111111;
        endcase
    end

endmodule