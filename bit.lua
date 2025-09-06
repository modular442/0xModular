---@class bit
---@field GetString fun(bitset: table): string @ Converts a bitset (table of 0s and 1s) to its string representation.
---@field GetBit fun(str: string): table @ Converts a string of '0's and '1's to a bitset (table of 0s and 1s).
---@field Not fun(bitset: table): table @ Performs bitwise NOT operation on a bitset.
---@field And fun(bitset1: table, bitset2: table): table @ Performs bitwise AND operation on two bitsets.
---@field Or fun(bitset1: table, bitset2: table): table @ Performs bitwise OR operation on two bitsets.
---@field Xor fun(bitset1: table, bitset2: table): table @ Performs bitwise XOR operation on two bitsets.
---@field ToString fun(str: string): string @ Converts a binary string (e.g., "01000001") to its ASCII string representation.
---@field ToBytes fun(str: string): string @ Converts an ASCII string to its binary string representation.
---@field LShift fun(bitset: table, n: number): table @ Performs left bitwise shift on a bitset by n positions.
---@field RShift fun(bitset: table, n: number): table @ Performs right bitwise shift on a bitset by n positions.
---@field ROR fun(value: string|number, shiftCount: number): table @ Performs right rotate on a bitset or number by shiftCount positions.
---@field ROL fun(value: string|number, shiftCount: number): table @ Performs left rotate on a bitset or number by shiftCount positions.
---@field ToHEX fun(value: string|number, characters: number): string @ Converts a bitset or number to its hexadecimal string representation, padded to 'characters' length.
---@field NumberToBitset fun(num: number, length?: number): table @ Converts a non-negative integer to a bitset of specified length.
local bit = {}

local assert, type, math_min, math_floor, string_sub, string_byte, string_char, string_gsub, string_rep =
    assert, type, math.min, math.floor, string.sub, string.byte, string.char, string.gsub, string.rep

local function validateBitset(bitset)
    assert(type(bitset) == 'table', 'bitset must be a table')
    for i = 1, #bitset do
        assert(bitset[i] == 0 or bitset[i] == 1, 'elements of bitset must be 0 or 1')
    end
end

---Converts a bitset (table of 0s and 1s) to its string representation.
---@param bitset table @ A table representing the bitset (e.g., {1, 0, 1, 0}).
---@return string @ A string representation of the bitset (e.g., "1010").
function bit.GetString(bitset)
    validateBitset(bitset)
    local str = ''
    for i = 1, #bitset do
        str = str .. (bitset[i] == 1 and '1' or '0')
    end
    return str
end

---Converts a string of '0's and '1's to a bitset (table of 0s and 1s).
---@param str string @ A string of '0's and '1's (e.g., "1010").
---@return table @ A table representing the bitset (e.g., {1, 0, 1, 0}).
function bit.GetBit(str)
    assert(type(str) == 'string', 'input must be a string')
    local bitset = {}
    for i = 1, #str do
        local char = string_sub(str, i, i)
        assert(char == '0' or char == '1', 'string must contain only "0" and "1"')
        bitset[i] = char == '1' and 1 or 0
    end
    return bitset
end

---Performs bitwise NOT operation on a bitset.
---@param bitset table @ A table representing the bitset (e.g., {1, 0, 1, 0}).
---@return table @ A new table representing the result of the NOT operation.
function bit.Not(bitset)
    validateBitset(bitset)
    local result = {}
    for i = 1, #bitset do
        result[i] = 1 - bitset[i]
    end
    return result
end

