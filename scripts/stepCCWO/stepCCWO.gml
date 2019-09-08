var movement_angle = argument0
var movement_length = argument1
var movement_style = argument2
var movement_intrusion = argument3
var movement_duration =  argument4
var movement_percentage = (argument5 mod movement_duration)/movement_duration
// some magic timing numbers
var first_checkpoint = .3
var second_checkpoint = .6
var speed_spreading = 3.33
var speed_transfering = 3.33
var third_checkpoint = .9




//error code
if movement_angle <0 or movement_angle > 180  {
	show_error("wrong function called",true)
}
if movement_style != "normal" or movement_intrusion != "none" {
	show_error("not yet implemented",true)
}
// Move left foot
// foward is zero degrees
if(movement_percentage == 0){
	initial_l_x = left_x
	initial_l_y = left_y
	initial_x = x
	initial_y = y
	initial_r_x = right_x
	initial_r_y = right_y
	delta_r_x = lengthdir_x(movement_length,movement_angle + 90)
	delta_r_y = lengthdir_y(movement_length,movement_angle + 90) 	
	delta_a_x = lengthdir_x(movement_length,movement_angle + facing)
	delta_a_y = lengthdir_y(movement_length,movement_angle + facing)
}

if(movement_percentage < first_checkpoint){
	left_x = initial_l_x - delta_r_x*speed_spreading *movement_percentage 
	left_y = initial_l_y - delta_r_y*speed_spreading *movement_percentage
}

if(movement_style == "normal" and movement_percentage >= first_checkpoint and movement_percentage < second_checkpoint){
	//move head shoulders and hips
	var movement_remaining = movement_percentage - first_checkpoint
	left_x = initial_l_x - delta_r_x * (1 - speed_transfering*movement_remaining)
	left_y = initial_l_y - delta_r_y * (1 - speed_transfering*movement_remaining)
	x = initial_x + delta_a_x*speed_transfering*movement_remaining
	y = initial_y + delta_a_y*speed_transfering*movement_remaining
	right_x = initial_r_x + delta_r_x*speed_transfering*movement_remaining
	right_y = initial_r_y + delta_r_y*speed_transfering*movement_remaining
}

// move right foot.
if(movement_percentage >= second_checkpoint and movement_percentage < third_checkpoint){
	//snap to final position
	left_x = initial_l_x
	left_y = initial_l_y
	x = initial_x + delta_a_x
	y = initial_y + delta_a_y
	//move foot = initial + changing - offset
	var movement_remaining = movement_percentage- second_checkpoint
	right_x = initial_r_x - delta_r_x * ( speed_spreading *movement_remaining -1)
	right_y = initial_r_y - delta_r_y * ( speed_spreading *movement_remaining -1)
}
if(movement_percentage >= third_checkpoint){
	right_x = initial_r_x
	right_y = initial_r_y	
}

