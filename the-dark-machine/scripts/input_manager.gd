extends Node2D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var button_event := event as InputEventMouseButton
		if button_event.button_index == MOUSE_BUTTON_RIGHT and button_event.is_released():
			var space_state := get_world_2d().direct_space_state
			var query_params := PhysicsPointQueryParameters2D.new()
			query_params.collide_with_areas = true
			query_params.position = event.global_position
			var collisions := space_state.intersect_point(query_params)
			for c in collisions:
				var collider := c["collider"] as Node
				if collider.has_node("UserPlaced"):
					collider.queue_free()
					get_viewport().set_input_as_handled()
					break
