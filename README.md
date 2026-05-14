# Disha_mahale_Drone_Altitude_Stabilization
Drone altitude stabilization using PID control in MATLAB with disturbance rejection and performance analysis.
# Drone Altitude Stabilization Using PID Controller

## Project Overview
This project designs and simulates a control system to regulate the altitude of a drone under external disturbance such as wind.

The drone vertical dynamics are modeled using the transfer function:

G(s) = H(s)/U(s) = 1 / (s^2 + 2s + 5)

where:
- U(s) is the thrust command input
- H(s) is the altitude output

## Control Objective
The objective is to design a PID controller such that:
- Overshoot is less than 10%
- Settling time is less than 3 seconds
- Steady-state error is approximately zero
- System remains stable under disturbance

## Assumptions
- The drone altitude dynamics are approximated as a linear time-invariant second-order system.
- Input to the plant is thrust command.
- Output of the plant is altitude.
- Wind disturbance is modeled as an external input disturbance applied at t = 5 seconds.
- Sensor noise, actuator saturation, nonlinear aerodynamics, and battery effects are neglected.

## Dependencies
- MATLAB
- Simulink
- Control System Toolbox
- Simulink Control Design toolbox 

## Approach
1. Define the drone altitude transfer function.
2. Analyze the open-loop step response.
3. Design a PID controller.
4. Simulate the closed-loop response.
5. Add wind disturbance at t = 5 seconds.
6. Evaluate performance using standard control metrics.

## Transfer Function

G(s) = 1 / (s^2 + 2s + 5)

## PID Controller Parameters

Kp = 70  
Ki = 20  
Kd = 11

## Simulink Model
The Simulink model uses negative feedback control.

Desired altitude is compared with actual altitude:

e(t) = h_ref(t) - h(t)

The PID controller generates the thrust command. Wind disturbance is added at the plant input. The drone plant produces altitude output h(t).

## Results

| Metric | Requirement | Result |
|---|---:|---:|
| Overshoot | < 10% | approximately 7% |
| Settling Time | < 3 s | less than 3 s |
| Steady-State Error | approximately 0 | approximately 0 |
| Stability | Stable | Stable |

## Output Images

### Simulink Model
![Simulink Model](results/simulink_model.png)

### Open-Loop Response
![Open Loop Response](results/open_loop_response.png)

### Closed-Loop Response
![Closed Loop Response](results/closed_loop_response.png)

### Disturbance Response
![Disturbance Response](results/disturbance_response.png)

## Working Video
The working simulation video is available here:

[Watch Working Video](video/drone_altitude_working.mp4)

## How to Run
1. Open MATLAB.
2. Navigate to the `src` folder.
3. Run:

```matlab
drone_altitude_pid
