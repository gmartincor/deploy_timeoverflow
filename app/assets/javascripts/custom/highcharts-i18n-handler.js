document.addEventListener('DOMContentLoaded', function() {
  if (window.highchartsI18n && typeof Highcharts !== 'undefined') {
  }
  
  document.addEventListener('turbo:load', function() {
    if (window.highchartsI18n && typeof Highcharts !== 'undefined') {
      var lang = Highcharts.getOptions().lang;
      lang.viewFullscreen = window.highchartsI18n.viewFullscreen;
      lang.exitFullscreen = window.highchartsI18n.exitFullscreen;
      lang.printChart = window.highchartsI18n.printChart;
      lang.downloadPDF = window.highchartsI18n.downloadPDF;
      lang.downloadPNG = window.highchartsI18n.downloadPNG;
      lang.downloadJPEG = window.highchartsI18n.downloadJPEG;
      lang.downloadSVG = window.highchartsI18n.downloadSVG;
      lang.contextButtonTitle = window.highchartsI18n.contextButtonTitle;
      
      if (Highcharts.charts) {
        Highcharts.charts.forEach(function(chart) {
          if (chart) {
            chart.redraw();
          }
        });
      }
    }
  });
});
