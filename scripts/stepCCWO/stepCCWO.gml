var movement_angle = argument0
var movement_length = argument1
var movement_style = argument2
var movement_intrusion = argument3
var movement_duration =  argument4
var movement_percentage = (argument5 mod movement_duration) div movement_duration
// some magic timing numbers
var first_checkpoint = .33
var second_checkpoint = .66
var speed_spreading = 3
var speed_transfering = 3




//error code
if movement_angle <0 or movement_angle > 180  {
	show_error("wrong function called",true)
}
if movement_style != "normal" or movement_intrusion != "none" {
	show_error("not yet implemented",true)
}
// Move left foot
// foward is zero degrees
if movement_percentage == 0 {
	var initial_l_x = left_x
	var initial_l_y = left_y
	var initial_x = x
	var initial_y = y
	var initial_r_x = right_x
	var initial_r_y = right_y
}

if movement_percentage < first_checkpoint {
	left_x = initial_l_x + dsin(movement_angle)*speed_spreading *movement_percentage * movement_length
	left_y = initial_l_y + dcos(movement_angle)*speed_spreading *movement_percentage* movement_length
}

if movement_style == "normal" and movement_percentage >= first_checkpoint and movement_percentage < second_checkpoint {
	//move head shoulders and hips
	var movement_remaining = movement_percentage - first_checkpoint
	left_x = initial_l_x + dsin(movement_angle)* movement_length - dsin(movement_angle)*speed_transfering*movement_remaining* movement_length
	left_y = initial_l_y + dcos(movement_angle)* movement_length - dcos(movement_angle)*speed_transfering*movement_remaining* movement_length
	x = initial_x + dsin(movement_angle)*speed_transfering*movement_remaining* movement_length
	y = initial_y + dcos(movement_angle)*speed_transfering*movement_remaining* movement_length
	right_x = initial_r_x - dsin(movement_angle)*speed_transfering*movement_remaining* movement_length
	right_y = initial_r_y - dcos(movement_angle)*speed_transfering*movement_remaining* movement_length
}

// move right foot.
if movement_percentage >= second_checkpoint  {
	//snap to final position
	left_x = initial_l_x + dsin(movement_angle)* movement_length
	left_y = initial_l_y + dcos(movement_angle)* movement_length
	x = initial_x + dsin(movement_angle)* movement_length
	y = initial_y + dcos(movement_angle)* movement_length
	//move foot = initial + changing - offset
	var movement_remaining = movement_percentage- second_checkpoint
	right_x = initial_r_x + dsin(movement_angle)*speed_spreading *movement_remaining * movement_length - dsin(movement_angle)* movement_length
	right_y = initial_r_y + dcos(movement_angle)*speed_spreading *movement_remaining * movement_length - dcos(movement_angle)* movement_length
}