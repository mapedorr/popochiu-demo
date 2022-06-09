tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

var _is_crying := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	# Replace the call to .on_interact() to implement your code. This only makes
	# the default behavior to happen.
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: Oñiiiiiiiiiii [color=#edf171](hi)[/color]',
		'Popsy: Oñiiiiiiiiiiii [color=#edf171](hi)[/color]',
	]), 'completed')
	D.show_dialog('ChatWithPopsy')


# When the node is right clicked
func on_look() -> void:
	# Replace the call to .on_look() to implement your code. This only makes
	# the default behavior to happen.
	.on_look()


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	yield(E.run([
		C.face_clicked(),
		C.walk_to_clicked(),
	]), 'completed')
	
	if item.script_name == 'Apple':
		yield(E.run([
			'Player: Take this!',
			I.remove_item('Apple'),
#			A.play('vo_popsy_happy_01'),
#			E.runnable($AnimatedSprite, 'play', ['happy'], 'animation_finished'),
			'Popsy(happy): iiiiiiiiiiiiiiiiii\n[color=#edf171](Yeeeeeey!)[/color]',
			'Popsy(happy): Thank you so much!',
#			E.play_transition(TransitionLayer.PASS_DOWN_IN, 1.0),
		]), 'completed')
		E.goto_room('End')
	elif item.script_name == 'Hook':
		E.run([
			'Popsy: Dooooooooo! Do me peguí!\n[color=#edf171](Noooooooooo! Please no!)[/color]'
		])
	else:
		C.character_say('Popsy', 'Noooooooo! This is not food!', false)


func play_idle() -> void:
	if _is_crying: return
	$AnimatedSprite.play('idle')


func play_talk() -> void:
	if _is_crying: return
	
	if emotion == 'happy':
		$AnimatedSprite.play('happy')
	else:
		$AnimatedSprite.play('talk')


func cry() -> void:
	_is_crying = true
	$AnimatedSprite.play('cry')


func stop_crying() -> void:
	_is_crying = false
	.idle(false)
