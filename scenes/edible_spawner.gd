extends Button

@export var edible_scene : PackedScene
@onready var predator = get_tree().get_first_node_in_group("predator")				
@onready var button_sprite = $ButtonSprite
@onready var audio_stream_player = $AudioStreamPlayer
@onready var spawn_marker_2d = $SpawnMarker2D

var button_scale_x_const : float
var button_scale_y_const : float

func _ready():
	button_scale_x_const = button_sprite.scale.x
	button_scale_y_const = button_sprite.scale.y
	print([button_scale_x_const, button_scale_y_const])


func spawn_edible():
	audio_stream_player.play()
	var edible_instance = edible_scene.instantiate()
	#edible_instance.global_position = spawn_marker_2d.global_position
	edible_instance.global_position = get_spawn_position()
	edible_instance.eaten.connect(predator._on_edible_eaten)	
	var main = get_tree().current_scene
	var edible_layer = get_tree().current_scene.get_node("EdibleLayer")
	edible_layer.add_child(edible_instance)


func _on_pressed():
	spawn_edible()


func get_spawn_position():
	var base_x = spawn_marker_2d.global_position.x
	var difference : float= 75.0
	var rng = RandomNumberGenerator.new()
	var random_x = rng.randf_range(base_x - difference, base_x + difference)
	
	return Vector2(random_x, spawn_marker_2d.global_position.y)


func _on_mouse_entered():
	var tween = get_tree().create_tween()
	var shrink_amt : float = 0.9
	var target_scale_x = button_scale_x_const * shrink_amt
	var target_scale_y = button_scale_y_const * shrink_amt
	var target_scale : Vector2 = Vector2(target_scale_x, target_scale_y)
	tween.tween_property(button_sprite, "scale", target_scale, 0.15)


func _on_mouse_exited():
	var tween = get_tree().create_tween()
	var target_scale : Vector2 = Vector2(button_scale_x_const, button_scale_y_const)
	tween.tween_property(button_sprite, "scale", target_scale, 0.15)
