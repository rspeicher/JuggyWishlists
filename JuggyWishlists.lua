-- Huge thanks to tekkub's Engravings for most of this code.
Wishlists = {}
local origs = {}
local R, G, B = 1, 136/255, 0
local db

local function initdb()
	return JuggyWishlist_Data
end
Wishlists.initdb = initdb

local function OnTooltipSetItem(frame, ...)
	if not db then db = initdb() end

	local name, link = frame:GetItem()
	if link then
		local link_id = tonumber(link:match("item:(%d+):"))
		for id,notes in pairs(db) do
			if id == link_id then
				frame:AddLine(" ", 0, 0, 0)
				for index, note in ipairs(notes) do
					frame:AddDoubleLine(note[2], note[1], R, G, B, R, G, B)
				end
			end
		end
	end
	if origs[frame] then return origs[frame](frame, ...) end
end

for _,frame in pairs{GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2} do
	origs[frame] = frame:GetScript("OnTooltipSetItem")
	frame:SetScript("OnTooltipSetItem", OnTooltipSetItem)
end