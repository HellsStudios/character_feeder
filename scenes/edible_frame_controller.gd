#may change this whole thing to AnimatoinpLayer
extends Node

@export var sprite : Sprite2D
@export var animation_player : AnimationPlayer

var animals = {
	"rabbit": {
		"resting": 0,
		"falling": 12,
		"running": "rabbit_run"
	},
	"raccoon": {
		"resting": 1,
		"falling": 13,
		"running": "raccoon_run"
	},
	"beaver": {
		"resting": 2,
		"falling": 14,
		"running": "beaver_run"
	}
}

var current_animal: String

func _ready():
	choose_animal()
	

func choose_frame(frame : int):
	sprite.frame = frame


func choose_animal():
	current_animal = animals.keys().pick_random()
	choose_frame(animals[current_animal]["falling"])
	print(animals[current_animal])
	
	
func animal_on_ground():
	choose_frame(animals[current_animal]["resting"])
	
	
func animal_in_air():
	choose_frame(animals[current_animal]["falling"])
	
	
func animal_running():
	#pass
	if animals[current_animal]["running"]:
		animation_player.play(animals[current_animal]["running"])
