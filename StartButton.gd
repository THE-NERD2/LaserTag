extends Button

@export var World_basic_scene: PackedScene
@export var World_trees_scene: PackedScene

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var selected = $"../WorldOption".selected
			var currentWorld = $"../../WorldContainer".get_child(0)
			if is_instance_valid(currentWorld):
				currentWorld.queue_free()
			if selected == 0:
				var scene = World_basic_scene.instantiate()
				$"../../WorldContainer".add_child(scene)
			elif selected == 1:
				var scene = World_trees_scene.instantiate()
				$"../../WorldContainer".add_child(scene)
