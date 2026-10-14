#! namespace UtilE class UEditorTheme

const ThemeSetter = preload("res://addons/_lib/util_e/src/theme/theme_setter.gd")

static func get_icon(icon_name:String, theme_type:String=&"EditorIcons"):
	var icon = EditorInterface.get_editor_theme().get_icon(icon_name, theme_type)
	return icon

static func get_size_of_control_type(type):
	var ins = type.new()
	EditorInterface.get_base_control().add_child(ins)
	var new_size = ins.size
	ins.hide()
	ins.queue_free()
	return new_size

class Variations:
	const MAIN_SCREEN_BUTTON = &"MainScreenButton"
	const FLAT_BUTTON = &"FlatButton"

class Settings:
	static func get_current_theme_style():
		return EditorInterface.get_editor_settings().get_setting("interface/theme/style")

	static func get_custom_theme_path():
		return EditorInterface.get_editor_settings().get_setting("interface/theme/custom_theme")
