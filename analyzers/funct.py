import subprocess
import tempfile
import os
import json


from globals import FUNCT_REF

def save_verilog_to_file(verilog_code, filename):
    with open(filename, 'w') as file:
        file.write(verilog_code)


def run_verilog_simulation(verilog_code, test_input):

    subprocess.run(['iverilog', '-o', 'simulation.out', temp_verilog_file], capture_output=True, text=True)
    result = subprocess.run(['vvp', 'simulation.out'], capture_output=True, text=True)
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
result = functional_verification(verilog_code, json_string)
print(result)
