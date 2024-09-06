import subprocess
import json

from globals import ARCHEV_TMP, TEST_BENCH, FUNCT_REF


def save_verilog_to_file(verilog_code, filename):
    with open(filename, 'w') as file:
        file.write(verilog_code)


def functional_verification(file_name):
    test_cases = json.load(file_name)["test_cases"]
    with open(TEST_BENCH, 'r', encoding = "uft-8") as r:
        for test_case in test_cases:
            test_input = test_case["input"]
            expected_output = test_case["expected_output"]
            subprocess.run(['iverilog', '-o', 'simulation.out', r.read()], capture_output=True, text=True)
            result = subprocess.run(['vvp', 'simulation.out'], capture_output=True, text=True)
            output = result.stdout
            output_dict = {}
            for line in output.strip().splitlines():
                if "y =" in line:
                    _, value = line.split("=")
                    output_dict["y"] = int(value.strip())
            if output_dict != expected_output:
                return 'failed'
        return 'passed'

