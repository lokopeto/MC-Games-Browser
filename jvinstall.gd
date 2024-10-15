extends Node
@onready var mem: Node = $"../mem"

func _ready() -> void:
	Utils.java_type("temurin")
	mem.mem_auto()
	rcon_reset()

func java_install(java_version: String, thread: Thread): #install java from url with async support, java down for the urls
	var output = []
	var java_down

	if java_version == "8":
		java_down = Utils.java8_down
	elif java_version == "11":
		java_down = Utils.java11_down
	elif java_version == "17":
		java_down = Utils.java17_down
	elif java_version == "21":
		java_down = Utils.java21_down

#	print(java_down)

# argumments for the download of java. example: curl -L -o ./java/java8_down.zip -L "java download url"
	var java_exec = Utils.curl + "-L -o ./java/java" + java_version + "_down.zip -L " + java_down
	var java_download = OS.execute("CMD.exe", ["/C", java_exec], output) # execution of java_exec
#	print(output)
#	print(java_exec)

# argumments for the excration of the zip file. example: zip e ./java/java8_down.zip -o./java/java8
	var zip_exec = Utils.zip + "e -aoa ./java/java" + java_version + "_down.zip -o./java/java" + java_version + " && cd java && del java" + java_version + "_down.zip"
	var execute = OS.create_process("cmd", ["/C", zip_exec]) # execution of zip_exec
	

#	print(execute)
#	print(zip_exec)

	thread.wait_to_finish() #stop the thread

func rcon_reset(): #func for preparing rcon for stop the server
	
	var rcon = FileAccess.get_file_as_string("./servers/" + Utils.folder_name + "/server.properties").split("\n")

	#it splits the lines, find the propreties and replace the entire line

	for i in rcon:
		# Check for specific properties and modify them
		if i.begins_with("enable-rcon="):
			rcon[rcon.find(i)] = "enable-rcon=true"
		elif i.begins_with("rcon.port="):
			rcon[rcon.find(i)] = "rcon.port=" + str(Utils.rcon_port)
		elif i.begins_with("rcon.password="):
			rcon[rcon.find(i)] = "rcon.password=" + Utils.rcon_pass
		elif i.begins_with("broadcast-rcon-to-ops="):
			rcon[rcon.find(i)] = "broadcast-rcon-to-ops=false"

	rcon.resize(rcon.size() - 1) #removes "\n" in the end of the text 

	#writes the changes
	var file = FileAccess.open("./servers/" + Utils.folder_name + "/server.properties", FileAccess.WRITE)
	file.store_csv_line(rcon,"\n")
	file.close()

func _on_javainstall_pressed() -> void:
	for java_version in Utils.java_versions:
		var thread_java = Thread.new()  # Create a new thread

		thread_java.start(Callable(self, "java_install").bind(java_version, thread_java))  # Start thread with java version
