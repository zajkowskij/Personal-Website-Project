class_name WebLink extends Node

@export var linkString:String = ""
@export var loadImmediate:bool = true

func _ready():
	if !loadImmediate: return
	if linkString != "" and linkString != null:
		OS.shell_open(linkString)
	get_parent().queue_free()

func GoToSite(meta):
	OS.shell_open(meta)
