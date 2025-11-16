class_name Icon_DragItem extends DragItem

var iconTexture:TextureRect = null
var iconLabel:RichTextLabel = null

@export var deployable:PackedScene

func _ready():
	if get_node("IconTexture"): iconTexture = get_node("IconTexture")
	if get_node("IconLabel"): iconLabel = get_node("IconLabel")
	mouse_entered.connect(OnMouseEnter)
	mouse_exited.connect(OnMouseExit)

func OnMouseEnter():
	Audio_Manager.CreateAudio(SoundEffect.SoundEffectType.MOUSE_CLICK_SINGLE)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_SPRING)
	
func OnMouseExit():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_SPRING)

func IconDrag():
	set_drag_preview(GenerateIconPreview())
	
	iconTexture.hide()
	iconLabel.hide()
	
	return self
	
func _get_drag_data(_at_position):
	print("receiving drag data")
	return IconDrag()

func GenerateIconPreview():
#region texture copy
	var previewTexture = TextureRect.new()
	previewTexture.texture = iconTexture.texture
	previewTexture.expand_mode = 1
	previewTexture.size = iconTexture.size
#endregion

#region center icon texture
	previewTexture.set_anchors_preset(Control.PRESET_CENTER)
	
	var iconSize = previewTexture.get_size()
	previewTexture.offset_left = -iconSize.x / 2
	previewTexture.offset_right = iconSize.x / 2
	previewTexture.offset_bottom = iconSize.y / 2
	previewTexture.offset_top = -iconSize.y / 2
#endregion
	
#region label copy
	var previewLabel = RichTextLabel.new()
	previewLabel.bbcode_enabled = true
	previewLabel.text = iconLabel.text
	previewLabel.size = iconLabel.size
	previewLabel.scroll_active = false
	previewLabel.add_theme_font_size_override("normal_font_size", 12)
#endregion

#region center label
	#slight misnomer, centers label horizontally beneath centered icon
	previewLabel.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	
	var labelSize = previewLabel.get_size()
	previewLabel.offset_left = -labelSize.x / 2
	previewLabel.offset_right = labelSize.x / 2
	previewLabel.offset_bottom = labelSize.y / 2
	previewLabel.offset_top = -labelSize.y / 2
	
	previewLabel.position.y = iconTexture.get_size().y / 2
#endregion
	
	var preview = Control.new()
	preview.add_child(previewTexture)
	preview.add_child(previewLabel)
	
	return preview
	
func ReturnIcon():
	print("return icon")
	iconTexture.show()
	iconLabel.show()
	
func _drop_data(_at_position, data):
	if data is Icon_DragItem:
		print("caught data")
		data.ReturnIcon()
	elif data is Window_DragItem:
		pass
	else: pass
