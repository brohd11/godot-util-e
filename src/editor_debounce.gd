#! namespace UtilE class EditorDebounce
extends "res://addons/_lib/singleton/src/singleton_base.gd" #! ext Singletons.Base

const Debounce = preload("res://addons/_lib/util_r/src/signal/debounce.gd")

const PE_STRIP_CAST_SCRIPT = preload("res://addons/_lib/util_e/src/editor_debounce.gd")
static func get_singleton_name() -> String:
	return "EditorDebounce"

static func get_instance() -> PE_STRIP_CAST_SCRIPT:
	return _get_instance(PE_STRIP_CAST_SCRIPT)

static func instance_valid() -> bool:
	return _instance_valid(PE_STRIP_CAST_SCRIPT)

static func call_on_ready(callable, print_err:bool=true):
	_call_on_ready(PE_STRIP_CAST_SCRIPT, callable, print_err)

func _get_ready_bool() -> bool:
	return is_node_ready()

enum DebounceType {
	FRAME,
	TIMER,
	DEFER,
}

var _debounce_node

func _ready() -> void:
	_debounce_node = Debounce.new()
	add_child(_debounce_node)

static func debouncing(key:Variant):
	return get_instance()._debounce_node._current_debounces.has(key)

static func start_debounce(key:Variant, type:DebounceType=DebounceType.FRAME, time:=1) -> bool:
	print(get_instance().get_script())
	return get_instance()._debounce_node.start_debounce(key, type as int, time)
