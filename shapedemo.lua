local main = require("engine")
local width,height = term.getSize() 
local win = window.create(term.current(),1,1,width,height)
local oldTerm = term.redirect(win)
local sTime = os.epoch("utc")/1000
local frames = math.huge
local speed = 10
local objects = {
    main.objects.newCube(),
    main.objects.newCube(),
    main.objects.newPyramid(),
    main.objects.newIcosahedron()
}
for k,v in ipairs(objects) do
    objects[k].rot.x = 0.1
    objects[k].rot.y = 0.1
    objects[k].loc.z =   -3
end
local distanceShader = main.createDistanceShader()
local cFG = colors.white
distanceShader = {
    {" ",cFG},
    [4] = {".",cFG},
    [5] = {".",cFG},
    [6] = {":",cFG},
    [7] = {":",cFG},
    [8] = {"-",cFG},
    [9] = {"=",cFG},
    [10] = {"+",cFG},
    [11] = {"*",cFG},
    [12] = {"#",cFG},
    [13] = {"#",cFG},
    [14] = {"%",cFG},
    [15] = {"%",cFG},
    [16] = {"@",cFG},
    [17] = {"@",cFG}
}

local clickMap = {}
local obj

local function render()
    local camPos = vector.new(0,0,0)
    local camRot = vector.new(0,0,0)
    for i=1,frames do
        local perspertive = main.createPerspective(width,height,40)
        local camera = main.createCamera(camPos,camRot)
        local projected = main.transform(objects,perspertive,camera)
        local zBuffer = main.createZBuffer()
        local dat = main.proccesTriangleData(zBuffer,projected,drawArgs)
        clickMap = main.tools.copyTbl(dat)
        local blit = main.convertBufferToDrawable(width,height,dat,distanceShader,false)
        main.drawConverted(term,blit)
        os.queueEvent("yielding")
        os.pullEvent("yielding")
    end
end
local function engine()
    local ok,err = pcall(render)
    term.redirect(oldTerm)
    term.setCursorPos(1,1)
    if not ok then print(err,0) end
    local eTime = os.epoch("utc")/1000
    local tDiff = eTime-sTime
    _G.FPS = frames/tDiff
    print("FPS: ".._G.FPS)
end
local function key()
    local col = main.createColor()
    local sCol = main.createColor({
        [colors.green]=true,
        [colors.lime]=true
    })
    while true do
        local ev,char = os.pullEvent("key")
        for k,v in pairs(objects) do
            objects[k].color = col
        end
        if obj then
            obj.color = sCol
            if char == keys.s then obj.loc.z = obj.loc.z + 0.1 end
            if char == keys.w then obj.loc.z = obj.loc.z - 0.1 end
            if char == keys.a then obj.loc.x = obj.loc.x - 0.1 end
            if char == keys.d then obj.loc.x = obj.loc.x + 0.1 end
            if char == keys.leftShift then obj.loc.y = obj.loc.y - 0.1 end
            if char == keys.space then obj.loc.y = obj.loc.y + 0.1 end
            if char == keys.right then obj.rot.y = obj.rot.y + 1 end
            if char == keys.left then obj.rot.y = obj.rot.y - 1 end
            if char == keys.up then obj.rot.x = obj.rot.x - 1 end
            if char == keys.down then obj.rot.x = obj.rot.x + 1 end
        end
    end
end
local function click()
    while true do
        local ev,k,x,y = os.pullEvent("mouse_click")
        if clickMap[x][y] then obj = clickMap[x][y].objectPointer.main else obj = nil end
        os.queueEvent("key","UPDATE")
    end
end
parallel.waitForAny(engine,key,click)
