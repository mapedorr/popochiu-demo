extends Node
# (D) Data and functions to start branching dialogs and listen options selection.
# ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

signal option_selected(opt)
signal dialog_options_requested(options)
signal dialog_finished
signal inline_dialog_requested(options)

const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')

var active := false

var _trees := []


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# Starts a branching dialog identified by its script_name.
func show_dialog(script_name: String) -> void:
	var dialog: PopochiuDialog = E.get_dialog(script_name)
	
	if dialog:
		active = true
		dialog.start()
		
		yield(D, 'dialog_finished')
		
		active = false
		G.done()
	else:
		yield(get_tree(), 'idle_frame')


# Retorna la opción seleccionada en el diálogo creado en tiempo de ejecución.
# NOTA: El flujo del juego se pausa hasta que el jugador seleccione una opción.
func show_inline_dialog(opts: Array) -> PopochiuDialogOption:
	emit_signal('inline_dialog_requested', opts)
	return yield(D, 'option_selected')


func finish_dialog() -> void:
	emit_signal('dialog_finished')
