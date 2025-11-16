class_name BrightnessModeAffector extends Node

@export_group("ColorRect")
@export var colorRect_lightMode:Color
@export var colorRect_darkMode:Color

@export_group("RichTextLabel")
@export var richTextLabel_lightMode:Color
@export var richTextLabel_darkMode:Color

@export_group("")

func OnBrightnessModeToggle(toggled:bool):
	if toggled:
		print("to dark mode")
		ToDarkMode()
	else: 
		print("to light mode")
		ToLightMode()

func ConformBrightness():
	if Settings_Manager.darkMode:
		ToDarkMode()
	elif !Settings_Manager.darkMode:
		ToLightMode()


func ToLightMode():
	for object in get_tree().get_nodes_in_group("brightnessModeAffected"):
		print(object)
		match object.get_class():
			"ColorRect":
				object.color = colorRect_lightMode
			"RichTextLabel":
				object.add_theme_color_override("default_color", richTextLabel_lightMode)


func ToDarkMode():
	for object in get_tree().get_nodes_in_group("brightnessModeAffected"):
		print(object)
		match object.get_class():
			"ColorRect":
				object.color = colorRect_darkMode
			"RichTextLabel":
				object.add_theme_color_override("default_color", richTextLabel_darkMode)
