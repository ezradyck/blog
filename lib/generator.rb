module Blog
  class Generator
    def initialize(markdown)
      @markdown = markdown
    end

    def gen_directory_index(dist_child_path, abs_child_path, child_path)

      content = ""

      layout = File.read(File.expand_path("../layout/index.html", __dir__))
      layout.sub! "{content}", content

      f = File.new(File.join(dist_child_path, "index.html"), "w")
      f.write(layout)

      puts "Finished processing #{child_path}"
    end

    def gen_post(dist_child_path, abs_child_path, child_path)
      post_content = File.read(abs_child_path)

      # parse out header block

      # 9 chars for "```header"
      header_end_pos = post_content.index('```', 9)
      header = post_content[10...header_end_pos]

      props = Hash[header.lines.collect do |line| 
        idx = line.index(':')
        key = line[0...idx]
        value = line[(idx + 1)..].sub! "\n", ""
        [ key, value ]
      end]

      post_content = post_content[(header_end_pos + 3)..]

      md = @markdown.render(post_content)

      # TODO: encode header and footer in md file, and parse out before parsing to HTML

      layout = File.read(File.expand_path("../layout/layout.html", __dir__))
      layout.sub! "{content}", md
      layout.gsub! "{title}", props["title"]
      layout.gsub! "{published}", props["published"]

      dist_child_path.sub! ".md", ".html"

      f = File.new(dist_child_path, 'w')
      f.write(layout)

      puts "Finished processing #{child_path}"
    end
  end
end
