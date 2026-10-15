#! namespace UtilE class UEditor
const BACKPORTED = 100

# TODO decide if this belongs here...
const EdNodeRef = preload("uid://rcceanby83e4") #! resolve EditorNodes.EditorNodeRef

enum ToastSeverity{
	INFO,
	WARNING,
	ERROR
}
static func push_toast(message, severity:ToastSeverity=ToastSeverity.INFO, print=true):
	var sev = severity #as int
	if BACKPORTED >= 4:
		EditorInterface.get_editor_toaster().push_toast(message, sev)
	
	if print == true or BACKPORTED < 4:
		if sev == 0:
			print(message)
		elif sev == 1:
			print_warn(message)
		elif sev == 2:
			printerr(message)

static func print_warn(message):
	print_rich("[color=#fedd66]Warning: %s[/color]" % message)



#deprecated
static func get_editor_node_path(node):
	return edited_scene_path_to_node(node)
static func get_editor_node_by_path(node_path):
	return edited_scene_get_node(node_path)

static func edited_scene_path_to_node(node:Node):
	var editor_scene_root = EditorInterface.get_edited_scene_root()
	if node == editor_scene_root or node.owner == editor_scene_root:
		var path:NodePath = editor_scene_root.get_path_to(node)
		return path
	return null

static func edited_scene_get_node(node_path:NodePath):
	var editor_scene_root = EditorInterface.get_edited_scene_root()
	if node_path is not NodePath:
		node_path = NodePath(node_path)
	if editor_scene_root.has_node(node_path):
		var node = editor_scene_root.get_node(node_path)
		return node
	return null


static func get_current_scene_path():
	var open_scenes = EditorInterface.get_open_scenes()
	var scene_tabs = EdNodeRef.get_registered(EdNodeRef.Nodes.SCENE_TABS)
	var tab_bar = scene_tabs.get_child(0).get_child(0).get_child(0) as TabBar
	var current_tab_name = tab_bar.get_tab_title(tab_bar.current_tab)
	for scene_path in open_scenes:
		var base_name = scene_path.get_basename()
		if base_name.ends_with(current_tab_name):
			return scene_path

static func dummy_node(target=null):
	var root = EditorInterface.get_edited_scene_root()
	if target == null:
		target = root
	var dummy = Node3D.new()
	target.add_child(dummy)
	dummy.owner = root
	dummy.queue_free()
