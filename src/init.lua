--!strict

local function WeightedChoice<T>(choices: {[T]: number}): (random: Random) -> T
    local weightTotal = 0

    for _, weight in choices do
        weightTotal += weight
    end

    local function Choose(random: Random)
        local pollPoint = random:NextNumber() * weightTotal
        local weightSum = 0

        for choice, weight in choices do
            weightSum += weight
            if pollPoint <= weightSum then
                return choice
            end
        end

        error("unreachable!")
    end

    return Choose
end

return WeightedChoice