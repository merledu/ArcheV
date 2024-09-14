import os
import webview


ARCHEV_ROOT = os.path.dirname(os.path.abspath(__file__))
ARCHEV_PROMPTS = os.path.join(ARCHEV_ROOT, 'prompts')
ARCHEV_TMP = os.path.join(ARCHEV_ROOT, 'tmp')
FUNCT_REF = os.path.join(ARCHEV_ROOT, 'functional_verification')
TMP_VERILOG = os.path.join(ARCHEV_TMP, 'tmp.v')
SYSTEM_PROMPTS = "Write a Verilog module for the following module description"
TEST_BENCH = os.path.join(ARCHEV_ROOT, 'test_bench')


llm = None
window = webview.create_window(
        title = 'ArcheV',
        url = 'frontend/web/index.html',
        width = 1200,
        height = 600,
        resizable = False,
    ) 
