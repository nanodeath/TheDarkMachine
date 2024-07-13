extends Control

@export var equipment_type: PackedScene
@onready var equipment_button = $EquipmentButton
var ghost: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	equipment_button.pressed.connect(self._pressed)
	var equipment := equipment_type.instantiate()
	
	var texture: Texture2D
	var animated_sprite := equipment.get_node_or_null("AnimatedSprite") as AnimatedSprite2D
	if animated_sprite:
		texture = animated_sprite.sprite_frames.get_frame_texture("default", 0)
	var sprite := equipment.get_node_or_null("Sprite") as Sprite2D
	if sprite:
		texture = sprite.texture
	
	if texture:
		equipment_button.texture_normal = texture
	equipment.queue_free()

func _pressed():
	print("Click!")
	var equipment := equipment_type.instantiate()
	equipment.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().root.add_child(equipment)
	ghost = equipment

func _process(delta):
	if ghost:
		ghost.global_position = get_global_mouse_position()

func _unhandled_input(event):
	if ghost and event is InputEventMouseButton:
		var button_event := event as InputEventMouseButton
		if button_event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			if ghost.has_method("equipment_connect"):
				ghost.equipment_connect(button_event.global_position)
			else:
				ghost.modulate = Color.WHITE
				ghost.process_mode = Node.PROCESS_MODE_INHERIT
				ghost = null
		elif button_event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
			_cancel_placement()
	elif ghost and event.is_action_released("ui_cancel"):
		_cancel_placement()

func _cancel_placement():
	ghost.queue_free()
	ghost = null
