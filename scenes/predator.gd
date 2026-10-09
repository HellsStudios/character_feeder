extends Node2D

@onready var belly = $Visuals/Belly
@onready var entire_animation_player = $EntireAnimationPlayer
@onready var body_animation_player = $BodyAnimationPlayer
@onready var belly_animation_player = $BellyAnimationPlayer
@onready var cover = $"../Cover"

var belly_increase : float = 0.08
var prey_eaten_count : int = 0
var gulping : bool = false

func _on_edible_eaten():
	gulping = true
	play_gulp_animation()
	
	
func increase_belly_size():
	prey_eaten_count += 1
	belly_animation_player.play("belly_enlarge")
	var current_scale : Vector2 = belly.scale
	var increased_x = current_scale.x + 0.1
	var increased_y = current_scale.y + 0.1
	var new_scale : Vector2 = Vector2(increased_x,increased_y )
	var tween = get_tree().create_tween()
	tween.tween_property(belly, "scale", new_scale, 0.15)
	if prey_eaten_count >= 3:
		if cover:
			cover.queue_free()
	#belly.scale += Vector2(belly_increase, belly_increase)


func play_gulp_animation():
	body_animation_player.play("gulp")


func _on_mouth_open_collision_area_entered(area):
	if not gulping:
		body_animation_player.play("mouth_open")


func _on_mouth_open_collision_area_exited(area):
	if not gulping:
		body_animation_player.play("idle")


func finished_gulping():
	gulping = false
