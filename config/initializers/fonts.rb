
$fonts = {}
Dir["lib/assets/fonts/*.ttf"].each do |file_name|
  file = TTFunk::File.open(file_name)
  $fonts[file.name.postscript_name] = file
end


