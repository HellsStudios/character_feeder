extends RigidBody2D

var dragging := false
var drag_offset := Vector2.ZERO

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
	print("area ent")


func _on_eaten_hurtbox_body_entered(body):
	print("body ent")
