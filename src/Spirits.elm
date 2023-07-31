module Spirits exposing (..)


type Complexity
    = Low
    | Med
    | High
    | VeryHigh


type GameSet
    = Base
    | JaggedEarth
    | BranchAndPaw
    | Promo1
    | Promo2
    | FeatherAndFlame
    | NatureIncarnate
    | Horizons


type alias Spirit =
    { name : String
    , complexity : Complexity
    , origin : GameSet
    }


spirits : List Spirit
spirits =
    [ { name = "Lightning's Swift Strike", complexity = Low, origin = Base }
    , { name = "River Surges in Sunlight", complexity = Low, origin = Base }
    , { name = "Vital Strength of the Earth", complexity = Low, origin = Base }
    , { name = "Shadows Flicker Like Flame", complexity = Low, origin = Base }
    , { name = "Thunderspeaker", complexity = Med, origin = Base }
    , { name = "A Spread of Rampant Green", complexity = Med, origin = Base }
    , { name = "Ocean's Hungry Grasp", complexity = High, origin = Base }
    , { name = "Bringer of Dreams and Nightmares", complexity = High, origin = Base }
    , { name = "Sharp Fangs Behind the Leaves", complexity = Med, origin = Base }
    , { name = "Keeper of the Forbidden Wilds", complexity = Med, origin = Base }
    , { name = "Heart of the Wildfire", complexity = High, origin = Promo1 }
    , { name = "Serpent Slumbering Beneath the Island", complexity = High, origin = Promo1 }
    , { name = "Stone's Unyielding Defiance", complexity = Med, origin = JaggedEarth }
    , { name = "Shifting Memory of Ages", complexity = Med, origin = JaggedEarth }
    , { name = "Grinning Trickster Stirs Up Trouble", complexity = Med, origin = JaggedEarth }
    , { name = "Lure of the Deep Wilderness", complexity = Med, origin = JaggedEarth }
    , { name = "Many Minds Move as One", complexity = Med, origin = JaggedEarth }
    , { name = "Volcano Looming High", complexity = Med, origin = JaggedEarth }
    , { name = "Shroud of Silent Mist", complexity = High, origin = JaggedEarth }
    , { name = "Vengeance as a Burning Plague", complexity = High, origin = JaggedEarth }
    , { name = "Starlight Seeks Its Form", complexity = VeryHigh, origin = JaggedEarth }
    , { name = "Fractured Days Split the Sky", complexity = VeryHigh, origin = JaggedEarth }
    , { name = "Downpour Drenches the World", complexity = High, origin = Promo2 }
    , { name = "Finder of Paths Unseen", complexity = VeryHigh, origin = Promo2 }

    -- , { name = "Devouring Teeth Lurk Underfoot", complexity = Low, origin = Horizons }
    -- , { name = "Eyes Watch From the Trees", complexity = Low, origin = Horizons }
    -- , { name = "Fathomless Mud of the Swamp", complexity = Low, origin = Horizons }
    -- , { name = "Rising Head of Stone and Sand", complexity = Low , origin = Horizons}
    -- , { name = "Sun-Bright Whirlwind", complexity = Low , origin = Horizons}
    ]
