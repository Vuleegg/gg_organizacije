ESX = exports['es_extended']:getSharedObject()

function MafijeLogovi(name, message)
    local poruka = {
        {
            ["color"] = 2061822,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
        ["text"] = os.date'%d/%m/%Y [%X]',
            },
        }
      }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "GG  » Logovi", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end