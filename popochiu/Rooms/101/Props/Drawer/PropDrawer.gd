tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


func _ready() -> void:
	$Sprite.frame = 1 if Globals.drawer_opened else 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	if $Sprite.frame == 0:
		yield(A.play('sfx_drawer_open', false, false), 'completed')
		$Sprite.frame = 1
		Globals.drawer_opened = true
		
		if not Globals.picked_key:
			E.run([
				'Player: Oh!',
				A.play('sfx_key'),
				I.add_item('Key'),
				'Player: Now I have a key!',
				'...',
				'Player: What this will be useful for?'
			])
			Globals.picked_key = true
	else:
		yield(A.play('sfx_drawer_close', false, false), 'completed')
		$Sprite.frame = 0
		Globals.drawer_opened = false


# When the node is right clicked
func on_look() -> void:
	# Replace the call to .on_look() to implement your code. This only makes
	# the default behavior to happen.
	.on_look()


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	# Replace the call to .on_item_used(item) to implement your code. This only
	# makes the default behavior to happen.
	.on_item_used(item)
