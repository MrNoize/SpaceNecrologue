var
	sd_dark_icon = 'sd_darkstates.dmi'	// icon used for darkness
	sd_dark_shades = 4					// number of icon state in sd_dark_icon
	sd_light_layer = 50		// graphics layer for light effects
	sd_light_outside = 0	// how bright it is outside
	sd_top_luminosity = 0
	list
		sd_outside_areas = list()	// list of outside areas
		sd_light_spill_turfs = list()	// list of turfs to calculate light spill from

proc
	sd_OutsideLight(n as num)
	// set the brightness of the outside sunlight
		if(sd_light_outside == n) return	// same level, no update
		if(sd_light_outside)
			for(var/turf/T in sd_light_spill_turfs)
				T.sd_StripSpill()
		sd_light_outside = n

		// make all the outside areas update themselves
		for(var/area/A in sd_outside_areas)
			A.sd_LightLevel(sd_light_outside + A.sd_light_level,0)
		if(n)
			for(var/turf/T in sd_light_spill_turfs)
				T.sd_ApplySpill()

	sd_SetDarkIcon(icon, shades)
		// reset the darkness icon and number of shades of darkness
		sd_dark_icon = icon
		sd_dark_shades = shades
		// change existing areas
		for(var/area/A)
			if(A.sd_darkimage) A.sd_LightLevel(A.sd_light_level,0)


atom
	New()
		..()
		// if this is not an area and is luminous
		if(!isarea(src)&&(luminosity>0))
			sd_ApplyLum()

	Del()
		// if this is not an area and is luminous
		if(!isarea(src)&&(luminosity>0))
			sd_StripLum()
		..()

	proc
		sd_ApplyLum(list/V = view(luminosity,src), center = src)
			if(src.luminosity>sd_top_luminosity)
				sd_top_luminosity = src.luminosity
			// loop through all the turfs in V
			for(var/turf/T in V)
				/*	increase the turf's brightness depending on the
					brightness and distance of the lightsource */
				T.sd_lumcount += (luminosity-get_dist(center,T))
				//	update the turf's area
				T.sd_LumUpdate()

		sd_StripLum(list/V = view(luminosity,src), center = src)
			// loop through all the turfs in V
			for(var/turf/T in V)
				/*	increase the turf's brightness depending on the
					brightness and distance of the lightsource */
				T.sd_lumcount -= (luminosity-get_dist(center,T))
				//	update the turf's area
				T.sd_LumUpdate()

		sd_ApplyLocalLum(list/affected = view(sd_top_luminosity,src))
			// Reapplies the lighting effects of all atoms in affected.
			for(var/atom/A in affected)
				if(A.luminosity) A.sd_ApplyLum()
				if(sd_light_outside && (A in sd_light_spill_turfs))
					A:sd_ApplySpill()

		sd_StripLocalLum()
			/*	strips all local luminosity

				RETURNS: list of all the luminous atoms stripped

				IMPORTANT! Each sd_StripLocalLum() call should have a matching
					sd_ApplyLocalLum() to restore the local effects. */
			var/list/affected = list()
			for(var/atom/A in view(sd_top_luminosity,src))
				var/turfflag = (isturf(src)?1:0)
				if(A.luminosity && (get_dist(src,A) <= A.luminosity + turfflag))
					A.sd_StripLum()
					affected += A

				if(sd_light_outside && (A in sd_light_spill_turfs))
					A:sd_StripSpill()
					affected += A

			return affected

		sd_SetLuminosity(new_luminosity as num)
			/*	This proc should be called everytime you want to change the
				luminosity of an atom instead of setting it directly.

				new_luminosity is the new value for luminosity. */
			if(luminosity>0)
				sd_StripLum()
			luminosity = new_luminosity
			if(luminosity>0)
				sd_ApplyLum()

		sd_SetOpacity(new_opacity as num)
			/* if(opacity != new_opacity)
				var/list/affected = sd_StripLocalLum()
				opacity = new_opacity
				sd_ApplyLocalLum(affected) */
			if(opacity == (new_opacity ? 1 : 0)) return
			var
				list
					affected = new
					spill
				atom/A
				turf
					T
					ATurf
			affected = new
			for(A in range(sd_top_luminosity,src))
				T = A
				while(T && !istype(T)) T = T.loc
				if(T)
					var/list/V = view(A.luminosity,T)
					if(!(src in V)) continue
					var/turfflag = 0
					if(A == T) turfflag = 1
					if(A.luminosity && get_dist(A,src)<=A.luminosity+turfflag)
						affected[A] = V
					if(sd_light_outside && (A in sd_light_spill_turfs))
						if(!spill) spill=new
						spill[A] = view(sd_light_outside, T)
			opacity = new_opacity
			if(opacity)
				for(A in affected)
					ATurf = A
					while(ATurf && !istype(ATurf)) ATurf = ATurf.loc
					if(ATurf)
						for(T in affected[A]-view(A.luminosity, ATurf))
							T.sd_lumcount -= (A.luminosity-get_dist(A,T))
							T.sd_LumUpdate()
				for(A in spill)
					if(A.opacity && A!=src) continue
					ATurf = A
					while(ATurf && !istype(ATurf)) ATurf = ATurf.loc
					if(ATurf)
						//spill[A] -= view(sd_light_outside, A)
						for(T in (A==src)?spill[A]:(spill[A]-view(sd_light_outside,ATurf)))
							if(T.loc:sd_outside) continue
							T.sd_lumcount -= (sd_light_outside-get_dist(A,T))
							T.sd_LumUpdate()
				// end new_opacity = 1 block
			else
				for(A in affected)
					ATurf = A
					while(ATurf && !istype(ATurf)) ATurf = ATurf.loc
					if(ATurf)
						for(T in view(A.luminosity, ATurf) - affected[A])
							T.sd_lumcount += (A.luminosity-get_dist(A,T))
							T.sd_LumUpdate()
				for(A in spill)
					if(A.opacity) continue
					ATurf = A
					while(ATurf && !istype(ATurf)) ATurf = ATurf.loc
					if(ATurf)
						for(T in (A==src)?spill[A]:(view(sd_light_outside, ATurf)-spill[A]))
							if(T.loc:sd_outside) continue
							T.sd_lumcount += (sd_light_outside-get_dist(A,T))
							T.sd_LumUpdate()
				// end new_opacity = 0 block

