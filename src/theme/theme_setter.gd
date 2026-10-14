@tool
extends Node

const EditorColors = preload("uid://cpw0fsrs38esk") #! resolve UtilE.Colors
const ThemeColor = EditorColors.ThemeColor
const UNode = preload("uid://bnf4h0107r8b4") #! resolve UtilR.UNode

const STYLE_BOX_TYPES = ["panel", "normal"]

@export var color = ThemeColor.BASE:
	set(val):
		color = val
		_set_theme()

@export var color_multiply:Color = Color(1,1,1)

func _ready() -> void:
	_set_theme()

func _set_theme():
	var parent = get_parent()
	if not parent:
		return
	
	set_theme_color(parent, color, color_multiply)

static func set_theme_color(node, color_type:=ThemeColor.BASE, _color_multiply:=Color(1,1,1)):
	var _color = EditorColors.get_theme_color(color_type)
	_color = _color * _color_multiply
	
	if node is ColorRect:
		node.color = _color
		return
	
	var style_box_type
	for style in STYLE_BOX_TYPES:
		if node.has_theme_stylebox(style):
			style_box_type = style
			break
	if style_box_type:
		var stylebox = node.get_theme_stylebox(style_box_type).duplicate()
		if stylebox is StyleBoxFlat:
			stylebox.bg_color = _color
		node.add_theme_stylebox_override(style_box_type, stylebox)

static func set_theme_setters_in_scene(root_node):
	var nodes = UNode.recursive_get_nodes(root_node)
	for node in nodes:
		var node_name = String(node.name)
		if node_name.begins_with("ThemeSet"):
			var theme_setter = new()
			node.add_child(theme_setter)
			var setting = node_name.get_slice("ThemeSet", 1)
			if setting == "":
				setting = "NONE"
			setting = setting.to_upper()
			theme_setter.overide_color = ThemeColor.get(setting)
