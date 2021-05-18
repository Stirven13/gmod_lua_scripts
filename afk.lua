print("AntiAFK Script by Senko Kitsune")

print("antiafk_toggle - enabling or disabling AntiAFK")
print("antiafk_timer - the interval, in seconds")
print("antiafk_check - check time in afk")

CreateClientConVar( "antiafk_timer", 10)
local antiafk_on = 0
local antiafk_timer_on = 0


local function move( )
    RunConsoleCommand( "+score" )
    timer.Simple( .5, function( )
            RunConsoleCommand( "-score" )
    end )
end


local function chat_msg_rainbow(text)
	chat.AddText(Color(128 + math.random(127), 128 + math.random(127), 128 + math.random(127)), text)
end


local function antiafk_timer_function(chance)
	if antiafk_on == 1 then
		antiafk_timer_on = antiafk_timer_on + GetConVarNumber( "antiafk_timer" )
	end
	if math.random(chance) == 1 then
		hour = (antiafk_timer_on - antiafk_timer_on % 3600) / 3600
		minute = (antiafk_timer_on - antiafk_timer_on % 60) / 60 - hour * 60
		second = antiafk_timer_on - minute * 60 - hour * 3600
		if string.len(string.format("%s", hour)) == 1 then
			hour_string = string.format("0%s", hour)
		else
			hour_string = string.format("%s", hour)
		end
		if string.len(string.format("%s", minute)) == 1 then
			minute_string = string.format("0%s", minute)
		else
			minute_string = string.format("%s", minute)
		end
		if string.len(string.format("%s", second)) == 1 then
			second_string = string.format("0%s", second)
		else
			second_string = string.format("%s", second)
		end
		
		text = string.format("You stay AFK %s:%s:%s", hour_string, minute_string, second_string)
		chat_msg_rainbow(text)
	end
end


local function antiafk_timer_check()
	antiafk_timer_function(1)
end


local function antiafk( )
    if antiafk_on == 0 then
		chat_msg_rainbow("> AntiAfk working! <")
        timer.Create( "antiafk", GetConVarNumber( "antiafk_timer" ), 0, function( )
            move()
			antiafk_timer_function(5)
        end )
        antiafk_on = 1
    elseif antiafk_on == 1 then
		chat_msg_rainbow("> AntiAfk stoped! <")
        timer.Destroy( "antiafk" )
        antiafk_on = 0
		antiafk_timer_on = 0
    end
end

concommand.Add( "antiafk_toggle", antiafk )
concommand.Add( "antiafk_check", antiafk_timer_check )