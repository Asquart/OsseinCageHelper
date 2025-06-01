local strings = {
	OCH_LANG = "en",
	
	OCH_InitMSG			=		"[OCH] Thanks for using Asquart's Ossein Cage Helper. Please send any issues on discord to asquart",
	OCH_OsiMSG			=		"Please install |cff0000OdySupportIcons|r's latest version (optional dependency) to see all the addon features, including markers.",

	OCH_Tri1			=		"A Trifecta! Impressive!",
	OCH_Tri2			=		"Now how about...",
	OCH_Tri3			=		"... touch grass ?",

	OCH_CarrionShield	=		"Carrion Shield", -- .lang  A749908 
	OCH_SpectralRevenant	=	"Osteon Spectral Revenant", -- .lang A117765 
	OCH_Abductor		    =	"Dreadful Abductor", -- .lang  A117260

	OCH_GednaRelvel		    =	"Red Witch Gedna Relvel", -- .lang A117896
	OCH_TorturedRanyu		=	"Tortured Ranyu", -- .lang A117738
	OCH_BloodDrkinerThisa	=	"Blood Drinker Thisa", -- .lang A117733

	OCH_ShaperOfFlesh	=		"Shaper of Flesh", -- .lang A117215
	OCH_Fleshspawn		=		"Fleshspawn", -- .lang A118330
	OCH_Channeler		=		"Channeler", -- .lang A117220
	OCH_Harvester		=		"Harvester", -- .lang A117354
	OCH_Daedroth		=		"Daedroth", -- .lang A117348

	OCH_Jynorah			=		"Jynorah", -- .lang A117683
	OCH_Skorknif		=		"Skorkhif", -- .lang A117684
	OCH_Valneer			=		"Blazeforged Valneer", -- .lang A117108
	OCH_Myrinax			=		"Sparkstorm Myrinax", -- .lang A117107

	OCH_Kazpian			=		"Overfiend Kazpian", -- .lang A117085
	OCH_AgonizerBomb	=		"Agonizer Bomb", -- .lang A118272
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end