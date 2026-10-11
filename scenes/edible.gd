extends RigidBody2D

signal eaten

@onready var edible_frame_controller = $EdibleFrameController

var dragging := false
var drag_offset := Vector2.ZERO
const RUN_VELOCITY : float = 2.5

func _ready():
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	edible_frame_controller.choose_animal()
	contact_monitor = true
	max_contacts_reported = 10

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
	elif edible_frame_controller.running:
		position.x += RUN_VELOCITY
	elif not edible_frame_controller.running:
		position.x += 0
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


func _on_body_entered(body):
	edible_frame_controller.animal_on_ground()
	#edible_frame_controller.animal_running()


func _on_body_exited(body):
	edible_frame_controller.animal_in_air()
	edible_frame_controller.running_timer.stop()


func _on_animal_start_to_run_timer_timeout():
	edible_frame_controller.running_timer.start()
