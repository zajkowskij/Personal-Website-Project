class_name Table_DropArea extends DropArea

func _drop_data(at_position, data):
	print("dropping data onto table")
	print(at_position)
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.DRAG_RELEASE)
	var deployable:PackedScene = null
	if data is Icon_DragItem and data.deployable is PackedScene: 
		deployable = data.deployable
		var instantiatedDeployable = deployable.instantiate()
		if instantiatedDeployable is Control:
			add_child(instantiatedDeployable)
			instantiatedDeployable.position = at_position
			Settings_Manager.brightnessAffector.ConformBrightness()
			instantiatedDeployable.get_node("DeployableItem").originator = data
			if instantiatedDeployable.has_node("WebLink"): data.ReturnIcon()
		elif instantiatedDeployable is Node2D:
			var playArea = get_tree().get_first_node_in_group("2dPlayArea")
			playArea.add_child(instantiatedDeployable)
			instantiatedDeployable.global_position = get_viewport().get_mouse_position()
			data.ReturnIcon()
			pass
		elif instantiatedDeployable is Node:
			get_tree().root.add_child(instantiatedDeployable)
			data.ReturnIcon()
		else:
			print("instantiated deployable is of invalid class ", instantiatedDeployable.get_class())
			instantiatedDeployable.queue_free()
	elif data is Window_DragItem:
		data.position = at_position
