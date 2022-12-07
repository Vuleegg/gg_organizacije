Config = {}
Config.Debug = false -- da vidis zone(zahteva PolyZone)
Config.Blip = true -- ako zelite da  igraci vide blip na mapi gde im je organizacija(igrac mora uraditi relog radi refresh)
Config.WebHook = "VAS WEBHUK OVDE"

Config.Mafije = {
    zemunski = {
      MeniVozila = {
        ['sultanrs'] = 'SULTAN RS',
        ['bf400'] = 'Motor',
        ['blista'] = 'Blista'
      },
      kordinate = vector3(97.76, -1951.08, 19.76), --npc i meni vadjenja
      spawnvozila ={vector3(99.72, -1946.84, 20.76)}, --gde ce se vozilo spawnati
      heading = 333.36,
      sef = vector3(86.8, -1963.21, 20.75),
      sefheading = 59.68,
      tezina = 100000, -- koliko ce imati kila u sefu
      slotovi =  50, --koliko ce imati slotova u sefu
    },
}

Config.Prevod = {
  ["parkiranje"] = {
    message = 'Uspesno ste parkirali vozilo u garazu.',
  },
  ["izvadio"] = {
    message = 'Izvadili ste vozilo iz garaze.',
  },
  ["ulaznaporuka"] = {
    message = 'GG organizacije uspesno ucitane.',
  },
  ["nemadovoljno"] = {
    message = 'Nemate dovoljno itema za kraftanje!',
  },
  ["blip"] = {
    message = 'Vasa organizacija',
  },
  ["nemaigraca"] = {
    message = 'Nema igraca u vasoj blizini',
  },
  ["zakljucano"] = {
    message = 'Ne mozete da stavite osobu u auto dok je auto zakljucano!',
  },
  ["nijeuvozilu"] = {
    message = 'Osoba nije ni u jednom vozilu!!!',
  },
}

