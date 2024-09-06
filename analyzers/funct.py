import subprocess
import json
import os

from globals import TMP_VERILOG, TEST_BENCH, FUNCT_REF, ARCHEV_TMP


def functional_verification(file_name):
    test_cases = json.load(os.path.join(FUNCT_REF, file_name+'.json'))["test_cases"]
    test_bench = os.path.join(TEST_BENCH, file_name+'_tb.v')

    expected_outputs = [list(case['expected_output'].values())[0] for case in test_cases['test_cases']]
    exp_out = [str(item) if isinstance(item, int) else item for item in expected_outputs]

    for test_case in test_cases:
            subprocess.run(['iverilog', '-o', os.path.join(ARCHEV_TMP,'.out'), test_bench, TMP_VERILOG], capture_output=True, text=True)
            result = subprocess.run(['vvp', 'simulation.out'], capture_output=True, text=True)
            output = result.stdout
            output_array=output.split('\n')
            json_result_arr = []
            for x in output_array:
                  json_result_arr += x.strip()

            if exp_out==json_result_arr[:-1]:
                return True
            else:
                return False


