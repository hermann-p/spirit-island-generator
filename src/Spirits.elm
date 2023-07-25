module Spirits exposing (..)


type Complexity
    = Low
    | Med
    | High
    | VeryHigh


type alias Spirit =
    { name : String
    , complexity : Complexity
    }


spirits : List Spirit
spirits =
    [ { name = "Lightning's Swift Strike", complexity = Low }
    , { name = "River Surges in Sunlight", complexity = Low }
    , { name = "Vital Strength of the Earth", complexity = Low }
    , { name = "Shadows Flicker Like Flame", complexity = Low }
    , { name = "Thunderspeaker", complexity = Med }
    , { name = "A Spread of Rampant Green", complexity = Med }
    , { name = "Ocean's Hungry Grasp", complexity = High }
    , { name = "Bringer of Dreams and Nightmares", complexity = High }
    , { name = "Sharp Fangs Behind the Leaves", complexity = Med }
    , { name = "Keeper of the Forbidden Wilds", complexity = Med }

    -- , { name = "Heart of the Wildfier", complexity = High }
    -- , { name = "Serpent Slumbering Beneath the Island", complexity = High }
    , { name = "Stone's Unyielding Defiance", complexity = Med }
    , { name = "Shifting Memory of Ages", complexity = Med }
    , { name = "Grinning Trickster Stirs Up Trouble", complexity = Med }
    , { name = "Lure of the Deep Wilderness", complexity = Med }
    , { name = "Many Minds Move as One", complexity = Med }
    , { name = "Volcano Looming High", complexity = Med }
    , { name = "Shroud of Silent Mist", complexity = High }
    , { name = "Vengeance as a Burning Plague", complexity = High }
    , { name = "Starlight Seeks Its Form", complexity = VeryHigh }
    , { name = "Fractured Days Split the Sky", complexity = VeryHigh }
    , { name = "Downpour Drenches the World", complexity = High }

    -- , { name = "Finder of Paths Unseen", complexity = VeryHigh }
    -- , { name = "Devouring Teeth Lurk Underfoot", complexity = Low }
    -- , { name = "Eyes Watch From the Trees", complexity = Low }
    -- , { name = "Fathomless Mud of the Swamp", complexity = Low }
    -- , { name = "Rising Head of Stone and Sand", complexity = Low }
    -- , { name = "Sun-Bright Whirlwind", complexity = Low }
    ]
