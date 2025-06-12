(function() {
  function initializeConfiguration() {
    if (typeof Highcharts === 'undefined') {
      if (window.highchartsInitAttempts >= 30) {
        return;
      }
      
      window.highchartsInitAttempts = (window.highchartsInitAttempts || 0) + 1;
      setTimeout(initializeConfiguration, 100);
      return;
    }

    Highcharts.getOptions().lang = Highcharts.getOptions().lang || {};
    var lang = Highcharts.getOptions().lang;
    
    if (window.highchartsI18n) {
      lang.viewFullscreen = window.highchartsI18n.viewFullscreen;
      lang.exitFullscreen = window.highchartsI18n.exitFullscreen;
      lang.printChart = window.highchartsI18n.printChart;
      lang.downloadPDF = window.highchartsI18n.downloadPDF;
      lang.downloadPNG = window.highchartsI18n.downloadPNG;
      lang.downloadJPEG = window.highchartsI18n.downloadJPEG;
      lang.downloadSVG = window.highchartsI18n.downloadSVG;
      lang.contextButtonTitle = window.highchartsI18n.contextButtonTitle;
    }
    
    Highcharts.setOptions({
      exporting: {
        fallbackToExportServer: false,
        libURL: '/assets/vendor/export-libs/'
      }
    });

    var originalError = Highcharts.error;
    Highcharts.error = function(code, stop) {
      if (code === 28) {
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

  }
  
  if (document.readyState === "complete" || document.readyState === "interactive") {
    initializeConfiguration();
  } else {
    document.addEventListener("DOMContentLoaded", initializeConfiguration);
  }
})();
