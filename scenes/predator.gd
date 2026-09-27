extends Node2D

@onready var belly = $Belly

var belly_increase : float = 0.08

func _ready():
	print(belly.scale)


func _on_edible_eaten():
	increase_belly_size()
	
	
func increase_belly_size():
	var current_scale : Vector2 = belly.scale
	var increased_x = current_scale.x + 0.1
	var increased_y = current_scale.y + 0.1
	var new_scale : Vector2 = Vector2(increased_x,increased_y )
	var tween = get_tree().create_tween()
	tween.tween_property(belly, "scale", new_scale, 0.15)
	#belly.scale += Vector2(belly_increase, belly_increase)
