PDFKit.configure do |config|
  #config.wkhtmltopdf = `which wkhtmltopdf`.to_s.strip
  config.default_options = {
    :encoding => "UTF-8",
    :page_size => "Letter", #or "Letter" or whatever needed
    :margin_top => "0.25in",
    :margin_right => "0.25in",
    :margin_bottom => "0.10in",
    :margin_left => "0.25in",
    :disable_smart_shrinking => false
  }
  #config.root_url = "http://localhost:3000" # Use only if your external hostname is unavailable on the server.
end
