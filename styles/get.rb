
# Loads all themes and put them in a single file!
#
require 'json'

page = `curl http://highlightjs.org/static/test.html`

list = []

File.open 'all.less', 'w' do |less|

  page.scan %r(stylesheet" title="([^"]+)" href="(styles/([^"]+)\.css)">) do
    name = $1
    url = "http://highlightjs.org/static/#{$2}"
    id = $3
    id.gsub!('.', '-')
    less.puts ".hl-s-#{id} {"
    less.puts `curl '#{url}'`
    less.puts "}"
    list << { name: name, id: id }
  end

end

File.write 'index.js', "HL_S = #{list.to_json};"

