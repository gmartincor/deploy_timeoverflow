(function() {
  function initializeConfiguration() {
    if (typeof Highcharts === 'undefined') {
      setTimeout(initializeConfiguration, 100);
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
        libURL: '/assets/vendor/export-libs/'
      }
    });

    var originalError = Highcharts.error;
    Highcharts.error = function(code, stop) {
      if (code === 28) {
        console.warn('Highcharts: Error #28 loading images, continuing without image');
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

    console.log('Unified Highcharts configuration applied successfully');
  }
  
  if (document.readyState === "complete" || document.readyState === "interactive") {
    initializeConfiguration();
  } else {
    document.addEventListener("DOMContentLoaded", initializeConfiguration);
  }
})();
