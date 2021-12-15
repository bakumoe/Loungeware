
// Exit
if keyboard_check_pressed(vk_f4) {
	game_end();
}

// Movement function
var _move_func = function(_move_x = 0, _move_y = 0, _error_sound = false) {
	enum baku_puzzle_move_return {
		moved, cant_move, no_direction, _size
	}
	
	if _move_x != 0 or _move_y != 0 {
		// Only do one or the other, no diagonal moves allowed!!
		
		// Left
		if _move_x == -1 {
			if empty_x > 0 {
				// success, swap empty and target
				var _empty_i			= xy_to_i(empty_x, empty_y, grid_w);
				var _target_i			= xy_to_i(empty_x - 1, empty_y, grid_w);
				var _empty_subimg		= grid_list[| _empty_i];
				var _target_subimg		= grid_list[| _target_i];
				grid_list[| _empty_i]	= _target_subimg;
				grid_list[| _target_i]	= _empty_subimg;
			} else {
				// error
				return baku_puzzle_move_return.cant_move;
			}
		}
		
		// Right
		if _move_x == 1 {
			if empty_x < grid_w - 1 {
				// success, swap empty and target
				var _empty_i			= xy_to_i(empty_x, empty_y, grid_w);
				var _target_i			= xy_to_i(empty_x + 1, empty_y, grid_w);
				var _empty_subimg		= grid_list[| _empty_i];
				var _target_subimg		= grid_list[| _target_i];
				grid_list[| _empty_i]	= _target_subimg;
				grid_list[| _target_i]	= _empty_subimg;
			} else {
				// error
				return baku_puzzle_move_return.cant_move;
			}
		}
		
		// Up
		if _move_y == -1 {
			if empty_y > 0 {
				// success, swap empty and target
				var _empty_i			= xy_to_i(empty_x, empty_y, grid_w);
				var _target_i			= xy_to_i(empty_x, empty_y - 1, grid_w);
				var _empty_subimg		= grid_list[| _empty_i];
				var _target_subimg		= grid_list[| _target_i];
				grid_list[| _empty_i]	= _target_subimg;
				grid_list[| _target_i]	= _empty_subimg;
			} else {
				// error
				return baku_puzzle_move_return.cant_move;
			}
		}
		
		// Up
		if _move_y == 1 {
			if empty_y < grid_h - 1 {
				// success, swap empty and target
				var _empty_i			= xy_to_i(empty_x, empty_y, grid_w);
				var _target_i			= xy_to_i(empty_x, empty_y + 1, grid_w);
				var _empty_subimg		= grid_list[| _empty_i];
				var _target_subimg		= grid_list[| _target_i];
				grid_list[| _empty_i]	= _target_subimg;
				grid_list[| _target_i]	= _empty_subimg;
			} else {
				// error
				return baku_puzzle_move_return.cant_move;
			}
		}
		
		// Find empty xy
		for (var i = 0; i < grid_w * grid_h; ++i) {
			var _x = i_to_x(i, grid_w);
			var _y = i_to_y(i, grid_w);
			var _id = grid_list[| i];
			
			if _id == puzzles[current_puzzle].empty_subimg {
				empty_x = _x;
				empty_y = _y;
			}
		}
		return baku_puzzle_move_return.moved;
		
	} else {
		return baku_puzzle_move_return.no_direction;
	}
}

// Test shuffle step
if KEY_PRIMARY_PRESSED {
	show_debug_message("\nStarted shuffling...");
	enum baku_puzzle_shuffle_dir {
		right, down, left, up, _size
	}
	var _dir_last = -1;
	var _moved = false;
	show_debug_message("- Started a shuffle step...");
	while !_moved {
		var _dir = irandom(3) * 90;
		show_debug_message("- - Trying to move:   x " + string(dcos(_dir)) + "   y " + string(dsin(_dir)));
		var _return = _move_func(dcos(_dir), dsin(_dir), false);
		if _return == baku_puzzle_move_return.moved {
			_moved = true;
			_dir_last = _dir;
			show_debug_message("- - - That worked! I moved the piece :>");
		}
	}
	show_debug_message("Done shuffling!\n");
}



// Scheme A (moving pieces into the hole)
var _move_x = KEY_LEFT_PRESSED - KEY_RIGHT_PRESSED;
var _move_y = KEY_UP_PRESSED - KEY_DOWN_PRESSED;

// Scheme B (moving the hole)
// var _move_x = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
// var _move_y = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);¨

// Actually move
_move_func(_move_x, _move_y, false);


