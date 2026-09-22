extends Button

@export var edible_scene : PackedScene
@onready var predator = $"../Predator"

func _ready():
	pass
				
				
func spawn_edible():
	print('function hit')
	var edible_instance = edible_scene.instantiate()
	edible_instance.global_position = Vector2(100, 100)
	edible_instance.eaten.connect(predator._on_edible_eaten)
	
	var main = get_tree().current_scene
	main.add_child(edible_instance)
	


func _on_pressed():
	print('pressed')
	spawn_edible()
				
