class_name DragItem extends Control

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("can drop data")
	print(at_position)
	print(data)
	print(data is Control)
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.DRAG)
	return data is Control
