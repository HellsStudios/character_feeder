extends RigidBody2D

signal eaten

@onready var edible_frame_controller = $EdibleFrameController

var dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	edible_frame_controller.choose_animal()


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				freeze = true

				# Keeps the exact point you clicked under the mouse.
				drag_offset = global_position - get_global_mouse_position()

				get_viewport().set_input_as_handled()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if dragging:
				dragging = false
				freeze = false


func _physics_process(delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset




#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#print("Mouse just went down!")
		#elif event.is_released():
			#print("Mouse just went up!")
#

func _on_eaten_hurtbox_area_entered(area):
	emit_signal("eaten")
	queue_free()
	#pass
