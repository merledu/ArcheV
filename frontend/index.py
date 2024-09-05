import os

from globals import ARCHEV_PROMPTS, FUNCT_REF, llm,SYSTEM_PROMPTS,ARCHEV_TMP
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import funct




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
                          
                syntactical_verification = lint(ARCHEV_TMP)
                if syntactical_verification == "passed":
                # Find json and prompt file name
                    prompt_name_without_extension = remove_extension(prompts_filename)
                json_str = None
                # shayan bhai ko check krwana hai kai json_str = json_files.get(prompt_name_without_extension, None)
                for j, json_file in enumerate(json_files):
                    json_name_without_extension = remove_extension(json_files[j])
                    if prompt_name_without_extension == json_name_without_extension:
                        json_str = json_file
                        break
                
                # Perform functional verification if jason file is present
                if json_str:
                    functional_verification = funct.functional_verification(llm_verilog_code, json_str)
                else:
                    functional_verification = "failed"
        else:
                functional_verification = "failed"

            # Store the results in the dictionary
                results[prompt_name_without_extension] = {
                "syntactical_verification": syntactical_verification,
                "functional_verification": functional_verification
            }

    return results
                    