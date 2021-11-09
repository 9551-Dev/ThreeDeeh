local toBlit = {}
local chars = "0123456789abcdef"
for i = 0, 15 do
    toBlit[2^i] = chars:sub(i + 1, i + 1)
end
local function makeProjection(w,h,n,f)
    --w = width
    --h = height
    --n = near plane
    --f = far plane
    return {
        {2*n/w,0,0,0},
        {0,2*n/h, 0,0},
        {0,0,f/(f-n),-n*f/(f-n)},
        {0,0,-1,0}
    }
end
local makeIdentity = function()
    return {
        {1,0,0,0},
        {0,1,0,0},
        {0,0,1,0},
        {0,0,0,1}
    }
end
local makeTranslation = function(cords)
    return {
        {1,0,0,cords.x},
        {0,1,0,cords.y},
        {0,0,1,cords.z},
        {0,0,0,1}
    }
end
local function makeScale(scale)
    return
    {
        {scale.x, 0, 0, 0},
        {0, scale.y, 0, 0},
        {0, 0, scale.z, 0},
        {0, 0, 0, 1} 
    }        
end
local function makeRotation(eulers)
    local x = math.rad(eulers.x)
    local y = math.rad(eulers.y)
    local z = math.rad(eulers.z)
    local sx = math.sin(x)
    local sy = math.sin(y)
    local sz = math.sin(z)
    
    local cx = math.cos(x)
    local cy = math.cos(y)
    local cz = math.cos(z)
    return
    {
        {cy * cz, -cy * sz, sy, 0},
        {(sx * sy * cz) + (cx * sz), (-sx * sy * sz) + (cx * cz), -sx * cy, 0},
        {(-cx * sy * cz) + (sx * sz), (cx * sy * sz) + (sx * cz), cx * cy, 0},
        {0, 0, 0, 1,}
    }
end
local function makePerspective(width, height, n, f, fov)
    local aspectRatio = 3/2*height / width  
    --local aspectRatio = height / width  
    fov = math.rad(fov)
    return
    {
        {aspectRatio/math.tan(fov*0.5),0,0,0},
        {0,1/(math.tan(fov*0.5)),0,0},
        {0,0,-f/(f-n),-f*n/(f-n)},
        {0,0,-1,0}
    },width,height
end
local function matmul(m1, m2)
    local result = {}
    for i = 1, #m1 do
        result[i] = {}
        for j = 1, #m2[1] do
            local sum = 0
            for k = 1, #m2 do sum = sum + (m1[i][k] * m2[k][j]) end
            result[i][j] = sum
        end
    end
    return result
end
local createSelfIndexArray = function()
    return setmetatable({},
        {
            __index=function(t,k)
                local new = {}
                t[k]=new
                return new
            end
        }
    )
end
local function interpolate(p1,p2,y)
    return (((y-p1.y)*(p2.x-p1.x)) / (p2.y-p1.y) + p1.x)
end
local function interpolateY(a,b,y)
    local ya = y - a.y
    local ba = b.y - a.y
    local x = a.x + (ya * (b.x - a.x)) / ba
    local z = a.z + (ya * (b.z - a.z)) / ba
    return x,z
end
local function interpolateZ(a,b,x)
    local z = a.z + (x-a.x) * (((b.z-a.z)/(b.x-a.x)))
    return z
end
local function intY(a,b,y)
    return a.x + ((y - a.y) * (b.x - a.x)) / (b.y - a.y)
end
local function getT(a,b,p)
    local v1 = vector.new( a.x-b.x, a.y-b.y )
    local v2 = vector.new( a.x-p.x, a.y-p.y )
    return (v1:dot(v2)) / (v1:dot(v1))
end
local function lerp(v1,v2,t)
    return (1 - t) * v1 + t * v2
end
local function interpolateOnLine(x1, y1, w1, x2, y2, w2, x3, y3)
    local fxy1=(x2-x3)/(x2-x1)*w1+(x3-x1)/(x2-x1)*w2
    return (y2-y3)/(y2-y1)*fxy1+(y3-y1)/(y2-y1)*fxy1
