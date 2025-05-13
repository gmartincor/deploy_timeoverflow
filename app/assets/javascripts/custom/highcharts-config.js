(function() {
  function iniciarConfiguracion() {
    if (typeof Highcharts === 'undefined') {
      setTimeout(iniciarConfiguracion, 100);
      return;
    }

    Highcharts.getOptions().lang = Highcharts.getOptions().lang || {};
    var lang = Highcharts.getOptions().lang;
    lang.viewFullscreen = lang.viewFullscreen || "Ver en pantalla completa";
    lang.exitFullscreen = lang.exitFullscreen || "Salir de pantalla completa";
    lang.printChart = lang.printChart || "Imprimir gráfico";
    lang.downloadPDF = lang.downloadPDF || "Descargar PDF";
    lang.downloadPNG = lang.downloadPNG || "Descargar PNG";
    lang.downloadJPEG = lang.downloadJPEG || "Descargar JPEG";
    lang.downloadSVG = lang.downloadSVG || "Descargar SVG";
    lang.contextButtonTitle = lang.contextButtonTitle || "Opciones de exportación";
    
    Highcharts.setOptions({
      exporting: {
        fallbackToExportServer: false,
        libURL: '/assets/vendor/export-libs/',
        buttons: {
          contextButton: {
            menuItems: [
              'downloadPDF'
            ]
          }
        }
      }
    });

    var originalError = Highcharts.error;
    Highcharts.error = function(code, stop) {
      if (code === 28) {
        console.warn('Highcharts: Error #28 al cargar imágenes, continuando sin la imagen');
        return;
      }
      return originalError.call(this, code, stop);
    };

    Highcharts.Chart.prototype.downloadLocal = function(dataURL, filename) {
      var a = document.createElement('a');
      a.href = dataURL;
      a.download = filename;
      a.target = '_blank';
      
      document.body.appendChild(a);
      a.click();
      
      setTimeout(function() {
        document.body.removeChild(a);
      }, 100);
    };

    console.log('Configuración unificada de Highcharts aplicada correctamente');
  }
  
  if (document.readyState === "complete" || document.readyState === "interactive") {
    iniciarConfiguracion();
  } else {
    document.addEventListener("DOMContentLoaded", iniciarConfiguracion);
  }
})();
