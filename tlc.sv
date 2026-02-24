module traffic_light (
    input  logic clk,
    input  logic rst,
    output logic [2:0] light
);

    typedef enum logic [1:0] {
        RED,
        GREEN,
        YELLOW
    } state_t;

    state_t state, next_state;

    // -------------------------
    // State register
    // -------------------------
    always_ff @(posedge clk) begin
        if (rst)
            state <= RED;
        else
            state <= next_state;
    end

    // -------------------------
    // Next-state logic
    // -------------------------
    always_comb begin
        case (state)
            RED:    next_state = GREEN;
            GREEN:  next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end

    // -------------------------
    // Output logic
    // -------------------------
    always_comb begin
        case (state)
            RED:    light = 3'b100;
            GREEN:  light = 3'b001;
            YELLOW: light = 3'b010;
            default: light = 3'b100;
        endcase
    end

endmodule
