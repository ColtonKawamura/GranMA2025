export
    Pos2D,
    Particle,
    file_data,
    raw_data

struct Pos2D{T} <: FieldVector{2,T}
    x::T
    y::T
end

struct Particle{VecType}
    position::VecType
    diameter::Float64
end

mutable struct file_data
    pressure::Float64
    omega::Float64
    gamma::Float64
    asp_rat_counts::Vector{Float64}
    asp_rat_bins::Vector{Float64}
    rot_ang_counts::Vector{Float64}
    rot_ang_bins::Vector{Float64}
    omega_gamma::Float64
    seed::Float64
    pressure_actual::Float64
    attenuation_x::Float64
    attenuation_y::Float64
    wavespeed_x::Float64
    wavenumber_x::Float64
    mean_aspect_ratio::Float64
    mean_rotation_angles::Float64
    fft_limit_x::Float64
    ellipse_stats::Matrix{Float64}
    fft_limit_y::Float64
    wavenumber_y::Float64
    alphaoveromega_x::Float64
    alphaoveromega_y::Float64
    amplitude_vector_x::Vector{Float64}
    amplitude_vector_y::Vector{Float64}
    unwrapped_phase_vector_x::Vector{Float64}
    unwrapped_phase_vector_y::Vector{Float64}
    initial_distance_from_oscillation_output_x_fft::Vector{Float64}
    initial_distance_from_oscillation_output_y_fft::Vector{Float64}
    # yfft_posY::Vector{Float64}
    # yfft_posX::Vector{Float64}
    # yfft_init_posX::Vector{Float64}
    # yfft_init_posY::Vector{Float64}
    # xfft_posY::Vector{Float64}
    # xfft_posX::Vector{Float64}
    # xfft_init_posX::Vector{Float64}
    # xfft_init_posY::Vector{Float64}
    # timeVec::Vector{Float64}
end


mutable struct raw_data
    width::Float64
    pressureActual::Float64
    dt::Float64
    trajectory::Vector{Particle}
    timesteps::Float64
    mass::Float64
    amplitude::Float64
    pressureInput::Float64
    gamma::Float64
    omega::Float64
    seed::Float64
    kappa::Float64
    omega_gamma ::Float64

end