turf
	var
		// set to 1 to have outside light spill indoors from this turf
		sd_light_spill = 0
		tmp
			sd_lumcount = 0	// the brightness of the turf

	proc
		sd_LumReset()
			/* Clear local lum, reset this turf's sd_lumcount, and
				re-apply local lum*/
			var/list/affected = sd_StripLocalLum()
			sd_lumcount = 0
			sd_ApplyLocalLum(affected)

		sd_LumUpdate()
			var/area/Loc = loc
			if(!istype(Loc) || !Loc.sd_lighting) return

			// change the turf's area depending on its brightness
			// restrict light to valid levels
			var/light = min(max(sd_lumcount,0),sd_dark_shades)
			var/ltag = copytext(Loc.tag,1,findtext(Loc.tag,"sd_L")) + "sd_L[light]"

			if(Loc.tag!=ltag)	//skip if already in this area
				var/area/A = locate(ltag)	// find an appropriate area
				if(!A)
					A = new Loc.type()	// create area if it wasn't found
					// replicate vars
					for(var/V in Loc.vars-"contents")
						if(issaved(Loc.vars[V])) A.vars[V] = Loc.vars[V]
					A.tag = ltag
					if(A.sd_outside)
						if(!(A in sd_outside_areas))
							sd_outside_areas += A
						A.sd_light_level = light
						A.sd_LightLevel(light + sd_light_outside,0)
					else
						A.sd_LightLevel(light)
				A.contents += src	// move the turf into the area

		sd_ApplySpill()
			if(opacity) return
			var/oldlum = luminosity
			luminosity = sd_light_outside
			// loop through all the turfs in V
			for(var/turf/T in view(sd_light_outside,src))
				var/area/A = T.loc
				if(!istype(A) || A.sd_outside) continue
				/*	increase the turf's brightness depending on the
					brightness and distance of the lightsource */
				T.sd_lumcount += (sd_light_outside-get_dist(src,T))
				//	update the turf's area
				T.sd_LumUpdate()
			luminosity = oldlum

		sd_StripSpill()
			if(opacity) return
			var/oldlum = luminosity
			luminosity = sd_light_outside
			// loop through all the turfs in V
			for(var/turf/T in view(sd_light_outside,src))
				var/area/A = T.loc
				if(!istype(A) || A.sd_outside) continue
				/*	increase the turf's brightness depending on the
					brightness and distance of the lightsource */
				T.sd_lumcount -= (sd_light_outside-get_dist(src,T))
				//	update the turf's area
				T.sd_LumUpdate()
			luminosity = oldlum

	New()
		..()
		if(sd_light_spill)
			sd_light_spill_turfs += src

atom/movable/Move() // when something moves
	var/turf/oldloc = loc	// remember for range calculations
	// list turfs in view and luminosity range of old loc
	var/list/oldview
	if(isturf(loc))
		oldview = view(luminosity,loc)
	else
		oldview = list()

	. = ..()

	if(.&&(luminosity>0))	// if the atom moved and is luminous
		if(istype(oldloc))
			sd_StripLum(oldview,oldloc)
			oldloc.sd_lumcount++	// correct "off by 1" error in oldloc
		sd_ApplyLum()

area
	var
		/*	Turn this flag off to prevent sd_DynamicAreaLighting from affecting
			this area */
		sd_lighting = 1

		/*	This var determines if an area is outside (affected by sunlight) or
			not.  */
		sd_outside = 0

		sd_light_level = 0	// the current light level of the area

		sd_darkimage	// tracks the darkness image of the area for easy removal

	proc
		sd_LightLevel(level = sd_light_level as num, keep = 1)
			if(!src) return
			overlays -= sd_darkimage

			if(keep) sd_light_level = level

			level = min(max(level,0),sd_dark_shades)	// restrict range

			if(level > 0)
				luminosity = 1
			else
				luminosity = 0

			sd_darkimage = image(sd_dark_icon,,num2text(level),sd_light_layer)
			overlays += sd_darkimage

	New()
		..()
		if(!tag) tag = "[type]"
		spawn(1)	// wait a tick
			if(sd_lighting)
				// see if this area was created by the library
				if(!findtext(tag,"sd_L"))
					/*	show the dark overlay so areas outside of luminous regions
						won't be bright as day when they should be dark. */
					sd_LightLevel()
		if(sd_outside)
			sd_outside_areas += src

mob
	/* extend the mob procs to compensate for sight settings. */
	sd_ApplyLum(list/V, center = src)
		if(!V)
			if(isturf(loc))
				V = view(luminosity,loc)
			else
				V = view(luminosity,src)
		. = ..(V, center)

	sd_StripLum(list/V, center = src)
		if(!V)
			if(isturf(loc))
				V = view(luminosity,loc)
			else
				V = view(luminosity,src)
		. = ..(V, center)

	sd_ApplyLocalLum(list/affected)
		if(!affected)
			if(isturf(loc))
				affected = view(sd_top_luminosity,loc)
			else
				affected = view(sd_top_luminosity,src)
		. = ..(affected)