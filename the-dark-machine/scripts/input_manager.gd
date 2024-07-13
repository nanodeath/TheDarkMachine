extends Node2D

@export_flags_2d_physics var clickable_mask: int

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var button_event := event as InputEventMouseButton
		if button_event.button_index == MOUSE_BUTTON_RIGHT and button_event.is_released():
			var space_state := get_world_2d().direct_space_state
			var query_params := PhysicsPointQueryParameters2D.new()
			query_params.collide_with_areas = true
			query_params.position = event.global_position
			query_params.collision_mask = clickable_mask
			var collisions := space_state.intersect_point(query_params)
			for c in collisions:
				var collider := c["collider"] as Node
				collider = _get_user_node(collider)
				if collider:
					var user_placed := collider.get_node("UserPlaced") as UserPlaced
					get_viewport().set_input_as_handled()
					user_placed.return_equipment()
					break

func _get_user_node(n: Node) -> Node:
	if n.has_node("UserPlaced"):
		return n
	# If we're on a special ClickTarget node, may need to check the
	# parent, too.
	var p := n.get_parent()
	if p and p.has_node("UserPlaced"):
		return p
	return null
