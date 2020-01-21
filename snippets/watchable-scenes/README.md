**Contributed by Tat**

Watchable scenes are scenes which anyone can view on the portal (ie, watch), but which only invited participants and admin can pose into.

Because it interacts heavily with the scene system, Watchable doesn't work well as a plug-in. You'll have to do some custom code in order to enable it. You can make the changes listed below in order to create Watchable scenes on your game.

> **Note from Faraday**: Because so many custom code changes are required, be aware that you are exposing yourself to significant potential for merge conflicts (collisions between your changes and future code changes) when you upgrade.  Also, the files and functions mentioned here were correct at the time of writing, but may change at any time.  Consider this more of a guide than a guaranteed set of instructions.

## On game

**In `aresmush\plugins\scenes\public\scene.rb`**

* add: `attribute :watchable_scene, :type => DataType::Boolean`

**In `aresmush\plugins\scenes\helpers\permissions.rb`**

 add:

    def self.can_join_scene?(actor, scene)
      return !scene.is_private? if !actor
      return true if scene.owner == actor
      return true if !scene.is_private? && !scene.watchable_scene
      return true if actor.room == scene.room
      return true if scene.invited.include?(actor)
      scene.participants.include?(actor)
    end

**In `aresmush/plugins/scenes/commands/scene_info_cmd.rb`**

*  under `is_private = self.value == "Private"` add: `is_watchable = self.value == "Watchable"`
* under `scene.update(private_scene: is_private)` add  `scene.update(watchable_scene: is_watchable)`

**In `aresmush/plugins/scenes/commands/scene_start_cmd.rb`**

* under `private_scene = self.privacy == "Private"` add `watchable_scene = self.privacy == "Watchable"`

**In `plugins\scenes\commands\scene_addpose_cmd.rb`**

* Change `if (!Scenes.can_read_scene?(enactor, scene))` to `if (!Scenes.can_join_scene?(enactor, scene))`

**In `plugins\scenes\commands\scene_clearlog_cmd.rb`**

* Change `if (!Scenes.can_edit_scene?(enactor, scene))` to `if (!Scenes.can_join_scene?(enactor, Scene[self.scene_num]))`

**In `plugins\scenes\commands\scene_enablelog_cmd.rb`**

* Change `if (!Scenes.can_edit_scene?(enactor, scene))` to `if (!Scenes.can_join_scene?(enactor, Scene[self.scene_num]))`

**In `plugins\scenes\commands\scene_invite_cmd.rb`**

* Change `if (!Scenes.can_read_scene?(enactor, scene))` to `if (!Scenes.can_join_scene?(enactor, scene))`

**In `plugins\scenes\commands\scene_join_cmd.rb`**

* Change `can_join = Scenes.can_read_scene?(enactor, scene) || !scene.private_scene` to `can_join = Scenes.can_join_scene?(enactor, scene)`

## Web API Files

**In `plugins\scenes\helpers\web_data.rb`**

* Under `can_edit: viewer && Scenes.can_edit_scene?(viewer, scene),` add `can_join: Scenes.can_join_scene?(viewer, scene),`

**In `aresmush/plugins/scenes/public/scenes_api.rb`**

* Change `self.start_scene(enactor, location, private_scene, scene_type, temp_room)` to `self.start_scene(enactor, location, private_scene, watchable_scene, scene_type, temp_room)`
* Under `private_scene: private_scene,` add `watchable_scene: watchable_scene,`

**In `aresmush/plugins/scenes/templates/scenes_list_template.rb`**

change the `def privacy` section to read:

    def privacy(scene)
        if scene.private_scene
          message = t('scenes.private')
          color = "%xr"
        elsif scene.watchable_scene
          message = "Watchable"
          color = "%xc"
        else
          message = t('scenes.open')
          color = "%xg"
        end
        "#{color}#{message}%xn"
    end

**In `aresmush/plugins/scenes/web/create_scene_handler.rb`:**

* Under `private_scene: completed ? false : (privacy == "Private"),` add `watchable_scene: completed ? false : (privacy == "Watchable"),`

**In `aresmush/plugins/scenes/web/edit_scene_handler.rb`:**

* Under `scene.update(private_scene: request.args[:privacy] == "Private")` add `scene.update(watchable_scene: request.args[:privacy] == "Watchable")`

**In `aresmush/plugins/scenes/web/get_scene_handler.rb`:**

* Change `privacy: scene.completed ? "Open" : (scene.private_scene ? "Private" : "Open"),` to `privacy: scene.completed ? "Open" : (scene.private_scene ? "Private" : (scene.watchable_scene ? "Watchable" : "Open")),`

**In `aresmush/plugins/scenes/web/live_scenes_handler.rb`:**

* Under `can_view: enactor && Scenes.can_read_scene?(enactor, s),` add `can_join: Scenes.can_join_scene?(enactor, s),`
* Under `is_private: s.private_scene,` add `is_watchable: s.watchable_scene,`

## Where list

**In `plugins\who\templates\where_template.rb`**

* Under the `if (scene.private_scene)` section (line 74), add:

    `elsif (scene.watchable_scene)`
         `append_to_group(groups['private'], room, name)`

The whole section should read:

    elsif (scene)
      if (scene.private_scene)
        append_to_group(groups['private'], room, name)
      elsif (scene.watchable_scene)
        append_to_group(groups['private'], room, name)
      else
        append_to_group(groups['open'], room, name)
      end
    else
     append_to_group(groups['private'], room, name)
    end

## Web Portal
**In `app\controllers\scene-create.js` AND in `app\controllers\scene-edit.js`**

Change the scenePrivacyValues to read

    scenePrivacyValues: computed(function() {
        return [ 'Open', 'Private', 'Watchable' ];
    }),

In `app\templates\scenes-live.hbs`

Change

    {{#if scene.is_private}}
        <span class="label label-danger">Private</span>
    {{else}}
        <span class="label label-success">Open</span>
    {{/if}}

to  read

    {{#if scene.is_private}}
        <span class="label label-danger">Private</span>
    {{else}}
          {{#if scene.is_watchable}}
            <span class="label label-info">Watchable </span>
          {{else}}
            <span class="label label-success">Open</span>
          {{/if}}
    {{/if}}

AND

Change the Join Scene button to read

    {{#if scene.can_join}}
              <button class="btn btn-default" {{action 'joinScene' scene.id}}>
              <i class="fa fa-sign-in-alt" aria-hidden="true"></i>
                {{#bs-tooltip placement="left"}}Join scene.{{/bs-tooltip}}
              </button>
    {{/if}}


**In `app\templates\components\live-scene-control.hbs`**, under the 'not isApproved' warning, add, 

    {{else if (not scene.can_join)}}
      <div class="alert alert-warning">You can watch this scene, but cannot join it without an invitation.</div>





## Error message

You'll probably want to change the `scene_is_private` message in the locale file to read `"That scene is private or watchable.  You must get an invitation/meetme from one of the participants to join."`

## Texting

If you  have the txt plugin installed, you'll want to also make changes here:

**In `plugins\txt\commands\txt_send_cmd.rb`**

* Line 58 should read `can_txt_scene = Scenes.can_join_scene?(enactor, scene)`

**In `plugins\txt\web\add_txt_handler.rb`**, the access check (line 24) should be:

    if (!Scenes.can_join_scene?(enactor, scene))
     return { error: t('scenes.access_not_allowed') }
    end