---Performs bitwise AND operation on two bitsets.
---@param bitset1 table @ The first bitset (e.g., {1, 0, 1, 0}).
---@param bitset2 table @ The second bitset (e.g., {1, 1, 0, 0}).
---@return table @ A new table representing the result of the AND operation.
function bit.And(bitset1, bitset2)
    validateBitset(bitset1)
    validateBitset(bitset2)
    local length = math_min(#bitset1, #bitset2)
    local result = {}
    for i = 1, length do
        result[i] = bitset1[i] * bitset2[i]
    end
    return result
end

---Performs bitwise OR operation on two bitsets.
---@param bitset1 table @ The first bitset (e.g., {1, 0, 1, 0}).
---@param bitset2 table @ The second bitset (e.g., {1, 1, 0, 0}).
---@return table @ A new table representing the result of the OR operation.
function bit.Or(bitset1, bitset2)
    validateBitset(bitset1)
    validateBitset(bitset2)
    local length = math_min(#bitset1, #bitset2)
    local result = {}
    for i = 1, length do
        result[i] = bitset1[i] + bitset2[i] > 0 and 1 or 0
    end
    return result
end

---Performs bitwise XOR operation on two bitsets.
---@param bitset1 table @ The first bitset (e.g., {1, 0, 1, 0}).
---@param bitset2 table @ The second bitset (e.g., {1, 1, 0, 0}).
---@return table @ A new table representing the result of the XOR operation.
function bit.Xor(bitset1, bitset2)
    validateBitset(bitset1)
    validateBitset(bitset2)
    local length = math_min(#bitset1, #bitset2)
    local result = {}
    for i = 1, length do
        result[i] = (bitset1[i] + bitset2[i]) % 2
    end
    return result
end

---Converts a binary string (e.g., "01000001") to its ASCII string representation.
---@param str string @ A binary string (e.g., "01000001").
---@return string @ The ASCII string representation (e.g., "A").
function bit.ToString(str)
    assert(type(str) == 'string', 'input must be a string')
    local result = ''
    for byte in string_gsub(str, '%s+', ''):gmatch('%d%d%d%d%d%d%d%d') do
        result = result .. string_char(tonumber(byte, 2))
    end
    return result
end

---Converts an ASCII string to its binary string representation.
---@param str string @ An ASCII string (e.g., "A").
---@return string @ The binary string representation (e.g., "01000001").
function bit.ToBytes(str)
    assert(type(str) == 'string', 'input must be a string')
    local result = {}
    for i = 1, #str do
        local byte = string_byte(str, i)
        for j = 7, 0, -1 do
            result[#result + 1] = math_floor(byte / 2^j) % 2
        end
    end
    return table.concat(result)
end

---Performs left bitwise shift on a bitset by n positions.
---@param bitset table @ A table representing the bitset (e.g., {1, 0, 1, 0}).
---@param n number @ The number of positions to shift (non-negative integer).
---@return table @ A new table representing the result of the left shift operation.
function bit.LShift(bitset, n)
    validateBitset(bitset)
    assert(type(n) == 'number' and n >= 0, 'n must be a non-negative number')
    local result = {}
    for i = 1, #bitset do
        result[i] = i + n <= #bitset and bitset[i + n] or 0
    end
    return result
end

---Performs right bitwise shift on a bitset by n positions.
---@param bitset table @ A table representing the bitset (e.g., {1, 0, 1, 0}).
---@param n number @ The number of positions to shift (non-negative integer).
---@return table @ A new table representing the result of the right shift operation.
function bit.RShift(bitset, n)
    validateBitset(bitset)
    assert(type(n) == 'number' and n >= 0, 'n must be a non-negative number')
    local result = {}
    for i = 1, #bitset do
        result[i] = i - n >= 1 and bitset[i - n] or 0
    end
    return result
end

---Performs right rotate on a bitset or number by shiftCount positions.
---@param value string|number @ A bitset (table of 0s and 1s) or a non-negative integer.
---@param shiftCount number @ The number of positions to rotate (non-negative integer).
---@return table @ A new table representing the result of the right rotate operation.
function bit.ROR(value, shiftCount)
    ---@diagnostic disable-next-line: param-type-mismatch
    local bitset = type(value) == 'number' and bit.NumberToBitset(value) or bit.GetBit(value)
    shiftCount = shiftCount % #bitset
    if shiftCount == 0 then return bitset end
    local result = {}
    for i = 1, #bitset do
        result[i] = bitset[(i - shiftCount - 1) % #bitset + 1]
    end
    return result
end

---Performs left rotate on a bitset or number by shiftCount positions.
---@param value string|number @ A bitset (table of 0s and 1s) or a non-negative integer.
---@param shiftCount number @ The number of positions to rotate (non-negative integer).
---@return table @ A new table representing the result of the left rotate operation.
function bit.ROL(value, shiftCount)
    ---@diagnostic disable-next-line: param-type-mismatch
    local bitset = type(value) == 'number' and bit.NumberToBitset(value) or bit.GetBit(value)
    shiftCount = shiftCount % #bitset
    if shiftCount == 0 then return bitset end
    local result = {}
    for i = 1, #bitset do
        result[i] = bitset[(i + shiftCount - 1) % #bitset + 1]
    end
    return result
end

---Converts a bitset or number to its hexadecimal string representation, padded to 'characters' length.
---@param value string|number @ A bitset (table of 0s and 1s) or a non-negative integer.
---@param characters number @ The desired length of the hexadecimal string (positive integer).
---@return string @ The hexadecimal string representation (e.g., "0A3F").
function bit.ToHEX(value, characters)
    ---@diagnostic disable-next-line: param-type-mismatch
    local bitset = type(value) == 'number' and bit.NumberToBitset(value) or bit.GetBit(value)

    local rem = #bitset % 4
    local paddedLength = #bitset
    if rem ~= 0 then
        paddedLength = #bitset + (4 - rem)
    end
    local padded = {}
    local pad = paddedLength - #bitset
    for i = 1, pad do
        padded[i] = 0
    end
    for i = 1, #bitset do
        padded[i + pad] = bitset[i]
    end
    bitset = padded

    local hexChars = '0123456789ABCDEF'
    local nibbles = {}
    local idx = 1
    for i = 1, #bitset, 4 do
        local b0, b1, b2, b3 = bitset[i], bitset[i+1], bitset[i+2], bitset[i+3]
        nibbles[idx] = string_sub(hexChars, b0*8 + b1*4 + b2*2 + b3 + 1, b0*8 + b1*4 + b2*2 + b3 + 1)
        idx = idx + 1
    end

    local hex = table.concat(nibbles)
    if #hex < characters then
        hex = string_rep('0', characters - #hex) .. hex
    elseif #hex > characters then
        hex = string_sub(hex, -characters)
    end
    return hex
end

---Converts a non-negative integer to a bitset of specified length.
---@param num number @ A non-negative integer.
---@param length? number @ The desired length of the bitset (positive integer).
---@return table @ A table representing the bitset (e.g., {0, 1, 0, 1}).
function bit.NumberToBitset(num, length)
    assert(type(num) == 'number' and num >= 0, 'num must be a non-negative number')
    length = length or math.max(1, math.floor(math.log(num+1)/math.log(2)) )
    local result = {}
    for i = length, 1, -1 do
        result[i] = num % 2
        num = math_floor(num / 2)
    end
    return result
end

return bit