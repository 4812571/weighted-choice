local MAX_SEED = 1_000_000_000

local WeightedChoice = {}
WeightedChoice.__index = WeightedChoice

local seedGenerator = Random.new()

export type WeightedChoice<T> = {
    AddChoice: (self: WeightedChoice<T>, choice: T, weight: number) -> (),
    Choose: (self: WeightedChoice<T>) -> T,
}

function WeightedChoice.new(random: Random)
    local self = setmetatable({}, WeightedChoice)
    self._weights = {}
    self._choices = {}
    self._weightTotal = 0

    self._random = random or Random.new(seedGenerator:NextInteger(0, MAX_SEED))

    return self
end

function WeightedChoice:AddChoice(choice, weight)
    table.insert(self._choices, choice)
    table.insert(self._weights, weight)
    self._weightTotal += weight
end

function WeightedChoice:Choose()
    local pollPoint = self._random:NextNumber() * self._weightTotal
    local weightSum = 0

    for index, weight in self._weights do
        weightSum += weight
        if pollPoint <= weightSum then
            return self._choices[index]
        end
    end

    error("WeightedChoice:Choose() - This should never happen.")
end

return WeightedChoice