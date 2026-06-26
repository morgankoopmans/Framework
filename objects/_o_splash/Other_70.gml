var _type = async_load[? "type"];

if (_type == "video_start") {
	displayVideo = true;
} else if (_type == "video_end") {
    displayVideo = false;
    instance_destroy();
}