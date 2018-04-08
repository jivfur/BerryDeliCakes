 function loadFilePreview(event) {
    console.log("Preview Design")
    var imagen = document.getElementById('previewImg');
    var container = document.getElementById('previewHeadLine');
    var summaryImg = document.getElementById('summaryImg');
    container.style.visibility = 'visible';
    imagen.style.visibility = 'visible';
    imagen.src = URL.createObjectURL(event.target.files[0]);
    summaryImg.src = URL.createObjectURL(event.target.files[0]);
  }