#may change this whole thing to AnimatoinpLayer
extends Node

@export var sprite : Sprite2D
@export var animation_player : AnimationPlayer
@onready var running_timer : Timer = $RunningTimer

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
var running : bool = false
var midair : bool = true

func _ready():
	choose_animal()
	

func choose_frame(frame : int):
	sprite.frame = frame


func choose_animal():
	current_animal = animals.keys().pick_random()
	choose_frame(animals[current_animal]["falling"])
	print(animals[current_animal])
	
	
func animal_on_ground():
	midair = false
	animation_player.stop()
	choose_frame(animals[current_animal]["resting"])
	
	
func animal_in_air():
	midair = true
	choose_frame(animals[current_animal]["falling"])
	
	
func animal_running():
	#pass
	if animals[current_animal]["running"]:
		animation_player.play(animals[current_animal]["running"])


func _on_running_timer_timeout():
	if not midair:
		var rng = RandomNumberGenerator.new()
		var random_num = rng.randf_range(0.0, 1.0)
		if random_num <= 0.5:
			print("animal running")
			running = true
			animal_running()
		else:
			print("animal resting")
			running = false
			animal_on_ground()
