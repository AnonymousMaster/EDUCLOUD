module Tinymce::Hammer

  mattr_accessor :install_path, :src, :languages, :themes, :plugins, :setup

  @@install_path = '/javascripts/tiny_mce'

  @@src = true

  @@setup = nil

  @@mode = ['textareas']

  @@plugins = ['paste','table','contextmenu','fullscreen','asciimath','asciisvg','visualchars','safari','inlinepopups']

  @@languages = ['en']

  @@themes = ['advanced']

  @@init = {
    :paste_convert_headers_to_strong => true,
    :paste_convert_middot_lists => true,
    :paste_remove_spans => true,
    :paste_remove_styles => true,
    :constrain_menus => true,
    :paste_strip_class_attributes => true,
    :theme => 'advanced',
    :theme_advanced_fonts => 'Arial=arial,helvetica,sans-serif,Courier New=courier new,courier,monospace,Georgia=georgia,times new roman,times,serif,Tahoma=tahoma,arial,helvetica,sans-serif,Times=times new roman,times,serif,Verdana=verdana,arial,helvetica,sans-serif',
    :theme_advanced_toolbar_align => 'left',
    :theme_advanced_toolbar_location => 'top',
    :theme_advanced_buttons1 => 'undo,redo,cut,copy,paste,pastetext,|,bold,italic,strikethrough,underline,blockquote,charmap,bullist,numlist,removeformat,cleanup,code,justifyleft,justifycenter,justifyright,justifyfull,fullscreen,asciimath,asciimathcharmap,visualchars',
    :theme_advanced_buttons2 => 'hr,formatselect,removeformat,visualaid,separator,sub,sup,charmap,bullist,numlist,outdent,indent,forecolor,fontselect,fontsizeselect,|,link,unlink,image,|',
    :theme_advanced_buttons3 => '',
    :valid_elements => "a[href|title,blockquote[cite],br,caption,cite,code,dl,dt,dd,em,i,img[src|alt|title|width|height|align],li,ol,p,pre,q[cite],small,strike,strong/b,sub,sup,u,ul" ,
  }

  @@AScgiloc = ['http://www.imathas.com/editordemo/php/svgimg.php'],
  @@ASdloc = ['http://www.imathas.com/editordemo/jscripts/tiny_mce/plugins/asciisvg/js/d.svg'],

  @@content_css = 'stylesheets/content.css'
  def self.init= js
    @@init = js
  end

  def self.init
    @@init
  end

  def self.cache_js
    File.open("#{Rails.root}/public/javascripts/tinymce_hammer.js", 'w') do |file|
      file.write Combiner.combined_js
    end
  end

end
