local WeightedChoice = {}
WeightedChoice.__index = WeightedChoice

function WeightedChoice.new()
    local self = setmetatable({}, WeightedChoice)
    self._weights = {}
    self._choices = {}
    self._weightTotal = 0
    return self
end

function WeightedChoice:AddChoice(choice, weight)
    table.insert(self._choices, choice)
    table.insert(self._weights, weight)
    self._weightTotal += weight
end

function WeightedChoice:Poll()
    local randomChance = math.random() * self._weightTotal
    local weightSum = 0

    for index, weight in self._weights do
        weightSum += weight
        if randomChance <= weightSum then
            return self._choices[index]
        end
    end
end

return WeightedChoice