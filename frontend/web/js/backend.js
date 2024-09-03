function analyze() {
    let llm_path = document.getElementById("llm-path").value;
    let context_number = document.getElementById("context-number").value;
    let gpu_layers = document.getElementById("gpu-layers").value;
    pywebview.api.llm_settings(gpu_layers, context_number, llm_path)
    // pywebview.api.analyze()
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
        syntacticalText.className = syntacticalStatus === 'passed' ? 'status delivered' : 'status cancelled';
        syntacticalText.textContent = syntacticalStatus === 'passed' ? 'Passed' : 'Failed';
        syntacticalCell.appendChild(syntacticalText);
        row.appendChild(syntacticalCell);
        const functionalCell = document.createElement('td');
        const functionalStatus = item[1]; 
        const functionalText = document.createElement('p');
        functionalText.className = functionalStatus === 'passed' ? 'status delivered' : 'status cancelled';
        functionalText.textContent = functionalStatus === 'passed' ? 'Passed' : 'Failed';
        functionalCell.appendChild(functionalText);
        row.appendChild(functionalCell);
        tableBody.appendChild(row);
    });
}
