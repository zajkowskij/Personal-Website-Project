class_name Catch_DropArea extends DropArea

func _drop_data(_at_position, data):
	if data is Icon_DragItem:
		print("caught data")
		data.ReturnIcon()
	elif data is Window_DragItem:
		pass
	else: pass
