extends AnimationPlayer

export var current_event = 0

# This is a test call to kickoff the first event
# Delete this block after the tests
# Start of test lines
func _ready() -> void:
	play_current_event()
# End of test lines


func play_event(event_index := current_event) -> void:
	var events_list: Array = get_animation_list()
	var animation_count := events_list.size()
	if event_index >= animation_count:
		return
	
	play(events_list[event_index])

func play_current_event() -> void:
	play_event()
	current_event += 1


# This is a test callback,
# disconnect the signal from the WaveSpawner2D after testing
# Start of test lines
func _on_WaveSpawner2D_spawned(spawn: Wave):
	spawn.start()
	yield(spawn, "finished")
	play_current_event()
# end of test lines
