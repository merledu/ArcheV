import os

from globals import ARCHEV_PROMPTS, FUNCT_REF, llm,SYSTEM_PROMPTS,ARCHEV_TMP
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import functional_verification
import functional_verification
import json



def read_file_content(file):
    
        return file.read().strip()


def read_files_from_directory(directory_path, extension):
    filenames = []
    contents = []

    # Check if the directory exists
    if not os.path.exists(directory_path):
        return filenames, contents

    # List files in the directory
    files_in_directory = os.listdir(directory_path)

    for filename in files_in_directory:
        if filename.endswith(extension):
            file_path = os.path.join(directory_path, filename)
            content = read_file_content(file_path)
            filenames.append(filename)
            contents.append(content)
    return contents, filenames


def analyze(llm_path, context_length, gpu_layers):
    results = {} 
    
    for root,sub_dir,files in os.walk(ARCHEV_PROMPTS):
            for file in files:
                id_count=0
                user_propmpts = read_file_content(file)
                llm_verilog_code=llm_response(SYSTEM_PROMPTS,user_propmpts)

                with open(ARCHEV_TMP,'w') as tmp:
                    tmp.write(llm_verilog_code)
                    #    name change   krna hai 
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
                    