import os


ARCHEV_ROOT = os.path.dirname(os.path.abspath(__file__))
ARCHEV_PROMPTS = os.path.join(ARCHEV_ROOT, 'prompts')
ARCHEV_TMP = os.path.join(ARCHEV_ROOT, 'tmp')
FUNCT_REF = os.path.join(ARCHEV_ROOT, 'functional_verification')


llm = None

