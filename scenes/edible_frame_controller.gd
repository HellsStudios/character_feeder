#may change this whole thing to AnimatoinpLayer
extends Node

@export var sprite : Sprite2D
@export var animation_player : AnimationPlayer

var animals = {
	"rabbit": {
		"resting": 0,
		"falling": 12
	},
	"raccoon": {
		"resting": 1,
		"falling": 13
	},
	"beaver": {
		"resting": 2,
		"falling": 14
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
	
	
func animal_on_ground():
	choose_frame(animals[current_animal]["resting"])
	
	
func animal_in_air():
	choose_frame(animals[current_animal]["falling"])
