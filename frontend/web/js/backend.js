function analyze() {
    let llm_path = document.getElementById("llm-path").value;
    let context_length = document.getElementById("context-length").value;
    let gpu_layers = document.getElementById("gpu-layers").value;
    pywebview.api.analyze(llm_path, context_length, gpu_layers)
}


function updateTable(data) {
    const tableBody = document.querySelector('table tbody');
    tableBody.innerHTML = '';
    data.forEach((item, index) => {
        const row = document.createElement('tr');
        const idCell = document.createElement('td');
        idCell.textContent = index + 1;
        row.appendChild(idCell);
        const moduleNameCell = document.createElement('td');
        moduleNameCell.textContent = item[2]; 
        row.appendChild(moduleNameCell);
        const syntacticalCell = document.createElement('td');
        const syntacticalStatus = item[0]; 
        const syntacticalText = document.createElement('p');
        syntacticalText.className = syntacticalStatus === 'True' ? 'status delivered' : 'status cancelled';
        syntacticalText.textContent = syntacticalStatus === 'True' ? 'True' : 'False';
        syntacticalCell.appendChild(syntacticalText);
        row.appendChild(syntacticalCell);
        const functionalCell = document.createElement('td');
        const functionalStatus = item[1]; 
        const functionalText = document.createElement('p');
        functionalText.className = functionalStatus === 'True' ? 'status delivered' : 'status cancelled';
        functionalText.textContent = functionalStatus === 'True' ? 'True' : 'False';
        functionalCell.appendChild(functionalText);
        row.appendChild(functionalCell);
        tableBody.appendChild(row);
    });
}
