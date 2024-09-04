import subprocess
import tempfile
import os
import json


def save_verilog_to_file(verilog_code, filename):
    with open(filename, 'w') as file:
        file.write(verilog_code)


def run_verilog_simulation(verilog_code, test_input):
    testbench_code = f"""
module testbench;
    reg a;
    reg b;
    reg sel;
    wire y;

    mux2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        a = {test_input['a']};
        b = {test_input['b']};
        sel = {test_input['sel']};
        #10;
        $display("y = %b", y);
        $finish;
    end
endmodule
"""
    with tempfile.NamedTemporaryFile(delete=False, suffix=".v") as temp_file:
        temp_verilog_file = temp_file.name
        save_verilog_to_file(verilog_code + '\n' + testbench_code, temp_verilog_file)

    subprocess.run(['iverilog', '-o', 'simulation.out', temp_verilog_file], check=True, capture_output=True, text=True)
    result = subprocess.run(['vvp', 'simulation.out'], capture_output=True, text=True)

    os.remove(temp_verilog_file)
    os.remove('simulation.out')

    return result.stdout


def functional_verification(verilog_code, json_string):
    test_cases = json.loads(json_string)["test_cases"]

    for test_case in test_cases:
        test_input = test_case["input"]
        expected_output = test_case["expected_output"]

        output = run_verilog_simulation(verilog_code, test_input)

        output_dict = {}
        for line in output.strip().splitlines():
            if "y =" in line:
                _, value = line.split("=")
                output_dict["y"] = int(value.strip())

        if output_dict != expected_output:
            return 'failed'

    return 'passed'


verilog_code = """
module mux2to1 (
    input wire a,
    input wire b,
    input wire sel,
    output wire y
);

assign y = (sel) ? b : a;

endmodule
"""

json_string = """
{
    "test_cases": [
        {
            "input": {
                "a": 0,
                "b": 1,
                "sel": 0
            },
            "expected_output": {
                "y": 0
            }
        },
        {
            "input": {
                "a": 0,
                "b": 1,
                "sel": 1
            },
            "expected_output": {
                "y": 1
            }
        }
    ]
}
"""

result = functional_verification(verilog_code, json_string)
print(result)
