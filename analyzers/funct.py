import subprocess
import json
import os

from globals import ARCHEV_TMP, TEST_BENCH, FUNCT_REF


def functional_verification(file_name):
    test_cases = json.load(os.path.join(FUNCT_REF , file_name + '_tb.v'))["test_cases"]
    test_bench = os.path.join(TEST_BENCH , file_name + '_tb.v')
    llm_code = os.path.join(ARCHEV_TMP , file_name + '.v')

    for test_case in test_cases:
            test_input = test_case["input"]
            expected_output = test_case["expected_output"]
            subprocess.run(['iverilog', '-o', 'simulation.out', test_bench, llm_code], capture_output=True, text=True)
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

