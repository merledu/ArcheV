function second() {
    var element = document.getElementsByClassName("second")[0];
        element.style.display = "flex";
        element.scrollIntoView({ behavior: 'smooth' });
}


function selectPath() {
    document.getElementById('folder-selector').click();
}

function handleFiles(inputElementId) {
  const inputElement = document.getElementById(inputElementId);
  const files = inputElement.files;
  if (files.length > 0) {
      document.getElementById('llm-path').value = files[0].webkitRelativePath || files[0].name;
  }
}
// document.getElementById('folder-selector').addEventListener('change', function(event) {
//     const files = event.target.files;
//     if (files.length > 0) {
//         document.getElementById('llm-path').value = files[0].webkitRelativePath || files[0].name;
//     }
//   });


function analyzes() {
    let llm_path = document.getElementById("llm-path").value;
    let context_length = document.getElementById("context-length").value;
    let gpu_layers = document.getElementById("gpu-layers").value;
    const errorMessageDiv = document.getElementById('error-message');
    if (!llm_path || !context_length || !gpu_layers) {
      errorMessageDiv.textContent = 'Please fill in all fields.';
      errorMessageDiv.style.display = 'block';
      return; 
      }
    errorMessageDiv.style.display = 'none';
    const thirdSection = document.getElementById('third');
    if (thirdSection) {
      thirdSection.style.display = 'block';
      thirdSection.scrollIntoView({ behavior: 'smooth' });
      updateProgressBar(100); 
    }
    pywebview.api.analyze(llm_path.trim(), context_length.trim(), gpu_layers.trim())
  };


function updateProgressBar(percentage) {
    const progressBar = document.getElementById('progressBar');
    progressBar.style.width = percentage + '%';
    progressBar.textContent = '';
    if (percentage === 100) {
        setTimeout(() => {
            transitionToFourthSlide();
        }, 5000); 
      }
  }


function transitionToFourthSlide() {
    const thirdSection = document.getElementById('third');
    const fourthSection = document.getElementById('fourth');
    if (thirdSection && fourthSection) {
        thirdSection.style.display = 'none'; // Hide slide 3
        fourthSection.style.display = 'flex'; // Show slide 4
        fourthSection.scrollIntoView({ behavior: 'smooth' });
    }
  };


function scrollToTop() {
    window.scrollTo(0, 0);
}
window.onload = scrollToTop;


