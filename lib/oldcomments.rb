require 'yaml'

class Jekyll::OldComments < Liquid::Tag

  def render(context)
    comment_dir = File.join(context.registers[:site].source, '_comments','*.md')
    @comment_map = Hash.new
    Dir[comment_dir].each do |comment|
      yaml = YAML.load_file(comment)
      fd = File.open(comment,'r')
      text = fd.read().split('---')[2]
      fd.close
      path = yaml['path'].strip
      if not @comment_map.has_key?(path)
        @comment_map[path] = Array.new
      end
      @comment_map[path] << { 'meta' => yaml, 'text' => text.gsub(/^(.*)$/, '<p>\1</p>') }
    end

    @comment_map.each do |key, value|
      @comment_map[key].sort!{ |a,b| a['meta']['date']<=>b['meta']['date'] } 
    end

    tmpl = File.read File.join Dir.pwd, "_includes", 'comments.html'
    (Liquid::Template.parse tmpl).render('comments' => @comment_map[context.registers[:page]['permalink']])
  end

end

Liquid::Template.register_tag('old_comments', Jekyll::OldComments)