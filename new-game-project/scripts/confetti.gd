extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("GPUParticles2D").finished.connect(OnFinish)

func OnFinish():
	queue_free()
