local IgnorePunctuation = {
".", "?", "[", "]", "-", "+", ")", "(", "*", "^", "%", "$"
}

local Alphabet = "abcdefghijklmnopqrstuvwxyz1234567890"

local FilterTable = {}
FilterTable["niger"] = "Good Mate"
FilterTable["n1ger"] = "nice guy"
FilterTable["nig3r"] = "great guy"
FilterTable["n1g3r"] = "best mate"
FilterTable["cunt"] = "charming lad"
FilterTable["pussy"] = "gentleman"
FilterTable["fag"] = "Charming Lad"
FilterTable["f4g"] = "Sweetie"
FilterTable["josucks"] = "I suck"
FilterTable["j0sucks"] = "I suck"
FilterTable["fgt"] = "attractive mate"
FilterTable["nigga"] = "good mate"
FilterTable["niga"] = "nice lad"
FilterTable["newfag"] = "new mate"
FilterTable["oldfag"] = "old mate"
FilterTable["faggot"] = "attractive mate"
FilterTable["furry"] = "cute lad"
FilterTable["porn"] = "cooking show"
FilterTable["shit"] = "My bad , mate!"
FilterTable["fuck you"] = "You're a friendly mate!"
FilterTable["fuckyou"] = "You're a friendly mate!"
FilterTable["fuck u"] = "You're a friendly mate!"
FilterTable["fucku"] = "You're a friendly mate!"
FilterTable["faku"] = "You're a friendly mate!"
FilterTable["ass"] = "good mate"
FilterTable["asshole"] = "attractive mate"
FilterTable["niqqa"] = "my best mate"
FilterTable["niqa"] = "my best mate"
FilterTable["go fuck yourself"] = "want some tea , mate?"
FilterTable["fuck yourself"] = "want some tea , mate?"
FilterTable["fuck"] = "Shiver me timbers"
FilterTable["suck"] = "friendly guy"
FilterTable["dick"] = "pipe"
FilterTable["rape"] = "Hot Coffee"
FilterTable["raping"] = "having hot coffee with"
FilterTable["tit"] = "Lolly"
FilterTable["tits"] = "Lolly pops"
FilterTable["boob"] = "melon"
FilterTable["boobs"] = "melons"
FilterTable["douche"] = "kind mate"
FilterTable["douchebag"] = "kind mate"
FilterTable["douche bag"] = "kind mate"
FilterTable["nigger"] = "charming lad"
FilterTable["n1gg3r"] = "charming lad"
FilterTable["n1gger"] = "attractive mate"
FilterTable["nigg3r"] = "atractive mate"
FilterTable["vag"] = "car"
FilterTable["penis"] = "pipe"

 

function Filter( pl, text, team, death )
	IgnoredTextTable = string.ToTable(string.lower(text))
	for k, v in pairs(IgnoredTextTable) do
		if !string.find(Alphabet, v, 1, true) then
			IgnoredTextTable[k] = ""
		end
	end
	local Char = ""
	for k, v in pairs(IgnoredTextTable) do
		if v != "" then
			if v == Char then
				IgnoredTextTable[k] = ""
			else
				Char = v
			end
		end
	end
	local FoundTable = {}
	local FoundCount = 0
	for k, v in pairs(FilterTable) do
		local Count = 1
		local Start
		local Word
		for x, z in pairs(IgnoredTextTable) do
			if z != "" then
				if z == string.sub(k, Count, Count) then
					if Count == 1 then
						Start = x
						Word = k
					end
					if Count == string.len(k) then
						FoundCount = FoundCount+1
						FoundTable[FoundCount] = {}
						FoundTable[FoundCount].End = x
						FoundTable[FoundCount].Start = Start
						FoundTable[FoundCount].Word = Word
						Count = 1
					end
					Count = Count + 1
				else
					Count = 1
				end
			end
		end
	end
	if FoundCount >0 then
		for k, v in pairs(FoundTable) do
			local StringTable = string.ToTable(text)
			for e, d in pairs(StringTable) do
				if e > v.Start and e < v.End then
					for x, z in pairs(IgnorePunctuation) do
						if string.find(d, z, 1, true) then
							StringTable[e] = " "
						end	
					end
				end
			end
			text = table.concat(StringTable, "")
			text = string.Replace(text, string.sub(text, v.Start, v.End), FilterTable[v.Word])
		end
	end
	return text
end

hook.Add( "PlayerSay", "FilterHook", Filter );