config.title = "hydrogen-oxygen reactor in N2 bath"

config.dimensions = 2

setGasModel("H2-O2-N2-9sp-thermally-perfect-gas-model.lua")
config.reacting = true
config.reactions_file = 'h2-o2-n2-9sp-18r-alphaQSS-default-chemistry.lua'
config.gasdynamic_update_scheme = "euler"
config.chemistry_update = "split"

initial = FlowState:new{p=325.0e3, T=4320.0, massf={H=0.0, H2=0.00036122558148004316, O=0.0, 
                        O2=0.005733865674873309, H2O2=0.0, H2O=0.0, HO2=0.0, OH=0.0,  
                        N2=0.9939049087436466}}

pnts = {}
pnts.a = Vector3:new{x=0.0, y=0.0}
pnts.b = Vector3:new{x=0.0, y=0.01}
pnts.c = Vector3:new{x=0.01, y=0.0}
pnts.d = Vector3:new{x=0.01, y=0.01}

patch0 = CoonsPatch:new{p00=pnts.a, p01=pnts.b, p10=pnts.c, p11=pnts.d}

grid0 = StructuredGrid:new{psurface=patch0, niv=3, njv=3}

blk0 = FluidBlock:new{grid=grid0, initialState=initial}

setHistoryPoint{ib=0, i=0, j=0}

-- Finish off config
config.max_time = 0.025
config.max_step = 1000000
-- A time step of 1.0e-6 is good for the operator-split chemical update.
-- The backward-euler updates for the chemistry need to take finer steps
-- to get comparable accuracy.
config.dt_init = 1.0e-7
config.dt_history = 5.0e-6
config.dt_plot = 0.025
config.fixed_time_step = true