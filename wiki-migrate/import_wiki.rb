        Global.dispatcher.spawn("Importing wiki", client) do


          wikidot = WikidotAPI::Client.new "#{Wikidot.site_name}-wiki", Wikidot.api_key

          args = {
            "categories" => ["theme", "operation", "fs3", "scuttlebutt"],
            "site" => Wikidot.site_name,
          }
          pages = wikidot.pages.select(args)

          additional_pages = [
            "bunks",
            "firstvssecondwar",
            "fs3",
            "getting-started",
            "npcs",
            "operations",
            "playercontribsbox",
            "policies",
            "scuttlebutt",
            "story-so-far",
            "story-wish-list",
            "theme",
            "themebox",
            "what-should-i-play",
            "colonybox",
            "shipbox"
          ]
          
          pages = pages.concat additional_pages
          
          pages.each do |p|

            args = {
              "page" => p,
              "site" => Wikidot.site_name,
            }
            page = wikidot.pages.get_one(args)

            title = page['title']
            tags = page['tags']

            client.emit "Importing #{p}"
            
            wiki_page = WikiPage.create(name: p, title: title, tags: tags)
            WikiPageVersion.create(wiki_page: wiki_page, text: page['content'], character: Game.master.system_character)
  
          end

        end