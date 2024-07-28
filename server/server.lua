local core = Config.SetCore()

RegisterNetEvent("fz:setJob")
AddEventHandler("fz:setJob", function(job, grade)
    if Config.Core == "esx" then
        local xPlayer = core.GetPlayerFromId(source)
        if core.DoesJobExist(job, grade) then
            xPlayer.setJob(job, grade)
            TriggerClientEvent("notify", source, string.format(Config.Locales.settedJob, job))
        end
    else
        local Player = core.Functions.GetPlayer(source)
        Player.Functions.SetJob(job, grade)
        TriggerClientEvent("notify", source, string.format(Config.Locales.settedJob, job))
    end
end)
