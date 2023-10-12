/datum/asset/spritesheet/rcd
	name = "rcd-tgui"

/datum/asset/spritesheet/rcd/create_spritesheets()
	for(var/root_category in GLOB.rcd_designs)

<<<<<<< HEAD
	//load all category essential icon_states. format is icon_file = list of icon states we need from that file
	var/list/essentials = list(
		'icons/obj/chairs.dmi' = list("bar"),
		'icons/obj/machines/wallmounts.dmi' = list("apc", "alarm_bitem", "fire_bitem"),
		'icons/obj/lighting.dmi' = list("floodlight_c1"),
		'icons/obj/assemblies/stock_parts.dmi' = list("box_1"),
		'icons/obj/bed.dmi' = list("bed"),
		'icons/obj/smooth_structures/catwalk.dmi' = list("catwalk-0"),
		'icons/hud/radial.dmi' = list("cnorth", "csouth", "ceast", "cwest", "chair", "secure_windoor", "stool", "wallfloor", "windowsize", "windowtype", "windoor"),
		'icons/obj/structures.dmi' = list("glass_table", "rack", "rwindow0", "reflector_base", "table", "window0", "girder"),
	)

	var/icon/icon
	for(var/icon_file as anything in essentials)
		for(var/icon_state as anything in essentials[icon_file])
			icon = icon(icon = icon_file, icon_state = icon_state)
			if(icon_state == "window0" || icon_state == "rwindow0")
				icon.Blend(icon(icon = 'icons/obj/structures.dmi', icon_state = "grille"), ICON_UNDERLAY)
			Insert(sprite_name = sanitize_css_class_name(icon_state), I = icon)

	//for each airlock type we create its overlayed version with the suffix Glass in the sprite name
	var/list/airlocks = list(
		"Standard" = 'icons/obj/doors/airlocks/station/public.dmi',
		"Public" = 'icons/obj/doors/airlocks/public/glass.dmi',
		"Engineering" = 'icons/obj/doors/airlocks/station/engineering.dmi',
		"Atmospherics" = 'icons/obj/doors/airlocks/station/atmos.dmi',
		"Security" = 'icons/obj/doors/airlocks/station/security.dmi',
		"Command" = 'icons/obj/doors/airlocks/station/command.dmi',
		"Medical" = 'icons/obj/doors/airlocks/station/medical.dmi',
		"Research" = 'icons/obj/doors/airlocks/station/research.dmi',
		"Freezer" = 'icons/obj/doors/airlocks/station/freezer.dmi',
		"Virology" = 'icons/obj/doors/airlocks/station/virology.dmi',
		"Mining" = 'icons/obj/doors/airlocks/station/mining.dmi',
		"Maintenance" = 'icons/obj/doors/airlocks/station/maintenance.dmi',
		"External" = 'icons/obj/doors/airlocks/external/external.dmi',
		"External Maintenance" = 'icons/obj/doors/airlocks/station/maintenanceexternal.dmi',
		"Airtight Hatch" = 'icons/obj/doors/airlocks/hatch/centcom.dmi',
		"Maintenance Hatch" = 'icons/obj/doors/airlocks/hatch/maintenance.dmi'
	)
	//these 3 types dont have glass doors
	var/list/exclusion = list("Freezer", "Airtight Hatch", "Maintenance Hatch")

	for(var/airlock_name in airlocks)
		//solid door with overlay
		icon = icon(icon = airlocks[airlock_name] , icon_state = "closed" , dir = SOUTH)
		icon.Blend(icon(icon = airlocks[airlock_name], icon_state = "fill_closed", dir = SOUTH), ICON_OVERLAY)
		Insert(sprite_name = sanitize_css_class_name(airlock_name), I = icon)

		//exclude these glass types
		if(airlock_name in exclusion)
=======
		var/list/category_designs = GLOB.rcd_designs[root_category]
		if(!length(category_designs))
>>>>>>> e6d08225d29 ([MIRROR] General code maintenance for rcd devices and their DEFINE file [MDB IGNORE] (#24300))
			continue

		for(var/category in category_designs)
			var/list/designs = category_designs[category]

			var/sprite_name
			var/icon/sprite_icon
			for(var/list/design as anything in designs)
				var/atom/movable/path = design[RCD_DESIGN_PATH]
				if(!ispath(path))
					continue
				sprite_name = initial(path.name)

				//icon for windows are blended with grills if required and loaded from radial menu
				if(ispath(path, /obj/structure/window))
					if(path == /obj/structure/window)
						sprite_icon = icon(icon = 'icons/hud/radial.dmi', icon_state = "windowsize")
					else if(path == /obj/structure/window/reinforced)
						sprite_icon = icon(icon = 'icons/hud/radial.dmi', icon_state = "windowtype")
					else if(path == /obj/structure/window/fulltile || path == /obj/structure/window/reinforced/fulltile)
						sprite_icon = icon(icon = initial(path.icon), icon_state = initial(path.icon_state))
						sprite_icon.Blend(icon(icon = 'icons/obj/structures.dmi', icon_state = "grille"), ICON_UNDERLAY)

				//icons for solid airlocks have an added solid overlay on top of their glass icons
				else if(ispath(path, /obj/machinery/door/airlock))
					var/obj/machinery/door/airlock/airlock_path = path
					var/airlock_icon = initial(airlock_path.icon)

					sprite_icon = icon(icon = airlock_icon, icon_state = "closed")
					if(!initial(airlock_path.glass))
						sprite_icon.Blend(icon(icon = airlock_icon, icon_state = "fill_closed"), ICON_OVERLAY)

				//for all other icons we load the paths default icon & icon state
				else
					sprite_icon = icon(icon = initial(path.icon), icon_state = initial(path.icon_state))

				Insert(sanitize_css_class_name(sprite_name), sprite_icon)
