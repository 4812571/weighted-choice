--!strict

export type Choice<T> = {
    Choice: T,
    Weight: number,
}

local function WeightedChoice<T>(choices: {Choice<T>}): (random: Random) -> T
    local weightTotal = 0

    for _, choice in choices do
        weightTotal += choice.Weight
    end

    local function Choose(random: Random)
        local pollPoint = random:NextNumber() * weightTotal
        local weightSum = 0

        for _, choice in choices do
            weightSum += choice.Weight
            if pollPoint <= weightSum then
                return choice.Choice
            end
        end

        error("unreachable!")
    end

    return Choose
end

return WeightedChoice