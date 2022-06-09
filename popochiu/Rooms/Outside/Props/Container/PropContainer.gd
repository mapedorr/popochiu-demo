tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


func _ready() -> void:
	$Sprite.frame = 0
	
	if Globals.container_opened:
		$Sprite.frame = 2
	elif Globals.container_unlocked:
		$Sprite.frame = 1



# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked()
	]), 'completed')
	
	if not Globals.container_unlocked:
		E.run([
			A.play('sfx_container_locked'),
			'Player: I need the key for the lock.'
		])
	elif not Globals.container_opened:
		Globals.container_opened = true
		$Sprite.frame = 2
		E.run([
			room.get_prop('Hook').enable(),
			A.play('sfx_container_open', true),
			'Player: Great! A hook'
		])
	elif Globals.container_opened:
		C.player_say('A hook!', false)
	else:
		C.player_say('Nothing interesting here...', false)


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
	
	if item.script_name == 'Key':
		Globals.container_unlocked = true
		$Sprite.frame = 1
		E.run([
			I.remove_item('Key'),
			'Player: Great!'
		])
	else:
		C.player_say('What?', false)
