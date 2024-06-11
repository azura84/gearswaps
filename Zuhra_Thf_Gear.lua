-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc')
    state.HybridMode:options('Normal','DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','DT','SomeAcc','Acc','FullAcc','Proc')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT','EVA')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Twash','Twashacc','Aeneas','Aeolian','Savage','ProcWeapons','Evisceration','TH')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.stp_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind ^r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	send_command('bind !r gs c weapons MagicWeapons')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')
	send_command('lua u Singer.lua')
	send_command('lua u Superwarp.lua')

    lockstyleset = 2

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = {ammo="Per. Lucky Egg",head="Wh. Rarab Cap +1",hands="Plunderer's Armlets +1",waist="Chaac Belt",feet="Skulk. Poulaines +1"}
    sets.Kiting = {feet="Jute Boots +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {"Pill. Armlets +1"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Reiki Yotai"}
	sets.Parry = {}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	-- Weapons sets
    sets.weapons.Twash = {main="Twashtar",sub="Centovente"}
    sets.weapons.Twashacc = {main="Twashtar",sub="Ternion Dagger +1"}
	sets.weapons.Aeneas = {main="Aeneas",sub="Twashtar"}
	sets.weapons.Aeolian = {main="Gandring",sub="Malevolence"}
	sets.weapons.Savage = {main="Naegling",sub="Gleti's Knife"}
	sets.weapons.ProcWeapons = {main="Blurred Knife +1",sub="Atoyac"}
	sets.weapons.Evisceration = {main="Tauret",sub="Gleti's Knife"}
	sets.weapons.TH = {main="Gandring",sub="Sandung"}
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = {}
		
    sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {feet="Rogue's Poulaines"} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest"} 
    sets.precast.JA['Steal'] = {} --feet="Pillager's Poulaines +1"
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

	sets.Self_Waltz = {}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        head=gear.herculean_fc_head,
        neck="Voltsurge Torque",
        ear1="Enchntr. Earring +1",
        ear2="Loquac. Earring",
        body="Dread Jupon",
        hands="Leyline Gloves",
        ring1="Lebeche Ring",
        ring2="Prolix Ring",
        legs="Rawhide Trousers"
        }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="C. Palug Stone",
        head="Pill. Bonnet +3",
        neck="Asn. Gorget +2",
        ear1="Moonshade Earring",
        ear2="Odr Earring",
        body={ name="Herculean Vest", augments={'DEX+7','Weapon skill damage +9%','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
        hands="Meg. Gloves +2",
        ring1="Karieyh Ring",
        ring2="Regal Ring",
        back=gear.wsd_jse_back,
        waist="Kentarch Belt +1",
        legs="Lustratio subligar +1",
        feet="Lustratio leggings +1",
        }
        
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].DT = set_combine(sets.precast.WS["Rudra's Storm"],{})
    
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
        ammo="Yetshila +1",
        body="Meg. Cuirie +2",
        legs="Pill. Culottes +3"
        })
    
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {
        ammo="Yetshila +1",
        body="Meg. Cuirie +2",
        hands="Pill. Armlets +3",
        legs="Pill. Culottes +3"
        })
        
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {
        ammo="Yetshila +1",
        body="Meg. Cuirie +2",
        hands="Pill. Armlets +3",
        legs="Pill. Culottes +3"
        })

    --sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    --sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    --sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
	--sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.wsd_jse_back})
    --sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {ammo="C. Palug Stone",body=gear.herculean_wsd_body})
    --sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila +1",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Pill. Culottes +3"})
    --sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila +1",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",hands="Pill. Armlets +3",legs="Pill. Culottes +3"})
    --sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila +1",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",hands="Pill. Armlets +3",legs="Pill. Culottes +3"})

    --sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    --sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    --sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
	--sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.wsd_jse_back})
    --sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {ammo="C. Palug Stone",body=gear.herculean_wsd_body})
    --sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila +1",body="Meg. Cuirie +2",legs="Pill. Culottes +3"})
    --sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila +1",body="Meg. Cuirie +2",hands="Pill. Armlets +3",legs="Pill. Culottes +3"})
    --sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila +1",body="Meg. Cuirie +2",hands="Pill. Armlets +3",legs="Pill. Culottes +3"})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Adhemar Bonnet +1",
        ear1="Moonshade Earring",
        ear2="Odr Earring",
        neck="Fotia Gorget",
        body="Abnoba Kaftan",
        hands="Mummu Wrists +2",
        ring1="Begrudging Ring",
        waist="Fotia Belt",
        legs="Pill. Culottes +3",
        feet="Mummu Gamash. +2"
        })
    
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Adhemar Jacket +1",
        back=gear.wsd_jse_back,
        waist="Sailfi Belt +1"
        })
        
    sets.precast.WS["Savage Blade"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Savage Blade"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"],{})
	sets.precast.WS["Savage Blade"].DT = set_combine(sets.precast.WS["Savage Blade"],{})
    sets.precast.WS["Savage Blade"].SA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {})
    sets.precast.WS["Savage Blade"].TA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {})
    sets.precast.WS["Savage Blade"].SATA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {})

    sets.precast.WS.Proc = {}

    sets.precast.WS['Last Stand'] = {}
		
    sets.precast.WS['Empyreal Arrow'] = {}
		
    sets.precast.WS['Aeolian Edge'] = {
        ammo="Seeth. Bomblet +1",
        head=gear.herculean_nuke_head,
        neck="Baetyl Pendant",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Metamor. Ring +1",
        ring2="Shiva Ring +1",
        back=gear.wsd_jse_back,
        waist="Chaac Belt",
        legs="Nyame Flanchard",
        feet=gear.herculean_nuke_feet
        }

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Sherida Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head=gear.herculean_fc_head,
        neck="Voltsurge Torque",
        ear1="Enchntr. Earring +1",
        ear2="Loquac. Earring",
        body="Dread Jupon",
        hands="Leyline Gloves",
        ring1="Defending Ring",
        ring2="Prolix Ring",
        back="Moonlight Cape",
        waist="Tempus Fugit",
        legs="Rawhide Trousers",
        feet="Malignance Boots"
        }

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
        neck="Loricate Torque +1",
        ear1="Eabani Earring",
        ear2="Hearty Earring",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Defending Ring",
        ring2="Moonlight Ring",
        back=gear.stp_jse_back,
        waist="Flume Belt",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
        }
		
    sets.idle.Sphere = set_combine(sets.idle, {})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = {}

    -- Defense sets

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Sanare Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Moonlight Ring",
        back="Shadow Mantle",
        waist="Flume Belt +1",
        legs="Malignance Tights",
        feet="Malignance Boots"
        }
	    sets.defense.EVA = {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Sanare Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Moonlight Ring",
        back="Shadow Mantle",
        waist="Flume Belt +1",
        legs="Malignance Tights",
        feet="Malignance Boots"
        }
	
    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Sanare Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Shadow Ring",
        back="Engulfer Cape +1",
        waist="Engraved Belt",
        legs="Malignance Tights",
        feet="Malignance Boots"
        }
		
	sets.defense.MEVA = {
        ammo="Staunch Tathlum +1",
		head=gear.herculean_fc_head,
        neck="Warder's Charm +1",
        ear1="Etiolation Earring",
        ear2="Sanare Earring",
		body="Adhemar Jacket +1",
        hands="Malignance Gloves",
        ring1="Vengeful Ring",
        ring2="Purity Ring",
		back="Mujin Mantle",
        waist="Engraved Belt",
        legs="Malignance Tights",
        feet="Malignance Boots"
        }


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
        ammo="Yetshila +1",
        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
        body="Pillager's Vest +2",
        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
        legs="Pillager's Culottes +2", --{ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}}
        feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
        neck={ name="Asn. Gorget +2", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Sherida Earring",
        right_ear="Odr Earring",
        left_ring="Gere Ring",
        right_ring="Hetairoi Ring",
        back=gear.stp_jse_back,
        }
		
    sets.engaged.SomeAcc = {}
    
	sets.engaged.Acc = {}
		
    sets.engaged.FullAcc = {}

    sets.engaged.Fodder = {}

    sets.engaged.DT = {
        ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Moonlight Ring",
        back=gear.stp_jse_back,
        waist="Reiki Yotai",
        legs="Malignance Tights",
        feet="Malignance Boots"
        }

    sets.engaged.SomeAcc.DT = {}
		
    sets.engaged.Acc.DT = {}

    sets.engaged.FullAcc.DT = {}
		
    sets.engaged.Fodder.DT = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(6, 5)
    end
end

function user_job_lockstyle()
	if player.equipment.main == nil or player.equipment.main == 'empty' then
		windower.chat.input('/lockstyleset 001')
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
				windower.chat.input('/lockstyleset 007')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
			windower.chat.input('/lockstyleset 007')
		else
			windower.chat.input('/lockstyleset 007') --Catchall just in case something's weird.
		end
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
			windower.chat.input('/lockstyleset 008')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
			windower.chat.input('/lockstyleset 008')
		else
			windower.chat.input('/lockstyleset 008') --Catchall just in case something's weird.
		end
	end
end

autows_list = {['Aeneas']="Rudra's Storm",['Aeolian']='Aeolian Edge',['Savage']='Savage Blade',['Throwing']="Rudra's Storm",['SwordThrowing']='Savage Blade',['Evisceration']='Evisceration',['ProcWeapons']='Wasp Sting',['Bow']='Empyreal Arrow'}