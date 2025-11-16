class_name Window_DragItem extends DragItem

@export var hasTextContent = true

func _ready() -> void:
	var textContent:RichTextLabel = null
	if hasTextContent: textContent = get_node("Panel/Content")
	if textContent != null and textContent.get_v_scroll_bar() != null:
		textContent.get_v_scroll_bar().value_changed.connect(OnScrollbarFound)

func OnScrollbarFound(_value:float):
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.SCROLLBAR)

func _get_drag_data(_at_position):
	print("receiving drag data")
	return WindowDrag()
	
	
func WindowDrag():
	print("window drag")
	var panelCopy = Panel.new()
	panelCopy.set_anchors_preset(Control.PRESET_CENTER)
	
	var panelSize = get_node("Panel").get_size()
	panelCopy.offset_left = -panelSize.x / 2
	panelCopy.offset_right = panelSize.x / 2
	panelCopy.offset_bottom = panelSize.y / 2
	panelCopy.offset_top = -panelSize.y / 2
	
	var preview = Control.new()
	preview.add_child(panelCopy)
	set_drag_preview(preview)
	
	return self

func _drop_data(_at_position, data):
	if data is Icon_DragItem:
		print("caught data")
		data.ReturnIcon()
	elif data is Window_DragItem:
		data.global_position = get_viewport().get_mouse_position()
	else: pass
