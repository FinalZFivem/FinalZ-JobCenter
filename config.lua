Config          = {}

Config.Core     = "esx"  --esx or qb
Config.openKey  = 38    --E
Config.oxTarget = true -- will use ox_lib
Config.textUI   = function(msg, type)
    if type == "show" then
        lib.showTextUI(msg)
    else
        lib.hideTextUI()
    end
end




Config.JobsCenterPos = {
    [1] = {
        coords = vector3(-249.4956, -965.1389, 31.2200),
        heading = 331.5708,
        drawRange = 10.0,
        openRange = 5.0,
        model = "a_f_m_beach_01",
        text = "Job Center",
        blipSettings = { type = 408, color = 49, scale = 0.8, name = "JOB CENTER"},
        jobs = {

            ["ambulance"] = {
                job = "ambulance",
                label = "Ambulance",
                description = "Good job for starters, you can make good money with it",
                salary = 300,
                benefits = {
                    "Good salary",
                    "Good dsa",
                    "Good salaryy",
                    "Good salaryy",
                    "Good salaryy",

                },
                grade = 3
            },
            ["butcher"] = {
                job = "butcher",
                label = "Butcher",
                description = "Good job for starters, you can make good money with it",
                salary = 300,
                benefits = {
                    "Good salary",

                },
                grade = 1
            },
            ["miner"] = {
                job = "miner",
                label = "Miner",
                description = "Good job for starters, you can make good money with it",
                salary = 300,
                benefits = {
                    "Good salary",
                    "Good salaryy",
                    "Good salaryy",
                    "Good salaryy",

                },
                grade = 1
            },
            ["lumberjack"] = {
                job = "lumberjack",
                label = "Lumberjack",
                description = "Good job for starters, you can make good money with it",
                salary = 300,
                benefits = {
                    "Good salary",
                },
                grade = 1
            },
            ["mechanic"] = {
                job = "mechanic",
                label = "Mechanic",
                description = "Good job for starters, you can make good money with it",
                salary = 300,
                benefits = {
                    "Good salary",
                    "Good salaryy",
                    "Good salaryy",
                    "Good salaryy",

                },
                grade = 1
            },
            ["police"] = {
                job = "police",
                label = "Police",
                description = "Good job for starters, you can make good money with it",
                salary = 300,
                benefits = {
                    "Good salary",
                    "Good dsa",
                    "Good salaryy",
                    "Good salaryy",
                    "Good salaryy",

                },
                grade = 1
            },
        }
    },
}


RegisterNetEvent("notify")
AddEventHandler("notify", function(msg, type)
    if Config.Core == "esx" then
        ESX.ShowNotification(msg, 5000, type)
    else
        QBCore.Functions.Notify(msg, type, 5000)
    end
end)


Config.Locales = {
    settedJob = "You have set your job to: %s",
}


Config.SetCore = function()
    if Config.Core == "esx" then
        ESX = exports["es_extended"]:getSharedObject()
        return ESX
    else
        QBCore = exports['qb-core']:GetCoreObject()
        return QBCore
    end
end