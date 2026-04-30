return function(c, p)
    local k = Instance.new(c)
    for pp, v in pairs(p or {}) do
        k[pp] = v
    end
    return k
end
