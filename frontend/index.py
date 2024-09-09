import os
import json

from globals import ARCHEV_PROMPTS, SYSTEM_PROMPTS, TMP_VERILOG
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import functional_verification


def analyze(llm_path, context_length, gpu_layers):
    load_llm(llm_path, context_length, gpu_layers)
    results = {} 
    
    for root, sub_dir, files in os.walk(ARCHEV_PROMPTS):
        for id_count, file in enumerate(files):
            file_path = os.path.join(root, file)  
            file_name = os.path.splitext(file)[0]
            with open(file_path, "r", encoding="utf-8") as p:
                user_prompt = p.read() 
            llm_verilog_code = llm_response(SYSTEM_PROMPTS, user_prompt)
            with open(TMP_VERILOG,'w', encoding="utf-8") as tmp:
                tmp.write(llm_verilog_code)
            verify_syntactically = lint(llm_verilog_code)  
            verify_functionally = verify_syntactically(file_name) if verify_syntactically else False       
        results[id_count] = {
            "Prompt" : file_name,
            "syntactical_verification": verify_syntactically,
            "functional_verification": verify_functionally
        }
    return results