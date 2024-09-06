import os
import json
from globals import ARCHEV_PROMPTS, FUNCT_REF, llm,SYSTEM_PROMPTS,ARCHEV_TMP
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import functional_verification


def analyze(llm_path, context_length, gpu_layers):
    results = {} 
    for root , sub_dir, files in os.walk(ARCHEV_PROMPTS):
        for file in files:
                file_path = os.path.join(root, file)  
                file_name = os.path.splitext(file)[0]
                with open(file_path, "r") as p:
                    user_prompts = p.read() 
                llm_verilog_code=llm_response(SYSTEM_PROMPTS , user_prompts)
                with open(ARCHEV_TMP,'w') as tmp:
                    tmp.write(llm_verilog_code)
                          
                syntactical_verify = lint(llm_verilog_code)
                if syntactical_verify:
                # Find json and prompt file name
                    prompt_name = os.path.splitext(file[:-4])[0]
                    y = json.loads(file)
                    # json_name = os.path.splitext(file)[0]
                    
                # Perform functional verification if jason file is presen
                    functional_verify = functional_verification(llm_verilog_code, file[:-4]+".json")
                   
                else:
                     functional_verify = "failed"
            
            # Store the results in the dictionary
        results[id_count] = {
                "Prompt" : prompt_name,
                "syntactical_verification": syntactical_verify,
                "functional_verification": functional_verify
            }
        id_count += 1

    return results
                    