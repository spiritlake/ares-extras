Global.dispatcher.spawn("Importing wiki", client) do


  wikidot = WikidotAPI::Client.new "#{Wikidot.site_name}-wiki", Wikidot.api_key

  scene_type = "social";

  args = {
    "tags_all" => ["log", scene_type],
    "site" => Wikidot.site_name,
  }
  pages = wikidot.pages.select(args)

  pages.each do |p|

    args = {
      "page" => p,
      "site" => Wikidot.site_name,
    }
    page = wikidot.pages.get_one(args)

    title = page['title']
    tags = page['tags']
    created = Time.parse page['created_at']
    content = page['content']
    summary = nil
    location = nil
    icdate = title.before(" - ")
    title = title.after(" - ")
    clean_contents = ""
    content.split(/[\r\n]/).each do |line|
      if (line.start_with?("[[include "))
        next
      elsif (line.start_with?("|summary="))
        next
      elsif (line.start_with?("|location="))
        location = line.after("=")
      elsif (line.start_with?("|related="))
        next
      elsif (line.start_with?("]]"))
        next
      elsif (line.start_with?(">"))
        if (!summary)
          summary = line.after(">")
        end
      else
        clean_contents << "\n#{line.strip}"
      end
    
    end
  
    existing_scene = Scene.all.select { |s| s.title == title }.first
    if existing_scene
      client.emit "Scene #{title} %xgalready exists%xn."
      next
    else
      client.emit "Creating scene #{title}."
    end

  
  
  
    scene = Scene.create(title: title,
    summary: summary,
    location: location,
    icdate: icdate,
    shared: true,
    completed: true,
    scene_type: scene_type.titleize,
    date_completed: DateTime.parse(page['created_at']).to_date,
    date_shared: DateTime.parse(page['created_at']).to_date
    )
    
    log = SceneLog.create(log: clean_contents, scene: scene )
    scene.update(scene_log: log)
    scene.update(created_at: created)
    
    tags.each do |char_name|
      char = Character.find_one_by_name(char_name)
      if (char)
        scene.participants.add char
      end
    end
  
  end

end