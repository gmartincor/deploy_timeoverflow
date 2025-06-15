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
