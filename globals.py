import os
windows = {}
llm = None
ARCHEV_ROOT = os.path.dirname(os.path.abspath(__file__))
ARCHEV_PROMPTS = os.path.join(ARCHEV_ROOT, 'prompts')
ArcheV_json_files = os.path.join(ARCHEV_ROOT, 'functional_verification')