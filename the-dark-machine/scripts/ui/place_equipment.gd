extends Control

@export var equipment_type: PackedScene
@export var initial_count: int

@onready var equipment_button = $EquipmentButton
@onready var available_counter: RichTextLabel = $AvailableCounter
var ghost: Node2D

var available_count: int:
	#get:
		#return available_count
	set(value):
		available_count = value
		available_counter.text = str(available_count)


# Called when the node enters the scene tree for the first time.
func _ready():
	available_count = initial_count
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
	if available_count <= 0:
		return
	
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
			# defined in wire.gd
			if ghost.has_method("equipment_connect"):
				var done_connecting = ghost.equipment_connect(button_event.global_position)
				if done_connecting:
					available_count -= 1
					ghost = null
			else:
				# Place the item!
				ghost.modulate = Color.WHITE
				ghost.process_mode = Node.PROCESS_MODE_INHERIT
				var user_placed_marker := preload("res://scenes/user_placed.tscn").instantiate() as UserPlaced
				user_placed_marker.returning.connect(func(): available_count += 1)
				ghost.add_child(user_placed_marker)
				available_count -= 1
				ghost = null
			get_viewport().set_input_as_handled()
		elif button_event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
			_cancel_placement()
			get_viewport().set_input_as_handled()
	elif ghost and event.is_action_released("ui_cancel"):
		_cancel_placement()
		get_viewport().set_input_as_handled()

func _cancel_placement():
	ghost.queue_free()
	ghost = null
