class_name DeployableItem extends Node

var originator:Control

func ReturnIcon():
	if originator:
		originator.ReturnIcon()
	else:
		print("no originator")
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.MOUSE_CLICK_ACCEPT)
	get_parent().queue_free()
