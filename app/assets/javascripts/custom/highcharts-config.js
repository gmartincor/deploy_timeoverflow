/**
 * Configuración unificada de Highcharts
 * 
 * Este archivo centraliza toda la configuración de Highcharts para exportación,
 * evitando duplicación de código y siguiendo el principio DRY.
 * Se enfoca principalmente en la exportación a PDF.
 */
(function() {
  // Esperar a que el DOM esté listo antes de configurar Highcharts
  function iniciarConfiguracion() {
    if (typeof Highcharts === 'undefined') {
      // Si Highcharts no está cargado todavía, esperar un poco y reintentar
      setTimeout(iniciarConfiguracion, 100);
      return;
    }

    // 1. Configurar idioma para los menús de exportación
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
    
    // 2. Configuración global para todo Highcharts
    Highcharts.setOptions({
      exporting: {
        // Nunca usar servidor externo para exportación
        fallbackToExportServer: false,
        // Ruta donde buscar las bibliotecas de exportación
        libURL: '/assets/vendor/export-libs/',
        // Solo mostrar las opciones necesarias en el menú
        buttons: {
          contextButton: {
            menuItems: [
              // Solo incluimos la exportación a PDF que es lo que se necesita
              'downloadPDF'
            ]
          }
        }
      }
    });

    // 3. Manejar errores comunes de Highcharts
    var originalError = Highcharts.error;
    Highcharts.error = function(code, stop) {
      // Error #28: Problema al cargar imágenes
      if (code === 28) {
        console.warn('Highcharts: Error #28 al cargar imágenes, continuando sin la imagen');
        return;
      }
      // Otros errores se manejan normalmente
      return originalError.call(this, code, stop);
    };

    // 4. Método para descargar archivos localmente
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
  
  // Iniciar configuración cuando el DOM esté listo
  if (document.readyState === "complete" || document.readyState === "interactive") {
    iniciarConfiguracion();
  } else {
    document.addEventListener("DOMContentLoaded", iniciarConfiguracion);
  }
})();
