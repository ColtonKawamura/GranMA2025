clear all
close all
addpath("src/matlab_functions")



%% 3D
data = load('out/processed/3d_80Kby15_V4_1.mat')

%% Regular Attenuation
gamma_value = .2;
plotAttenuation(data, gamma_value);
plotWavespeed(data, gamma_value);
gamma_values = [.1, .2, .5]
plotAttenuationMult(simulation_data, gamma_values, 1.2)

%% Mean Field
filteredData = filterData(data,'gamma', .1 , 'pressure', 0.1, 'omega', .1, 'seed', 1, 'y', [2,5], 'z', [3,6]);
[mean_field_amp, mean_field_phase, prime_field_amp, prime_field_phase] = plotMeanField(filteredData)

% 3D Energy Theory Plot
gammaValues = [ .3 , .5, .7]
plotPhaseScatter(data, gammaValues)
slopeLine('loglog' ,-5/6, [.05,.5], .1, 'TextPosition', 'bottomLeft')
slopeLine('loglog' ,-5/6, [.05,.5], .012, 'TextPosition', 'bottomLeft')

% 3D Energy Theory Plot
gammaValues = [ .3 , .5, .7]
plotEnergyTheory(data, gammaValues)
slopeLine('loglog' ,-5/6, [.05,.5], .2, 'TextLocation', [.16, .015])
slopeLine('loglog' ,-5/6, [.05,.5], .022, 'TextLocation', [.16, .14])

%% 2D ----------------------------------------------------------------
% # ------------------- 2D  ----------------------------------------
% # ----------------------------------------------------------------
data = load("out/processed/2d_K100_80kby40.mat")
data = load("out/processed/2d_bi_K100_W5.mat")

%% Attenuation and Wavespeed
gamma_value = .2;
plotAttenuation(data, gamma_value);
plotWavespeed(data, gamma_value);

% Master Curve
gamma_value = .00001;
plotAttenuationWithPressure(data, gamma_value);
slopeLine('loglog' ,.5, [1,1E4], 3, 'TextLocation', [10, 3])
slopeLine('loglog' ,.25, [1E2,1E6], 15, 'TextLocation', [2E4, 24])
%% Mean Field
filteredData = filterData(data, 'gamma', .1 , 'pressure', 0.001, 'omega', .1, 'seed', 1);
[mean_field_amp, mean_field_phase, prime_field_amp, prime_field_phase] = plotMeanField(filteredData)

%%  2D Stiched Attenution
gamma_values = [ .5, .7]
plotAttenuationMult(data, gamma_values, 1.2)

%% 2D Stitched Amp Ratio
gammaValues = [ .05, .1, .5, 1]
plotAmpRatio(data, gammaValues)
slopeLine('loglog' ,1, [.02,1.1], .03)
slopeLine('loglog' ,1, [.02,1.1], .0005)

%% 2D Stitched Phase Scatter
gammaValues = [ .05, .1, .5, 1]
plotPhaseScatter(data, gammaValues)


%% 2D Stitched Energy Loss Theory
gammaValues = [ .3 , .5, .7]
plotEnergyTheory(data, gammaValues)
slopeLine('loglog' ,-2/3, [.02,1], 1.4E-1, 'TextLocation', [.14,.8E-1])
slopeLine('loglog' ,-2/3, [.02,1], 5E-3, 'TextLocation', [.14,2.5E-3])


% Sandbox
%% Shear Data
data = load("out/processed/2d_shear_80kby40.mat")