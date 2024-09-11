function second() {
    let element = document.getElementsByClassName("second")[0];
    if (element) {
        element.style.display = "flex";
        element.scrollIntoView({ behavior: 'smooth' });
    }
}


document.addEventListener('DOMContentLoaded', function() {
    function submitForm(event) {
        event.preventDefault();
        const llmPath = document.getElementById('llm-path').value;
        const gpuLayers = document.getElementById('gpu-layers').value;
        const contextNumber = document.getElementById('context-number').value;
        console.log('Folder Path:', llmPath);
        console.log('GPU Layers:', gpuLayers);
        console.log('Context Number:', contextNumber);
    }


    function selectPath() {
        document.getElementById('folder-selector').click();
    }


    document.getElementById('folder-selector').addEventListener('change', function(event) {
      const files = event.target.files;
      if (files.length > 0) {
          document.getElementById('llm-path').value = files[0].webkitRelativePath || files[0].name;
      }
    });


    // document.getElementById('check').addEventListener('click', function() {
    //     const llmPath = document.getElementById('llm-path').value.trim();
    //     const gpuLayers = document.getElementById('gpu-layers').value.trim();
    //     const contextNumber = document.getElementById('context-number').value.trim();
    //     const errorMessageDiv = document.getElementById('error-message');
    //     if (!llmPath || !gpuLayers || !contextNumber) {
    //         errorMessageDiv.textContent = 'Please fill in all fields.';
    //         errorMessageDiv.style.display = 'block';
    //         return
    //     }
    //     errorMessageDiv.style.display = 'none';
    //     const thirdSection = document.getElementById('third');
    //     if (thirdSection) {
    //         thirdSection.style.display = 'block'; 
    //         thirdSection.scrollIntoView({ behavior: 'smooth' });
    //         updateProgressBar(100); 
    //     }
    // });    
    document.getElementById('select-folder').addEventListener('click', selectPath);
    function updateProgressBar(percentage) {
        const progressBar = document.getElementById('progressBar');
        if (progressBar) {
            progressBar.style.width = percentage + '%';
            progressBar.textContent = '';
        if (percentage === 100) {
            setTimeout(() => {
            transitionToFourthSlide();
          }, 5000); 
        }
      }
    }


    function transitionToFourthSlide() {
      const thirdSection = document.getElementById('third');
      const fourthSection = document.getElementById('fourth');
      if (thirdSection && fourthSection) {
          thirdSection.style.display = 'none'; 
          fourthSection.style.display = 'flex';
          fourthSection.scrollIntoView({ behavior: 'smooth' });
      }
    }
  });


document.addEventListener('DOMContentLoaded', table);

    function table(){
    const { jsPDF } = window.jspdf;
    function exportTableToJson() {
        const table = document.querySelector('table');
        const headers = Array.from(table.querySelectorAll('thead th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        const data = rows.map(row => {
          const cells = Array.from(row.querySelectorAll('td'));
          return headers.reduce((acc, header, index) => {
              acc[header] = cells[index].innerText;
              return acc;
        }, {});
    });
      return data;
    }

    
    function downloadJson() {
        const data = exportTableToJson();
        const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'table-data.json';
        a.click();
        URL.revokeObjectURL(url);
    }


    document.getElementById('save-json').addEventListener('click', downloadJson);
  }

  function scrollToTop() {
      window.scrollTo(0, 0);
  }


  window.onload = scrollToTop;

function tryagain(){
  var element = document.getElementsByClassName("second")[0];
    if (element) {
        element.style.display = "flex";
        element.scrollIntoView({ behavior: 'smooth' });
    }
}
