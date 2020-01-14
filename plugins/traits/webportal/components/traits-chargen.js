import EmberObject from '@ember/object';
import Component from '@ember/component';

export default Component.extend({
    didInsertElement: function() {
      let self = this;
      this.set('updateCallback', function() { return self.onUpdate(); } );
    },
    onUpdate: function() {
      let extras = this.get('model.app.game.extra_plugins');
      if (!extras.any(e => e === 'traits')) {
        return {};
      }

      let data = {};
      this.get('model.char.traits').filter(t => t.name && t.name.length > 0)
         .forEach(t => data[t.name] = t.desc);
      return data;
    },
      
    actions: { 
        addTrait() {
          this.get('model.char.traits').pushObject(EmberObject.create( {name: "Trait Name", desc: "Enter a Description"} ));
        },
        removeTrait(name) {
          let found = this.get('model.char.traits').find(t => t.name === name);
          if (found) {
            this.get('model.char.traits').removeObject(found);  
          }
        }
    
    }
});
