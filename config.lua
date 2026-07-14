Config = {}

Config.Framework = "auto" -- "auto" | "esx" | "qb" "qbox" | "standalone"
Config.Notification = "ox_lib" -- "ox_lib" | "esx" | "qb"
Config.InteractionType = "interact" -- "ox_target" | "qb-target" | "interact" (CUSTOM UI)
Config.FuelSystem = "LegacyFuel" -- "LegacyFuel" | "cdn-fuel" | "ox_fuel" | "lc_fuel" |

Config.GiveKeys = true -- FOR (qb-qbox)

Config.Rentals = {
    {
        id = "ls_airport",
        name = "Car Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(-1031.21, -2735.42, 20.24, 62.77),
        spawnCoords = {
            vector4(-1030.24, -2732.57, 19.71, 58.36),
        },
        blip = { enable = true, sprite = 530, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Faggio", brand = "MOTOR", model = "faggio", price = 100, image = "nui/images/vehicles/faggio.png" },
                    { name = "Blista", brand = "DINKA", model = "blista", price = 250, image = "nui/images/vehicles/blista.png" },
                }
            },
            {
                label = "Sport",
                vehicles = {
                    { name = "Turismo", brand = "VEHICLE", model = "turismo2", price = 250, image = "nui/images/vehicles/turismo2.png" },
                    { name = "Sultan", brand = "KARIN", model = "sultan", price = 500, image = "nui/images/vehicles/sultan.png" },
                    { name = "ZR350", brand = "VEHICLE", model = "zr350", price = 500, image = "nui/images/vehicles/zr350.png" },
                }
            }
        }
    },
    {
        id = "sandy_shores",
        name = "Car Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(1407.69, 3619.02, 34.89, 290.70),
        spawnCoords = {
            vector4(1420.39, 3623.71, 34.51, 199.17),
        },
        blip = { enable = true, sprite = 530, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Faggio", brand = "MOTOR", model = "faggio", price = 100, image = "nui/images/vehicles/faggio.png" },
                    { name = "Blista", brand = "DINKA", model = "blista", price = 250, image = "nui/images/vehicles/blista.png" },
                    { name = "Turismo", brand = "VEHICLE", model = "turismo2", price = 250, image = "nui/images/vehicles/turismo2.png" },
                    { name = "Sultan", brand = "KARIN", model = "sultan", price = 500, image = "nui/images/vehicles/sultan.png" },
                    { name = "ZR350", brand = "VEHICLE", model = "zr350", price = 500, image = "nui/images/vehicles/zr350.png" },
                }
            }
        }
    },
{
        id = "little_seoul",
        name = "Car Rental",
        enableCategories = true,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(-747.87, -1057.66, 12.00, 303.77),
        spawnCoords = {
            vector4(-750.63, -1044.85, 12.06, 295.67),
            vector4(-752.19, -1041.15, 12.31, 299.37),
            vector4(-754.01, -1038.07, 12.44, 296.90),
        },
        blip = { enable = true, sprite = 530, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All Vehicles",
                vehicles = {
                    { name = "Faggio", brand = "PEGASSI", model = "faggio", price = 80, image = "nui/images/vehicles/faggio.png" },
                    { name = "Blista", brand = "DINKA", model = "blista", price = 200, image = "nui/images/vehicles/blista.png" },
                    { name = "Sultan", brand = "KARIN", model = "sultan", price = 500, image = "nui/images/vehicles/sultan.png" },
                    { name = "ZR350", brand = "ANNIS", model = "zr350", price = 650, image = "nui/images/vehicles/zr350.png" },
                    { name = "Turismo R", brand = "GROTTI", model = "turismo2", price = 1500, image = "nui/images/vehicles/turismo2.png" },
                }
            },
            {
                label = "Motorcycles",
                vehicles = {
                    { name = "Faggio", brand = "PEGASSI", model = "faggio", price = 80, image = "nui/images/vehicles/faggio.png" },
                }
            },
            {
                label = "Compacts",
                vehicles = {
                    { name = "Blista", brand = "DINKA", model = "blista", price = 200, image = "nui/images/vehicles/blista.png" },
                }
            },
            {
                label = "Sports",
                vehicles = {
                    { name = "Sultan", brand = "KARIN", model = "sultan", price = 500, image = "nui/images/vehicles/sultan.png" },
                    { name = "ZR350", brand = "ANNIS", model = "zr350", price = 650, image = "nui/images/vehicles/zr350.png" },
                }
            },
            {
                label = "Super",
                vehicles = {
                    { name = "Turismo R", brand = "GROTTI", model = "turismo2", price = 1500, image = "nui/images/vehicles/turismo2.png" },
                }
            }
        }
    },
    {
        id = "rockford_vinewood",
        name = "Car Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords =  vector4(-61.83, -207.86, 45.81, 161.73),
        spawnCoords = {
            vector4(-63.31, -215.53, 45.10, 157.72),
            vector4(-67.27, -213.93, 45.10, 159.02),
            vector4(-60.08, -216.73, 45.10, 158.51),
        },
        blip = { enable = true, sprite = 530, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Faggio", brand = "MOTOR", model = "faggio", price = 100, image = "nui/images/vehicles/faggio.png" },
                    { name = "Blista", brand = "DINKA", model = "blista", price = 250, image = "nui/images/vehicles/blista.png" },
                    { name = "Turismo", brand = "VEHICLE", model = "turismo2", price = 250, image = "nui/images/vehicles/turismo2.png" },
                    { name = "Sultan", brand = "KARIN", model = "sultan", price = 500, image = "nui/images/vehicles/sultan.png" },
                    { name = "ZR350", brand = "VEHICLE", model = "zr350", price = 500, image = "nui/images/vehicles/zr350.png" },
                }
            }
        }
    },
    {
        id = "paleto_bay",
        name = "Car Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(-247.01, 6240.32, 31.49, 219.49),
        spawnCoords = {
            vector4(-242.80, 6232.29, 31.14, 133.70),
        },
        blip = { enable = true, sprite = 530, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Faggio", brand = "MOTOR", model = "faggio", price = 100, image = "nui/images/vehicles/faggio.png" },
                    { name = "Blista", brand = "DINKA", model = "blista", price = 250, image = "nui/images/vehicles/blista.png" },
                    { name = "Turismo", brand = "VEHICLE", model = "turismo2", price = 250, image = "nui/images/vehicles/turismo2.png" },
                    { name = "Sultan", brand = "KARIN", model = "sultan", price = 500, image = "nui/images/vehicles/sultan.png" },
                    { name = "ZR350", brand = "VEHICLE", model = "zr350", price = 500, image = "nui/images/vehicles/zr350.png" },
                }
            }
        }
    },
    -- =============================
    -- BOAT 
    -- =============================
    {
        id = "boat_park",
        name = "Boat Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(-1799.43, -1224.43, 1.59, 145.33),
        spawnCoords = {
            vector4(-1796.15, -1230.91, 0.38, 319.94),
        },
        blip = { enable = true, sprite = 427, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Jet max", brand = "boat", model = "jetmax", price = 2500, image = "nui/images/boats/jetmax.png" },
                    { name = "Sea Shark", brand = "boat", model = "seashark2", price = 599, image = "nui/images/boats/seashark2.png" },
                    { name = "Sun trap", brand = "boat", model = "suntrap", price = 5000, image = "nui/images/boats/suntrap.png" },
                }
            }
        }
    },
    {
        id = "boat_paleto",
        name = "Boat Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(-277.16, 6639.31, 7.56, 222.96),
        spawnCoords = {
            vector4(-284.58, 6644.16, -0.29, 46.90),
        },
        blip = { enable = true, sprite = 427, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Jet max", brand = "boat", model = "jetmax", price = 2500, image = "nui/images/boats/jetmax.png" },
                    { name = "Sea Shark", brand = "boat", model = "seashark2", price = 599, image = "nui/images/boats/seashark2.png" },
                    { name = "Sun trap", brand = "boat", model = "suntrap", price = 5000, image = "nui/images/boats/suntrap.png" },
                }
            }
        }
    },
    {
        id = "boat_sandy",
        name = "Boat Rental",
        enableCategories = false,
        npcModel = "s_m_m_postal_01",
        npcCoords = vector4(1522.19, 3917.67, 31.67, 255.43),
        spawnCoords = {
            vector4(1524.09, 3928.73, 30.10, 85.89),
        },
        blip = { enable = true, sprite = 427, color = 46, scale = 0.9 },
        categories = {
            {
                label = "All",
                vehicles = {
                    { name = "Jet max", brand = "boat", model = "jetmax", price = 2500, image = "nui/images/boats/jetmax.png" },
                    { name = "Sea Shark", brand = "boat", model = "seashark2", price = 599, image = "nui/images/boats/seashark2.png" },
                    { name = "Sun trap", brand = "boat", model = "suntrap", price = 5000, image = "nui/images/boats/suntrap.png" },
                }
            }
        }
    },
}