/datum/buildmode/lighting
	name = "Lighting"
	desc = {"***********************************************************<br>
Right Mouse Button on buildmode button = Toggle between set light to on / off<br>
Left Mouse Button                      = Apply to current Area<br>
Right Mouse Button                     = Attempt to fix Lighting on selected tile<br>
***********************************************************"}
	icon_state = "light_on"
	var/on = 1
	var/in_progress = 0

	click_mode_right(var/ctrl, var/alt, var/shift)
		if (on)
			update_icon_state("light_off")
			on = 0
		else
			update_icon_state("light_on")
			on = 1

	click_left(atom/object, var/ctrl, var/alt, var/shift)
		if (in_progress)
			return
		update_button_text("Updating...")
		in_progress = 1
		var/turf/T = get_turf(object)
		var/area/A = T.loc
		if(!on)
			A.luminosity = 1
			A.force_fullbright = 1
		else
			A.luminosity = 0
			A.force_fullbright = 0

		for(T in A) // T & A hehE HEHE SNARF SNARF FUCKING LOL
			T.RL_UpdateLight() //rl_reset didnt even exist lol
			blink(T) // Might be shit. Remove if shit.
			LAGCHECK(LAG_LOW)

		in_progress = 0
		update_button_text("")

	click_right(atom/object, var/ctrl, var/alt, var/shift)
		var/turf/T = get_turf(object)
		T.RL_UpdateLight()
		blink(T)
