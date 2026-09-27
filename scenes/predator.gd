extends Node2D

@onready var belly = $Belly

var belly_increase : float = 0.08

func _ready():
	print(belly.scale)


func _on_edible_eaten():
	belly.scale += Vector2(belly_increase, belly_increase)