end
local function switchXYArray(array)
    local output = createSelfIndexArray()
    for x,yout in pairs(array) do
        if type(yout) == "table" then
            for y,val in pairs(yout) do
                output[y][x] = val
            end
        end
    end
    return output
end
local function strInsert(string,add)
    return string..add
end
local indexProximal = function(list,num)
    local diffirences = {}
    local outs = {}
    for k,v in pairs(list) do
        local diff = math.abs(k-num)
        diffirences[#diffirences+1],outs[diff] = diff,k
    end
    local proximal = math.min(table.unpack(diffirences))
    return list[outs[proximal]]
end
local function deepCopyTbl(tbl)
    local token = "ev" .. tostring({})
    os.queueEvent(token, tbl)
    return select(2, os.pullEvent(token))
end
local function copyTbl(tbl)
    local output = {}
    for k,v in pairs(tbl) do output[k] = tbl[k] end
    return setmetatable(output,getmetatable(tbl))
end
local function drawLine(startX, startY, endX, endY, wdata, ZBUFFER, color, object)
	local drawPixelInternal = function(x,y)
        local wUnFloorCur = interpolateOnLine(
            wdata[1].x,wdata[1].y,wdata[1].z,
            wdata[2].x,wdata[2].y,wdata[2].z,
            x,y
        )
        if not ZBUFFER[x][y] then ZBUFFER[x][y] = {w=math.huge} end
        if wUnFloorCur < ZBUFFER[x][y].w or ZBUFFER[x][y].w == math.huge then
            ZBUFFER[x][y] = {
                color=toBlit[color],
                w=wUnFloorCur,
                zet="LINE",
                cSym=nil,
                cCo=nil,
                objectPointer=object
            }
        end
    end
    local startX,startY,endX,endY = math.floor(startX),math.floor(startY),math.floor(endX),math.floor(endY)
    if startX == endX and startY == endY then drawPixelInternal(startX, startY) return end
    local minX = math.min(startX, endX)
    local maxX, minY, maxY
    if minX == startX then minY = startY maxX = endX maxY = endY
    else minY = endY maxX = startX maxY = startY end
    local xDiff,yDiff = maxX - minX,maxY - minY
    if xDiff > math.abs(yDiff) then
        local y,dy = minY,yDiff / xDiff
        for x = minX, maxX do drawPixelInternal(x, math.floor(y+0.5)) y = y + dy end
    else
        local x,dx = minX,xDiff / yDiff
        if maxY >= minY then for y = minY, maxY do drawPixelInternal(math.floor(x ), y) x = x + dx end
        else for y = minY, maxY, -1 do drawPixelInternal(math.floor(x+0.5), y) x = x - dx end end
    end
end
local function drawFlatTriangle(ZBUFFER,px1,px2,y,color,v1,v2,v3,inV1,inV2,inV3,object)
    local xStart = math.ceil(px1-0.5)
    local xEnd =   math.ceil(px2-0.5)
    local sxStart = intY(inV1,inV2,y)
    local sxEnd = intY(inV1,inV3,y)
    local p1 = vector.new(sxStart,y)
    local p2 = vector.new(sxEnd,y)
    local t1 = getT(inV1,inV2,p1)
    local t2 = getT(inV1,inV3,p2)
    local w1 = lerp(inV1.w,inV2.w,t1)
    local w2 = lerp(inV1.w,inV3.w,t2)
    local z1 = lerp(inV1.z,inV2.z,t1)
    local z2 = lerp(inV1.z,inV3.z,t2)
    for x = xStart, xEnd do
        if y > 0 and x > 0 then
            local t3 = (x - sxStart) / (sxEnd - sxStart)
            local wUnFloorCur = lerp(w1,w2,t3)
            local z = lerp(z1,z2,t3)
            if tostring(wUnFloorCur) == "nan" then error("nan'! "..tostring(inV1).." "..tostring(inV3).." "..tostring(sxEnd).." "..tostring(y)) end
            if not ZBUFFER[x][y] then ZBUFFER[x][y] = {w=math.huge} end
            if wUnFloorCur < ZBUFFER[x][y].w then
                ZBUFFER[x][y] = {
                    color=toBlit[color],
                    w=wUnFloorCur,
                    zet=z,
                    --cSym=tostring(math.abs(math.floor(wUnFloorCur%10))),
                    cSym=nil,
                    cCol = nil,
                    objectPointer=object
                }
            end
        end
    end
end
local function drawFlatTopTriangle(ZBUFFER,vec1,vec2,vec3,color,insVec1,insVec2,insVec3,object)
    local m1 = (vec3.x - vec1.x) / (vec3.y - vec1.y)
    local m2 = (vec3.x - vec2.x) / (vec3.y - vec2.y)
    local yStart = math.ceil(vec1.y - 0.5)
    local yEnd =   math.ceil(vec3.y - 0.5)-1
    for y = yStart, yEnd do
        local px1 = m1 * (y + 0.5 - vec1.y) + vec1.x
        local px2 = m2 * (y + 0.5 - vec2.y) + vec2.x
        drawFlatTriangle(ZBUFFER,px1,px2,y,color,vec1,vec2,vec3,insVec1,insVec2,insVec3,object)
    end
end
local function drawFlatBottomTriangle(ZBUFFER,vec1,vec2,vec3,color,insVec1,insVec2,insVec3,object)
    local m1 = (vec2.x - vec1.x) / (vec2.y - vec1.y)
    local m2 = (vec3.x - vec1.x) / (vec3.y - vec1.y)
    local yStart = math.ceil(vec1.y-0.5)
    local yEnd =   math.ceil(vec3.y-0.5)-1
    for y = yStart, yEnd do
        local px1 = m1 * (y + 0.5 - vec1.y) + vec1.x
        local px2 = m2 * (y + 0.5 - vec1.y) + vec1.x
        drawFlatTriangle(ZBUFFER,px1,px2,y,color,vec1,vec2,vec3,insVec1,insVec2,insVec3,object)
    end
end
local function proccesSolidTriangle(ZBUFFER,vec1,vec2,vec3,color,object)
    local pv1 = vec1
    local pv2 = vec2
    local pv3 = vec3
    if pv2.y < pv1.y then pv1,pv2 = pv2,pv1 end
    if pv3.y < pv2.y then pv2,pv3 = pv3,pv2 end
    if pv2.y < pv1.y then pv1,pv2 = pv2,pv1 end
    if pv1.y == pv2.y then
        if pv2.x < pv1.x then pv1,pv2 = pv2,pv1 end
        drawFlatTopTriangle(ZBUFFER,pv1,pv2,pv3,color,vec1,vec2,vec3,object)
    elseif pv2.y == pv3.y then
        if pv3.x < pv2.x then pv3,pv2 = pv2,pv3 end
        drawFlatBottomTriangle(ZBUFFER,pv1,pv2,pv3,color,vec1,vec2,vec3,object)
    else
        local alphaSplit = (pv2.y-pv1.y)/(pv3.y-pv1.y)
        local vi ={ 
            x = pv1.x + ((pv3.x - pv1.x) * alphaSplit),      
            y = pv1.y + ((pv3.y - pv1.y) * alphaSplit), }
        if pv2.x < vi.x then
            drawFlatBottomTriangle(ZBUFFER,pv1,pv2,vi,color,vec1,vec2,vec3,object)
            drawFlatTopTriangle(ZBUFFER,pv2,vi,pv3,color,vec1,vec2,vec3,object)
        else 
            drawFlatBottomTriangle(ZBUFFER,pv1,vi,pv2,color,vec1,vec2,vec3,object)
            drawFlatTopTriangle(ZBUFFER,vi,pv2,pv3,color,vec1,vec2,vec3,object)
        end
    end
end
--[[local function proccesSolidTriangle(ZBUFFER,b,a,c,tColor)
    if a.y < b.y then a,b = b,a end
    if a.y < c.y then a,c = c,a end
    if b.x > c.x then b,c = c,b end
    for y = b.y, a.y-1 do
        local xStart = intY(a,b,y)
        local xEnd = intY(a,c,y)
        local p1 = vector.new(xStart,y)
        local p2 = vector.new(xEnd,y)
        local t1 = getT(a,b,p1)
        local t2 = getT(a,c,p2)
        local z1 = lerp(a.z,b.z,t1)
        local z2 = lerp(a.z,c.z,t2)
        for x = xStart, xEnd do
            local t3 = (x - xStart) / (xEnd - xStart)
            local z = math.floor(lerp(z1,z2,t3))    
            if not ZBUFFER[x][y] then ZBUFFER[x][y] = {w=math.huge} end
            if z > ZBUFFER[x][y].w or ZBUFFER[x][y].w == math.huge then
                ZBUFFER[x][y] = {
                    w=z,
                    color=tColor
                }
            end
        end
    end
end]]
local function createColor(whitelist,blacklist)
    local cols,clist,cCount = {},{},0
    local acls = whitelist or {}
    local skipWhite = (not whitelist)
    local skipBlack = (not blacklist)
    local useall = (not whitelist and not blacklist)
    local bcls = blacklist or {}
    local clist = {}
    for k,v in pairs(colors) do
        if type(v) == "number" then
            if useall then
                table.insert(clist,v)
            else
                if skipBlack and whitelist then
                    if acls[v] then table.insert(clist,v) end
                else
                    if acls[v] and not bcls[v] then table.insert(clist,v) end
                end
                if skipWhite and blacklist then
                    if not bcls[v] then table.insert(clist,v) end
                else
                    if acls[v] and not bcls[v] then table.insert(clist,v) end
                end
            end
        end 
    end
    return setmetatable({},{
        __index=function(t,k)
            cCount = cCount + 1
            local col = clist[cCount]
            if cCount >= #clist then cCount = 0 end
            t[k]=col
            return col
        end
    })
end
local function createZBuffer()
    local buffer = createSelfIndexArray()
    buffer.stamp = "zbuffer"
    return buffer
end
local function createDistanceShader()
    local shader = createSelfIndexArray()
    shader[0] = {" "}
    return shader
end
local function addSymShader(shader,w,symbol,bg,tc)
    shader[w] = {symbol or " ",bg,tc}
end
--[[local function createColor(clist)
    local clist = clist or {}
    local cCount = 0
    return setmetatable({},{
        __index=function(t,k)
            cCount = cCount + 1
            local col = clist[cCount]
            if cCount >= #clist then cCount = 0 end
            t[k]=col
            return col
        end
    })
end]]
local function createPerspective(width,height,FOV)
    return {makePerspective(width,height,100,10,FOV)}
end
local function createCamera(locVector,rotVector)
    return {
        loc=makeTranslation(-locVector),
        rot=makeRotation(-rotVector)
    }
end
local function getProcessingArgs()
    return {
        doCulling = true,
        drawWireFrame = false,
        drawTriangles = true
    }
end
local function clip1(v1,v2,v3)
    local alphaA = (-v1.z)/(v2.z-v1.pos.z)
    local alphaB = (-v1.z)/(v2.z-v1.pos.z)
    local v1a = interpolate(v1,v2,alphaA)
    local v1b = interpolate(v1,v3,alphaB)
    return {{v1a,v1,v2},{v1b,v1a,v2}}
end
local function clip2(v1,v2,v3)
    local alpha1 = (-v1.z)/(v3.z-v1.z)
    local alpha2 = (-v2.z)/(v3.z-v2.z)
    local v1 = interpolate(v1,v3,alpha1)
    local v2 = interpolate(v2,v3,alpha2)
    return {{v1,v2,v3}}
end
local function clipCullTriangle(v1,v2,v3)
    if v1.x > v1.w and v2.x > v2.w and v3.x > v3.w then return false
    elseif v1.x > -v1.w and v2.x > -v2.w and v3.x > -v3.w then return false
    elseif v1.y > v1.w and v2.y > v2.w and v3.y > v3.w then return false
    elseif v1.y > -v1.w and v2.y > -v2.w and v3.y > -v3.w then return false
    elseif v1.z > v1.w and v2.z > v2.w and v3.z > v3.w then return false
    elseif v1.z > -v1.w and v2.z > -v2.w and v3.z > -v3.w then return false end
    return v1,v2,v3
end
local function transform(objList,persperctive,camera)
    local objectsInt = createSelfIndexArray()
    for k,v in pairs(objList) do
        objectsInt[k] = {main=v,vectors={},origins={},connections=v.connections}
        local scale = makeScale(v.scale/(v.divider or 1))
        local rot = makeRotation(v.rot)
        local loc = makeTranslation(v.loc)
        local tempObj = {}
        for k1,v1 in ipairs(v.vertices) do
            local scaledVertice = matmul(scale, v1)
            local rotatedVertice = matmul(rot, scaledVertice)
            local model = matmul(loc, rotatedVertice)
            local cam = matmul(camera.rot, matmul(camera.loc, model))
            local projected = matmul(persperctive[1],cam)
            tempObj[#tempObj+1] = projected
        end
        for kc,vc in ipairs(v.connections) do
            local v1 = vector.new(tempObj[vc[1]][1][1],tempObj[vc[1]][2][1],tempObj[vc[1]][3][1])
            local v2 = vector.new(tempObj[vc[2]][1][1],tempObj[vc[2]][2][1],tempObj[vc[2]][3][1])
            local v3 = vector.new(tempObj[vc[3]][1][1],tempObj[vc[3]][2][1],tempObj[vc[3]][3][1])
            v1.w,v2.w,v3.w = tempObj[vc[1]][4][1],tempObj[vc[2]][4][1],tempObj[vc[3]][4][1]
            --[[if clipCullTriangle(v1,v2,v3) then
                if v1.z < 0 then
                    if v2.z < 0 then something[something] = clip2(v1,v2,v3)
                    elseif v3.z < 0 then something[something] = clip2(v1,v3,v2)
                    else something[something] = clip1(v1,v2,v3) end
                elseif v2.z < 0 then
                    if v3.z < 0 then something[something] = clip2(v2,v3,v1)
                    else something[something] = clip1(v2,v1,v3) end
                elseif v3.z < 0 then
                    something[something] = clip2(v3,v1,v2)
                end
            end--]]
        end
        for k2,v2 in ipairs(tempObj) do
            local projected = v2
            local w = 1/projected[4][1]
            projected[1][1] = (projected[1][1] * w  +1) * (persperctive[2] / 2)
            projected[2][1] = (-projected[2][1] * w +1) * (persperctive[3] / 2)
            table.insert(objectsInt[k].vectors,projected)
            table.insert(objectsInt[k].origins,v2)
        end
    end
    return objectsInt
end
local function proccesTriangleData(ZBUFFER,objects,arguments)
    local term = termObj or term
    if not arguments then
        arguments = {
            doCulling = true,
            drawWireFrame = false,
            drawTriangles = true
        }
    end
    for k,vm in pairs(objects) do
        for k,v in pairs(vm.connections) do
			local v1 = vector.new(vm.origins[v[1]][1][1],vm.origins[v[1]][2][1],vm.origins[v[1]][3][1])
			local v2 = vector.new(vm.origins[v[2]][1][1],vm.origins[v[2]][2][1],vm.origins[v[2]][3][1])
			local v3 = vector.new(vm.origins[v[3]][1][1],vm.origins[v[3]][2][1],vm.origins[v[3]][3][1])
            v1.w,v2.w,v3.w = vm.origins[v[1]][4][1],vm.origins[v[2]][4][1],vm.origins[v[3]][4][1]
            if ((v2:cross(v3)):dot(v1) >= 0) or not arguments.doCulling then
                if arguments.drawTriangles then
                    proccesSolidTriangle(ZBUFFER,v1,v2,v3,vm.main.color[k],vm)
                end
                if arguments.drawWireFrame then
                    local wVecs1 = {
                        vector.new(vm.vectors[v[1]][1][1],vm.vectors[v[1]][2][1],vm.vectors[v[1]][4][1]),
                        vector.new(vm.vectors[v[2]][1][1],vm.vectors[v[2]][2][1],vm.vectors[v[2]][4][1])
                    }
                    local wVecs2 = {
                        vector.new(vm.vectors[v[2]][1][1],vm.vectors[v[2]][2][1],vm.vectors[v[2]][4][1]),
                        vector.new(vm.vectors[v[3]][1][1],vm.vectors[v[3]][2][1],vm.vectors[v[3]][4][1])
                    }
                    local wVecs3 = {
                        vector.new(vm.vectors[v[3]][1][1],vm.vectors[v[3]][2][1],vm.vectors[v[3]][4][1]),
                        vector.new(vm.vectors[v[1]][1][1],vm.vectors[v[1]][2][1],vm.vectors[v[1]][4][1])
                    }
                    drawLine(vm.vectors[v[1]][1][1],vm.vectors[v[1]][2][1],vm.vectors[v[2]][1][1],vm.vectors[v[2]][2][1],wVecs1,ZBUFFER,vm.main.color[k],vm)
                    drawLine(vm.vectors[v[2]][1][1],vm.vectors[v[2]][2][1],vm.vectors[v[3]][1][1],vm.vectors[v[3]][2][1],wVecs2,ZBUFFER,vm.main.color[k],vm)
                    drawLine(vm.vectors[v[3]][1][1],vm.vectors[v[3]][2][1],vm.vectors[v[1]][1][1],vm.vectors[v[1]][2][1],wVecs3,ZBUFFER,vm.main.color[k],vm)
                end
            end
        end
    end
    return ZBUFFER
end
local convertBufferToDrawable = function(width,height,ZBUFFER,distanceShading,keepBuffer)
    local switched = switchXYArray(ZBUFFER)
    local output = {}
    for i=1,height do
        for ix=1,width do
            if not output[i] then output[i] = {"","",""} end
            if switched[i][ix] then
                local char = " "
                if type(distanceShading) == "table" then
                    local away = switched[i][ix].w
                    char = indexProximal(distanceShading,away)
                end
                output[i] = {
                    strInsert(output[i][1],toBlit[char[3]] or switched[i][ix].color),
                    strInsert(output[i][2],switched[i][ix].cSym or char[1]),
                    strInsert(output[i][3],toBlit[switched[i][ix].cCol] or toBlit[char[2]])
                }
            else
                output[i] = {
                    strInsert(output[i][1],"f"),
                    strInsert(output[i][2]," "),
                    strInsert(output[i][3],"f"),
                }
            end
        end
    end
    output.stamp = ZBUFFER.stamp
    if not keepBuffer then
        ZBUFFER = setmetatable(ZBUFFER,
            {
                __index=function(t,k)
                    local new = {}
                    t[k]=new
                    return new
                end
            }
        )
        for k,v in pairs(ZBUFFER) do
            ZBUFFER[k] = nil
        end
    end
    return output
end
--[[local drawConverted = function(termObject,drawData)
    local obc = termObject.getBackgroundColor()
    if drawData.stamp == "zbuffer" then
        for i=1,#drawData do
            termObject.setCursorPos(1,i)
            termObject.blit(drawData[i][2],drawData[i][3],drawData[i][1])
        end
        termObject.setBackgroundColor(obc)
        return true
    end
    return false
end]]
local drawConverted = function(termObject,drawData)
    local obc = termObject.getBackgroundColor()
    if drawData.stamp == "zbuffer" then
        local gfxdata = {}
        for i=1,#drawData do
            if type(term.getGraphicsMode) == "function" and term.getGraphicsMode() == 1 then
                gfxdata[i] = drawData[i][1]:gsub("%x", function(c) return string.char(tonumber(c, 16)) end)
            else
                termObject.setCursorPos(1,i)
                termObject.blit(drawData[i][2],drawData[i][3],drawData[i][1])
            end
        end
        if type(term.getGraphicsMode) == "function" and term.getGraphicsMode() == 1 then
            term.drawPixels(0, 0, gfxdata)
        end
        termObject.setBackgroundColor(obc)
        return true
    end
    return false
end
local function newSquare()
    local objData = { 
        scale = vector.new(1,1,1),
        loc = vector.new(0,0,0),
        rot = vector.new(0,0,0),
        color = createColor(),
        indexList = {1},
        vertices = {
            {{-0.5}, {-0.5}, {0}, {1}},
            {{0.5}, {-0.5}, {0}, {1}}, 
            {{-0.5},  {0.5}, {0}, {1}}, 
            {{0.5},  {0.5}, {0}, {1}},
        },
        connections = {
            {3,2,1},
            {2,4,3},
            {1,2,3},
            {3,4,2},
        }
    }
    return objData
end
local function newCube()
    local objData = { 
        scale = vector.new(1,1,1),
        loc = vector.new(0,0,0),
        rot = vector.new(0,0,0),
        color = createColor(),
		indexList = {1},
        vertices = {
			{ { -0.5}, { -0.5}, {0.5}, {1} },  
			{ {0.5}, { -0.5}, {0.5}, {1} },
			{ { -0.5}, {0.5}, {0.5}, {1} },
			{ {0.5}, {0.5}, {0.5}, {1} },
			{ { -0.5}, { -0.5}, { -0.5}, {1}},
			{ {0.5}, { -0.5}, { -0.5}, {1}},
			{ { -0.5}, {0.5}, { -0.5}, {1}},
			{ {0.5}, {0.5}, { -0.5}, {1}}
		},
        connections = {
            { 1,3,4 },
            { 1,4,2 },
            { 5,7,3 },
            { 5,3,1 },
            { 6,8,7 },
            { 6,7,5 },
            { 2,4,8 },
            { 2,8,6 },
            { 3,7,8 },
            { 3,8,4 },
            { 5,1,2 },
            { 5,2,6 }
        }
	}
    return objData
end
local function newPyramid()
    local objData = { 
        scale = vector.new(1,1,1),
        loc = vector.new(0,0,0),
        rot = vector.new(0,0,0),
        color = createColor(),
        indexList = {1},
        vertices = {
			{{-0.5}, {-0.5}, {-0.5}, {1}},
			{{0.5}, {-0.5}, {-0.5}, {1}},
			{{-0.5}, {-0.5}, {0.5}, {1}},
			{{0.5}, {-0.5}, {0.5}, {1}},
			{{0}, {0.5}, {0}, {1}}
        },
        connections = {
            {3,2,1},
            {3,4,2},
            {2,5,1},
            {3,5,4},
            {4,5,2},
            {1,5,3}
        }
    }
    return objData
end
local function newIcosahedron()
    local objData = { 
        scale = vector.new(1,1,1),
        loc = vector.new(0,0,0),
        rot = vector.new(0,0,0),
        color = createColor(),
        indexList = {1},
        divider = 30,
        vertices = {
            {{0},{30},{0},{1}},
            {{26},{15},{0},{1}},
            {{8},{15},{25},{1}},
            {{-21},{15},{15},{1}},
            {{-21},{15},{-15},{1}},
            {{8},{15},{-25},{1}},
            {{21},{-15},{15},{1}},
            {{-8},{-15},{25},{1}},
            {{-26},{-15},{0},{1}},
            {{-8},{-15},{-25},{1}},
            {{21},{-15},{-15},{1}},
            {{0},{-30},{-15},{1}}
        },
        connections = {
            {1,2,3},
            {3,4,1},
            {1,4,5},
            {5,6,1},
            {1,6,2},
            {7,3,2},
            {8,3,7},
            {8,4,3},
            {9,4,8},
            {9,5,4},
            {10,5,9},
            {10,6,5},
            {11,6,10},
            {11,2,6},
            {7,2,11},
            {10,11,12},
            {12,9,10},
            {8,9,12},
            {12,7,8},
            {11,7,12}
        }        
    }
    return objData
end
return {
    transform = transform,
    proccesTriangleData = proccesTriangleData,
    objects = {
        newSquare = newSquare,
        newCube = newCube,
        newPyramid = newPyramid,
        newIcosahedron = newIcosahedron,
    },
    events = {},
    tools = {
        copyTbl=copyTbl,
        deepCopyTbl=deepCopyTbl,
    },
    others = {
        math = {
            interpolation = {
                indexProximal=indexProximal,
                interpolate = interpolate,
                intY=intY,
                interpolateZ=interpolateZ,
                interpolateY=interpolateY,
                interpolateOnLine=interpolateOnLine
            }
        },
    },
    createColor = createColor,
    createZBuffer = createZBuffer,
    createPerspective = createPerspective,
    createCamera = createCamera,
    getProcessingArgs = getProcessingArgs,
    convertBufferToDrawable = convertBufferToDrawable,
    drawConverted = drawConverted,
    createDistanceShader = createDistanceShader,
    addSymShader = addSymShader,
}
