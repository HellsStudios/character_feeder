extends Node2D

@onready var belly = $Belly

func _on_edible_eaten():
	print('eaten & digested')
