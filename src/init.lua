local WeightedChoice = {}
WeightedChoice.__index = WeightedChoice

function WeightedChoice.new(seed)
    local self = setmetatable({}, WeightedChoice)
    self._weights = {}
    self._choices = {}
    self._weightTotal = 0

    -- Roblox's Random.new() throws an exception if 'nil' is passed in.
    -- Passing in nothing, however, is perfectly fine and expected behavior.
    self._random = if seed then Random.new(seed) else Random.new()

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
end

return WeightedChoice