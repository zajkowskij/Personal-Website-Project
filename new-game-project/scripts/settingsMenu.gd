class_name SettingsMenu extends Node

func _ready():
	var darkmodeCheck:CheckButton = $"../Panel/ColorRect/DarkModeCheckbox"
	var muteCheck:CheckButton = $"../Panel/ColorRect/MuteCheckbox"
	var volumeSlider:HSlider = $"../Panel/ColorRect/VolumeGroup/HSlider"
	
	darkmodeCheck.connect("toggled", Settings_Manager.ToggleDarkMode)
	muteCheck.connect("toggled", Settings_Manager.ToggleMute)
	volumeSlider.connect("value_changed", Settings_Manager.AdjustMasterVolume)
	
	darkmodeCheck.button_pressed = Settings_Manager.darkMode
	muteCheck.button_pressed = Settings_Manager.muted
	volumeSlider.set_value_no_signal(Settings_Manager.volumeControl)
