import os

from globals import ARCHEV_PROMPTS, FUNCT_REF, llm,SYSTEM_PROMPTS,ARCHEV_TMP
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import funct



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


# Function to remove the file extension
def remove_extension(filename):
    return os.path.splitext(filename)[0]

propmpts_path =  ARCHEV_PROMPTS 
prompts, prompts_filename = read_files_from_directory(propmpts_path, ".txt")
json_file_path = FUNCT_REF 
json_files, json_names = read_files_from_directory(json_file_path, ".json")  

# def master_function(json_str, verilog_code):  
#     # Syntactical verification
#     syntactical_verification_results = lint(verilog_code)
#     # Functional verification
#     functional_verification_results = funct.functional_verification(verilog_code, json_str)
#     return syntactical_verification_results, functional_verification_results


def analyze(llm_path, context_length, gpu_layers):
    results = {} 
    for root,sub_dir,files in os.walk(ARCHEV_PROMPTS):
            for file in files:
                user_propmpts = read_file_content(file)
                llm_verilog_code=llm_response(SYSTEM_PROMPTS,user_propmpts)

                with open(ARCHEV_TMP,'w') as tmp:
                    tmp.write(llm_verilog_code)
                          
                syntactical_verification = lint(llm_verilog_code)
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
                    