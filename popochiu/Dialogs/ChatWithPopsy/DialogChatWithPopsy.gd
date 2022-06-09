tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func start() -> void:
	# One can put here something to excecute before showing the dialog options.
	# E.g. Make the PC to look at the character which it will talk to, walk to
	# it, and say something (or make the character say something)
	
	# This makes the options to appear
	.start()


func option_selected(opt: PopochiuDialogOption) -> void:
	# Use match to check which option was selected and excecute something for
	# each one
	yield(C.player_say(opt.text, false), 'completed')
	
	match opt.id:
		'Opt1':
			yield(E.run([
				E.runnable(C.get_character('Popsy'), 'cry'),
				'Popsy(sad): Buaaaaaaaaa!!!',
			]), 'completed')
			opt.turn_off()
			get_option('Opt2').turn_on()
		'Opt2':
			yield(E.run([
				E.runnable(C.get_character('Popsy'), 'cry'),
				"Popsy(sad): I'm hungry!!!!",
			]), 'completed')
			opt.turn_off()
			get_option('Opt3').turn_on()
		'Opt3':
			yield(E.run([
				E.runnable(C.get_character('Popsy'), 'cry'),
				"Popsy(sad): Tiiiiiiiiiiiiiiiiiiii [color=#edf171](yes)[/color]!",
			]), 'completed')
		'Exit':
			yield(E.run([
				E.runnable(C.get_character('Popsy'), 'stop_crying'),
				"Popsy: Bye bye!",
			]), 'completed')
			D.finish_dialog()
			return
	
	_show_options()
