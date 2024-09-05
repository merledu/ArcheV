import os

from globals import ARCHEV_PROMPTS, FUNCT_REF, llm,SYSTEM_PROMPTS,ARCHEV_TMP
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import functional_verification
import functional_verification
import json



<<<<<<< HEAD
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
=======

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
>>>>>>> 4f933db56ce02e3fe441c32be662d3f93e6ed391
            }
            id_count += 1

    return results
                    