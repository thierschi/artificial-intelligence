--- Calculates the sum of all multiples of m1 and m2 that are
--- less then or equal to limit
---@param m1 integer
---@param m2 integer
---@param limit integer
---@return integer
local function calculate_sum_of_multiples(m1, m2, limit)
    local sum = 0;

    for i = m1, limit, m1 do sum = sum + i end
    for i = m2, limit, m2 do sum = sum + i end

    return sum;
end

-- I am setting the limit to 999 as we want to sum all multiples off
-- 3 or 5 that are less then 1000 while the function returns the sum
-- of all multiples of 3 and 5 that are less than or equal to the
-- given limit
print(calculate_sum_of_multiples(3, 5, 999));
