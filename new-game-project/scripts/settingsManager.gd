class_name SettingsManager extends Node

var muted:bool = false
var darkMode:bool = false


var volumeControl:float:
	get:
		return volumeControl
	set(volume):
		volumeControl = clampf(volume, 0.0, 8.0)
		
var brightnessAffector:BrightnessModeAffector
		
func _ready():
	volumeControl = 1.0
	brightnessAffector = get_tree().get_first_node_in_group("brightnessModeAffector")
	if brightnessAffector != null: brightnessAffector.ToLightMode()
	#print("settings ready")
	
func ToggleDarkMode(toggled:bool):
	print("toggled dark mode")
	darkMode = toggled
	brightnessAffector.OnBrightnessModeToggle(darkMode)
	
func ToggleMute(toggled:bool):
	print("toggled mute")
	muted = toggled
	
func AdjustMasterVolume(newVolume:float):
	print("adjusted volume")
	volumeControl = newVolume
