// Este archivo contiene lo necesario para la exportación completa de gráficos Highcharts
//= require vendor/highcharts
//= require vendor/highcharts-exporting
//= require vendor/highcharts-export-data
//= require vendor/highcharts-offline-exporting
//= require vendor/export-libs/jspdf.umd.min
//= require vendor/export-libs/svg2pdf.min
//= require vendor/export-libs/canvg

// Restauramos la configuración predeterminada de Highcharts sin sobreescribir nada
Highcharts.setOptions({
  // No modificamos la configuración predeterminada de exportación
  // para permitir que Highcharts use su comportamiento estándar
});
