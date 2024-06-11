function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('DualTwash','TwashTern','TwashGleti','DualTauret','DualAeneas','DualCarnwenhan','DualNaegling','DualNukeWeapons','Tauret','Carnwenhan','Aeneas','None')
	state.UnlockWeapons = M(true, 'Unlock Weapons')
    state.CarnMode = M{'Always','300','1000','Never'}

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
    autofood = "Grape Daifuku"
    
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')
	send_command('lua l Singer.lua')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	ChironicMABGloves = { name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+6','"Mag.Atk.Bns."+12',}}
	ChironicMABBoots = { name="Chironic Slippers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Haste+1','INT+4','Mag. Acc.+13','"Mag.Atk.Bns."+15',}}
	
	IntarabusDA = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	IntarabusFC = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}
    IntarabusWSD = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

	-- Weapons sets
	sets.weapons.Tauret = {main="Tauret",sub="Genbu's Shield"}
	sets.weapons.Aeneas = {main="Aeneas",sub="Genbu's Shield"}
	sets.weapons.Carnwenhan = {main="Carnwenhan",sub="Ammurapi Shield"}
    sets.weapons.DualTwash = {main="Twashtar",sub="Centovente"}
    sets.weapons.TwashTern = {main="Twashtar",sub="Ternion Dagger +1"}
	sets.weapons.DualAeneas = {main="Aeneas",sub="Twashtar"}
	sets.weapons.DualCarnwenhan = {main="Carnwenhan",sub="Gleti's Knife"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Centovente"}
	sets.weapons.DualTauret = {main="Tauret",sub="Twashtar"}
	sets.weapons.DualNukeWeapons = {main="Malevolence",sub="Malevolence"}
    sets.weapons.TwashGleti = {main="Twashtar",sub="Gleti's Knife"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
        main="Kali",
        sub="Genbu's Shield",
        head="Bunzi's Hat",
        neck="Orunmila's Torque",
        ear1="Enchanter Earring +1",
        ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
        hands="Gendewitha Gages +1",
        ring1="Kishar Ring",
        ring2="Prolix Ring",
		back=IntarabusFC,
        waist="Embla Sash",
        legs="Aya. Cosciales +1",
        feet="Navon Crackows"
    }

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
        
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak",
        sub="Genbu's Shield"
    })
	
	sets.precast.FC.BardSong = {
		main="Kali",
        head="Fili Calot +1",
        neck="Orunmila's Torque",
        ear1="Enchanter Earring +1",
        ear2="Loquac. Earring",
        body="Inyanga jubbah +2",
        hands="Gendewitha Gages +1",
        ring1="Defending Ring", 
        ring2="Kishar Ring",
        back=IntarabusFC,
        waist="Embla Sash",
        legs="Aya. Cosciales +2",
        feet="Bihu Slippers +3"
    }

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Daurdabla"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC.Lullaby.Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Daurdabla"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +3"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Lustratio cap +1",
		body="Bihu Justaucorps +3",
		hands="Lustratio mittens +1",
		legs="Lustratio subligar +1",
		feet="Lustratio leggings +1",
		neck="Caro necklace",
		waist="Grunfeld rope",
		left_ear="Ishvara earring",
		right_ear="Moonshade earring",
		left_ring="Rajas Ring",
		right_ring="Apate Ring",
		back=IntarabusWSD
	}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS["Mordant Rime"] = {
		range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','Quadruple Attack +3',}},
		ammo=empty,
		head="Bihu Roundlet +3",
		body="Bihu Justaucorps +3",
		hands="Bihu Cuffs +3",
		legs="Bihu Cannions +3",
		feet="Bihu Slippers +3",
		neck="Caro Necklace",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Karieyh Ring",
		back=IntarabusWSD,
    }

	sets.precast.WS["Rudra's Storm"] = {
        range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','DEX+8',}},
        head="Lustratio Cap +1",
        body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
        hands={ name="Lustr. Mittens +1", augments={'Accuracy+30','VIT+13','DEX+10',}},
        legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
        feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
        neck="Fotia Gorget",
        waist={ name="Kentarch Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Ilabrat Ring",
        right_ring="Karieyh Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS["Evisceration"] = {
        range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','DEX+8',}},
        head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
        body="Ayanmo Corazza +2",
        hands={ name="Lustr. Mittens +1", augments={'Accuracy+30','VIT+13','DEX+10',}},
        legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
        feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Brutal Earring",
        left_ring="Begrudging Ring",
        right_ring="Hetairoi Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS["Aeolian Edge"] = {
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','Quadruple Attack +3',}},
		head="Cath Palug Crown",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Regal Earring",
		right_ear="Moonshade Earring",
		left_ring="Shiva Ring +1",
		right_ring="Shiva Ring +1",
		back=IntarabusWSD
	}
	
	sets.precast.WS["Savage Blade"] = {
		range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+8',}},
		head="Bihu Roundlet +3",
		body="Bihu Justaucorps +3",
		hands="Bihu Cuffs +3",
		legs="Bihu Cannions +3",
		feet="Bihu Slippers +3",
		neck="Fotia Gorget",
		waist="Sailfi belt +1",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
		left_ring="Rajas Ring",
        right_ring="Karieyh Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
    
    sets.precast.WS["Exenterator"] = {}

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {
        --main=gear.grioavolr_fc_staff,
        --sub="Clerisy Strap +1",
        --ammo="Hasty Pinion +1",
		--head="Nahtirah Hat",
        --neck="Voltsurge Torque",
        --ear1="Enchntr. Earring +1",
        --ear2="Loquac. Earring",
		--body="Inyanga Jubbah +2",
        --hands="Leyline Gloves",
        --ring1="Kishar Ring",
        --ring2="Lebeche Ring",
		--back=IntarabusFC,
        --waist="Witful Belt",
        --legs="Aya. Cosciales +2",
        --feet="Gende. Galosh. +1"
    }

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {range="Marsyas",hands="Brioso Cuffs +2"}
	sets.midcast.Lullaby.Resistant = {range="Marsyas",hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby'] = {range="Marsyas", hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Daurdabla",hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby'].AoE = {range="Daurdabla",hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby II'] = {range="Marsyas",hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Daurdabla",hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Daurdabla",hands="Brioso Cuffs +2"}
	sets.midcast.Madrigal = {head="Fili Calot +1"}
	sets.midcast.Paeon = {head="Brioso Roundlet +3"}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {legs="Mousai Seraweels"}
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast.Threnody = {body="Mousai Manteel +1"}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {legs="Fili rhingrave +1"}
	sets.midcast.Mazurka = {range="Marsyas"}

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
        main="Carnwenhan",
        range="Gjallarhorn",
        ammo=empty,
		head="Fili Calot +1",
        neck="Mnbw. Whistle +1",
        ear1="Etiolation Earring",
        ear2="Genmei Earring",
		body="Fili Hongreline +1",
        hands="Fili Manchettes +1",
        ring1="Defending Ring",
        ring2="Moonlight Ring",
		back=IntarabusFC,
        waist="Flume Belt",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3"
        }
		
	sets.midcast.SongEffect.DW = {main="Carnwenhan"}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Marsyas",
        ammo=empty,
		head="Brioso Roundlet +3",
        neck="Moonbow whistle +1",
        ear1="Regal Earring",
        ear2="Dignitary's Earring",
        body="Brioso Justaucorps +3",
        hands="Inyanga dastanas +2",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back=IntarabusFC,
        waist="Acuity Belt +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3"
        }
		
	sets.midcast.SongDebuff.DW = {main="Carnwenhan"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        ammo=empty,
		head="Brioso Roundlet +3",
        neck="Moonbow whistle +1",
        ear1="Regal Earring",
        ear2="Dignitary's Earring",
        body="Brioso Justaucorps +3",
        hands="Inyanga dastanas +2",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back=IntarabusFC,
        waist="Acuity Belt +1",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3"
        }

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Daurdabla",
        ammo=empty,
		head="Bunzi Hat",
        neck="Orunmila's Torque",
        ear1="Enchntr. Earring +1",
        ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
        hands="Gendewitha Gages +1",
        ring1="Kishar Ring",
        ring2="Prolix Ring",
		back=IntarabusFC,
        waist="Embla Sash",
        legs="Fili Rhingrave +1",
        feet="Aya. Gambieras +2"
        }
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	
	-- DUMMY SONGS HERE
	sets.midcast["Army's Paeon II"] = sets.midcast.DaurdablaDummy
	sets.midcast["Army's Paeon"] = sets.midcast.DaurdablaDummy
	sets.midcast["Army's Paeon III"] = sets.midcast.DaurdablaDummy
	sets.midcast["Army's Paeon IV"] = sets.midcast.DaurdablaDummy
    sets.midcast["Army's Paeon V"] = sets.midcast.DaurdablaDummy
    sets.midcast["Knight's Minne"] = sets.midcast.DaurdablaDummy
    sets.midcast["Knight's Minne II"] = sets.midcast.DaurdablaDummy
    sets.midcast["Knight's Minne III"] = sets.midcast.DaurdablaDummy
	
	-- Other general spells and classes.
	sets.midcast.Cure = {
        main="Daybreak",
        sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
        range="Marsyas",
        head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
        hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}},
        legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck="Incanter's Torque",
        waist="Luminary Sash",
        left_ear="Beatific Earring",
        right_ear="Meili Earring",
        left_ring="Defending Ring",
        right_ring="Stikini Ring +1",
        back="Tempered Cape +1",
    }
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
	sets.midcast['Enhancing Magic'] = {}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
		
	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
        neck="Debilis Medallion",
        hands="Hieros Mittens",
		back="Oretan. Cape +1",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        waist="Witful Belt",
        feet="Vanya Clogs"
    })
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	sets.resting = {}
	
	sets.idle = {
        main="Daybreak",
        sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
        range="Marsyas",
        head="Inyanga Tiara +2",
        body="Inyanga Jubbah +2",
        hands="Inyan. Dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Fili Cothurnes +1",
        neck="Loricate Torque +1",
        waist="Carrier's Sash",
        left_ear="Etiolation Earring",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Moonlight Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
		
	sets.idle.NoRefresh = {}

	sets.idle.DT = {}
	
	-- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
        range={ name="Linos", augments={'Accuracy+20','"Dbl.Atk."+3','Quadruple Attack +3',}},
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Bunzi's Gloves",
        legs="Volte Tights",
        --legs={ name="Telchine Braconi", augments={'Accuracy+20','"Store TP"+6','DEX+10',}},
        feet={ name="Chironic Slippers", augments={'Accuracy+19','STR+10','"Store TP"+9',}},
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Telos Earring",
        right_ear="Eabani Earring",
        left_ring="Petrov Ring",
        right_ring="Hetairoi Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	sets.engaged.DT = {}
	sets.engaged.Acc = {}
	sets.engaged.DW = {
        range={ name="Linos", augments={'Accuracy+20','"Dbl.Atk."+3','Quadruple Attack +3',}},
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Bunzi's Gloves",
        legs="Volte Tights",
        --legs={ name="Telchine Braconi", augments={'Accuracy+20','"Store TP"+6','DEX+10',}},
        feet={ name="Chironic Slippers", augments={'Accuracy+19','STR+10','"Store TP"+9',}},
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Telos Earring",
        right_ear="Eabani Earring",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
        }
	
	sets.engaged.DW.Acc = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 2)
