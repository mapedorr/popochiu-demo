tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


func _ready() -> void:
	if Globals.picked_apple: disable(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: That apple will stop Popsy from crying.',
		"Player: But I can't reach it.",
	]), 'completed')


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
	
	if item.script_name == 'Hook':
		Globals.picked_apple = true
		E.run([
			A.play('sfx_tree_impact', true),
			disable(),
			A.play('sfx_apple_fall'),
			I.add_item('Apple'),
			'Player: Yeeeeeeey!',
			'Player: I have food for Popsy!'
		])
