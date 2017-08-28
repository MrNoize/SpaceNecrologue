var/global/daytime = "Night"

proc/DemoDayCycle()
	// a simple day/night cycle
	var
		time = 300	// how long it stays in this light state
		light = 0	// how much light there is outside
		d = 1		// amount of light increase
	while(1)	// keep doing until the program ends
		sleep(time)	// wait time ticks
		time = 300	// set time to the default
		light += d	// shift the light amount

		// if light level is outside the allowed range
		if((light < 0) || (light > 4))
			d = -d	// switch the direction of light changes
			light += d	// put light back where it was
			time = 600	// make this light period last longer

		// just sets the time of day for the stat display
		switch(d*light)
			if(-4,4)
				daytime = "Day"
			if(-3,-2,-1)
				daytime = "Dusk"
			if(0)
				daytime = "Night"
			if(1,2,3)
				daytime = "Dawn"

		sd_OutsideLight(light)	// tell the library to update all the outside areas