end

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'dd' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Victory March" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Blade Madrigal" <me>; wait 4.5; input /ma "Valor Minuet V" <me>')
                add_to_chat(158,'March x2, Madrigal, Minuet')
	elseif commandArgs[1]:lower() == 'ddslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Victory March" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Blade Madrigal" <me>; wait 6; input /ma "Valor Minuet V" <me>')
                add_to_chat(158,'March x2, Madrigal, Minuet SLOW')
	elseif commandArgs[1]:lower() == 'ddacc' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Victory March" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Blade Madrigal" <me>; wait 4.5; input /ma "Sword Madrigal" <me>')
                add_to_chat(158,'March x2, Madrigal x2')
	elseif commandArgs[1]:lower() == 'ddaccslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Victory March" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Blade Madrigal" <me>; wait 6; input /ma "Sword Madrigal" <me>')
                add_to_chat(158,'March x2, Madrigal x2 SLOW')
	elseif commandArgs[1]:lower() == 'ddatt' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Victory March" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Valor Minuet V" <me>; wait 4.5; input /ma "Valor Minuet IV" <me>')
                add_to_chat(158,'March x2  Minuet x2')
	elseif commandArgs[1]:lower() == 'ddattslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Victory March" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Valor Minuet V" <me>; wait 6; input /ma "Valor Minuet IV" <me>')
                add_to_chat(158,'March x2, Minuet x2 SLOW')
	elseif commandArgs[1]:lower() == 'wave3' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Adventurer\'s Dirge" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Blade Madrigal" <me>; wait 4.5; input /ma "Valor Minuet V" <me>')
                add_to_chat(158,'March, Dirge, Madrigal, Minuet')
	elseif commandArgs[1]:lower() == 'wave3slow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Adventurer\'s Dirge" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Blade Madrigal" <me>; wait 6; input /ma "Valor Minuet V" <me>')
                add_to_chat(158,'March, Dirge, Madrigal, Minuet SLOW')
	elseif commandArgs[1]:lower() == 'wave3acc' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Adventurer\'s Dirge" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Blade Madrigal" <me>; wait 4.5; input /ma "Sword Madrigal" <me>')
                add_to_chat(158,'March, Dirge, Madrigal x2')
	elseif commandArgs[1]:lower() == 'wave3accslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Adventurer\'s Dirge" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Blade Madrigal" <me>; wait 6; input /ma "Sword Madrigal" <me>')
                add_to_chat(158,'March, Dirge, Madrigal x2 SLOW')
	elseif commandArgs[1]:lower() == 'wave3haste' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Adventurer\'s Dirge" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Blade Madrigal" <me>; wait 4.5; input /ma "Victory March" <me>')
                add_to_chat(158,'March x2, Dirge, Madrigal')
	elseif commandArgs[1]:lower() == 'wave3hasteslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Adventurer\'s Dirge" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Blade Madrigal" <me>; wait 6; input /ma "Victory March" <me>')
                add_to_chat(158,'March x2, Dirge, Madrigal SLOW')
	elseif commandArgs[1]:lower() == 'rngatt' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Valor Minuet V" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Valor Minuet IV" <me>; wait 4.5; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'March, Minuet x2, Prelude')
	elseif commandArgs[1]:lower() == 'rngattslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Valor Minuet V" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Valor Minuet IV" <me>; wait 6; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'March, Minuet x2, Prelude SLOW')
	elseif commandArgs[1]:lower() == 'rngacc' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Valor Minuet V" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Hunter\'s Prelude" <me>; wait 4.5; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'March, Minuet, Prelude x2')
	elseif commandArgs[1]:lower() == 'rngaccslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Valor Minuet V" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Hunter\'s Prelude" <me>; wait 6; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'March, Minuet, Prelude x2 SLOW')
	elseif commandArgs[1]:lower() == 'rngdirge' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Valor Minuet V" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Adventurer\'s Dirge" <me>; wait 4.5; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'March, Minuet, Dirge, Prelude')
	elseif commandArgs[1]:lower() == 'rngdirgeslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Valor Minuet V" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Adventurer\'s Dirge" <me>; wait 6; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'March, Minuet, Dirge, Prelude SLOW')
	elseif commandArgs[1]:lower() == 'rngmag' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Swift Etude" <me>; wait 4.5; input /ma "Quick Etude" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Hunter\'s Prelude" <me>; wait 4.5; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'AGI x2, Prelude x2')
	elseif commandArgs[1]:lower() == 'rngmagslow' then
		send_command('input /ma "Swift Etude" <me>; wait 6; input /ma "Quick Etude" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Hunter\'s Prelude" <me>; wait 6; input /ma "Archer\'s Prelude" <me>')
                add_to_chat(158,'AGI x2, Prelude x2 SLOW')
	elseif commandArgs[1]:lower() == 'bal3' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Mage\'s Ballad III" <me>; wait 4.5; input /ma "Mage\'s Ballad II" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Mage\'s Ballad" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Victory March" <me>')
                add_to_chat(158,'Ballad x3 March')
	elseif commandArgs[1]:lower() == 'bal3slow' then
		send_command('input /ma "Mage\'s Ballad III" <me>; wait 6; input /ma "Mage\'s Ballad II" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Mage\'s Ballad" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Victory March" <me>')
                add_to_chat(158,'Ballad x3 March SLOW')
	elseif commandArgs[1]:lower() == 'wave2jeuno' then
		send_command('input /ja "Soul Voice" <me>; wait 1; input /ja "Clarion Call" <me>; wait 1; input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ma "Honor March" <me>; wait 4.5; input /ma "Archer\'s Prelude" <me>; wait 4.5; input /ma "Hunter\'s Prelude" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Valor Minuet V" <me>; wait 4.5; input /ma "Adventurer\'s Dirge" <me>; wait 4.5; input /ja "Pianissimo" <me>; wait 1; input /ma "Blade Madrigal" Kitcho; wait 4.5; input /ja "Pianissimo" <me>; wait 1; input /ma "Sword Madrigal" Kitcho; wait 4.5; input /ja "Pianissimo" <me>; wait 1; input /ma "Mage\'s Ballad III" Dmitrius; wait 4.5; input /ja "Pianissimo" <me>; wait 1; input /ma "Mage\'s Ballad II" Dmitrius')
                add_to_chat(158,'JEUNO W2 LETS GOOOOOOO!')
	elseif commandArgs[1]:lower() == 'wave2jeunoslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Archer\'s Prelude" <me>; wait 6; input /ma "Hunter\'s Prelude" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Valor Minuet V" <me>; wait 6; input /ma "Adventurer\'s Dirge" <me>; wait 6; input /ja "Pianissimo" <me>; wait 1; input /ma "Blade Madrigal" Kitcho; wait 6; input /ja "Pianissimo" <me>; wait 1; input /ma "Sword Madrigal" Kitcho; wait 6; input /ja "Pianissimo" <me>; wait 1; input /ma "Mage\'s Ballad III" Dmitrius; wait 6; input /ja "Pianissimo" <me>; wait 1; input /ma "Mage\'s Ballad III" Dmitrius')
                add_to_chat(158,'JEUNO W2 SLOOOOOOOW!')
	elseif commandArgs[1]:lower() == 'erinys' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Wind Carol" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Blade Madrigal" <me>; wait 4.5; input /ma "Sword Madrigal" <me>')
                add_to_chat(158,'March, Madrigal x2, Wind Carol')
	elseif commandArgs[1]:lower() == 'erinysslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Wind Carol" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Blade Madrigal" <me>; wait 6; input /ma "Sword Madrigal" <me>')
                add_to_chat(158,'March, Madrigal x2, Wind Carol SLOW')
	elseif commandArgs[1]:lower() == 'shiva' then
		send_command('input /ja "Nightingale" <me>; wait 1; input /ja "Troubadour" <me>; wait 1; input /ja "Marcato" <me>; wait 2; input /ma "Honor March" <me>; wait 4.5; input /ma "Victory March" <me>; wait 4.5; input /ma "Knight\'s Minne" <me>; wait 4.5; input /ma "Knight\'s Minne II" <me>; wait 4.5; input /ma "Ice Carol" <me>; wait 4.5; input /ma "Ice Carol II" <me>')
                add_to_chat(158,'March x2  Ice Carol x2')
	elseif commandArgs[1]:lower() == 'shivaslow' then
		send_command('input /ma "Honor March" <me>; wait 6; input /ma "Victory March" <me>; wait 6; input /ma "Knight\'s Minne" <me>; wait 6; input /ma "Knight\'s Minne II" <me>; wait 6; input /ma "Ice Carol" <me>; wait 6; input /ma "Ice Carol II" <me>')
                add_to_chat(158,'March x2  Ice Carol x2 SLOW')
	elseif commandArgs[1]:lower() == 'fast' then
		send_command('input /ma "Chocobo Mazurka" <me>')
                add_to_chat(158,'MAXIMUM SPEED')
	elseif commandArgs[1]:lower() == 'aeolian' then
		send_command('gs c weapons DualAeolian;gs c update;aws off')
				add_to_chat(158,'Aeolian weapon set equiped')
	elseif commandArgs[1]:lower() == 'ddweapons' then
		send_command('gs c weapons DualTauret;gs c update;aws use rudra\'s storm')
				add_to_chat(158,'Rudra weapon set equiped')
	end
end