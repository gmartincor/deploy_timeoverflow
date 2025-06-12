module HighchartsHelper
  def highcharts_translations_script
    translations = get_translations
    
    javascript_tag do
      "window.highchartsI18n = #{translations.to_json};".html_safe
    end
  end
  
  def highcharts_language_switcher_script(locale)
    translations = get_translations(locale)
    
    javascript_tag do
      <<-JS.html_safe
        window.highchartsI18n = #{translations.to_json};
        if (typeof Highcharts !== 'undefined') {
          var lang = Highcharts.getOptions().lang;
          #{generate_lang_assignments}
          
          Highcharts.charts.forEach(function(chart) {
            if (chart) chart.redraw();
          });
        }
      JS
    end
  end
  
  private
  
  def get_translations(locale = nil)
    translation_keys = %w[
      view_fullscreen exit_fullscreen print_chart download_pdf 
      download_png download_jpeg download_svg context_button_title
    ]
    
    translations = {}
    translation_keys.each do |key|
      js_key = key.camelize(:lower)
      js_key = js_key[0] == 'd' ? "d#{js_key[1..-1]}" : js_key
      
      if locale
        translations[js_key] = I18n.t("highcharts.#{key}", locale: locale)
      else
        translations[js_key] = t("highcharts.#{key}")
      end
    end
    
    translations
  end
  
  def generate_lang_assignments
    translation_keys = %w[
      viewFullscreen exitFullscreen printChart downloadPDF
      downloadPNG downloadJPEG downloadSVG contextButtonTitle
    ]
    
    translation_keys.map do |key|
      "lang.#{key} = window.highchartsI18n.#{key};"
    end.join("\n          ")
  end
end
