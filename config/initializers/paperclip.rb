Paperclip.options[:content_type_mappings] = {
  png: %w(image/png)
}
Paperclip::Attachment.default_options[:validate_media_type] = false
Paperclip.options[:command_path] = 'C:\Program Files\ImageMagick-7.0.7-Q16'