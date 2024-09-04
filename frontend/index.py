import os

from globals import ARCHEV_PROMPTS, FUNCT_REF, llm
from llm_interface.llm_interface import load_llm, llm_response
from analyzers.linter import lint
from analyzers.funct import funct


# Providing prompts to LLM
def read_file_content(file_path):
    with open(file_path, 'r') as file:
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
    
    results = []  

    for i in range(len(prompts)):
        
        verilog_code = """  

    
"""

        str = ""  

        prompt_name_without_extension = remove_extension(prompts_filename[i])

        for j in range(len(json_files)):  
            json_name_without_extension = remove_extension(json_names[j])
            if prompt_name_without_extension == json_name_without_extension:
                str = "\n".join(json_files[j])
                break  

        if str:  
            syntactical_verification_results = lint(verilog_code)
            functional_verification_results = funct.functional_verification(verilog_code, str)
            
            # syntactical, functional = master_function(str, verilog_code)
            
            results.append((syntactical_verification_results, functional_verification_results, prompt_name_without_extension))

    return results
