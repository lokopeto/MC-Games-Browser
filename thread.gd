extends Node
var thread: Thread #freezes without multithread
var threads = []  # List to keep track of threads

func _process(delta: float) -> void:
	# Monitor threads and free them if done
	for thread in threads:
		if thread.is_active() == false:  # If the thread has finished
			thread.free()  # Free the thread
			threads.erase(thread)  # Remove it from the list
	
	if threads.size() == 0:
		print("All threads are done!")
		set_process(false)  # Stop monitoring once all threads are done

#thread finisher
func _exit_tree():
	for thread in [thread]:
		if thread:
			thread.wait_to_finish()
