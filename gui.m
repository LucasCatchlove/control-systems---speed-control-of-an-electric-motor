pkg load control % Load the control package

% Define the initial transfer function parameters
K_init = 1.75;
L_init = 0.001882;
R_init = 0.06727;
J_init = 1.25;
b_init = 1.75;

Kp_init = 35;
Ki_init = 0.05;
Kd_init = 0.3;




% Define the transfer function with the initial parameters
 G = tf(K_init, [J_init*L_init, (J_init*R_init + L_init*b_init), (b_init*R_init + K_init^2)])
 C = pid(Kp_init,Ki_init,Kd_init);
 G_feedback = feedback(C*G,1);

% Create a new figure for the plot
figure('position', [50,0,1000, 600]);



% Create the step response plot of the initial transfer function
  subplot(2,2,1);
  step(G);
  xlim([0,5])
  title("Plant step response no PID controller");

  subplot(2,2,2);
  step(G_feedback);
    xlim([0,5])
   title("Plant step response with PID controller");

% Create sliders for each parameter
slider_K = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.1, 0.4, 0.3, 0.06], 'min', 0, 'max', 2, 'value', K_init);
slider_L = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.1, 0.3, 0.3, 0.06], 'min', 0, 'max', 0.01, 'value', L_init);
slider_R = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.1, 0.2, 0.3, 0.06], 'min', 0, 'max', 0.1, 'value', R_init);
slider_J = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.1, 0.1, 0.3, 0.06], 'min', 0, 'max', 2, 'value', J_init);
slider_b = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.5, 0.4, 0.3, 0.06], 'min', 0, 'max', 2, 'value', b_init);

%PID sliders
slider_Kp = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.5, 0.3, 0.3, 0.06], 'min', 0, 'max', 100, 'value', Kp_init);
slider_Ki = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.5, 0.2, 0.3, 0.06], 'min', 0, 'max', 100, 'value', Ki_init);
slider_Kd = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.5, 0.1, 0.3, 0.06], 'min', 0, 'max', 50, 'value', Kd_init);

% Label each slider
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.45, 0.3, 0.06], 'string', strcat("K =", num2str(K_init)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.35, 0.3, 0.06], 'string', strcat("L =", num2str(L_init)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.25, 0.3, 0.06], 'string', strcat("R =", num2str(R_init)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.15, 0.3, 0.06], 'string', strcat("J =", num2str(J_init)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.45, 0.3, 0.06], 'string', strcat("b =", num2str(b_init)));
  %pid slider labels
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.35, 0.3, 0.06], 'string', strcat("Kp =", num2str(Kp_init)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.25, 0.3, 0.06], 'string', strcat("Ki =", num2str(Ki_init)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.15, 0.3, 0.06], 'string', strcat("Kd =", num2str(K_init)));



% Define a callback function to update the transfer function and plot
function update_plot(source, event, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp)

   % Get the current slider values


  % Get the current slider values
  K = get(slider_K,'value');
  L = get(slider_L,'value');
  R = get(slider_R,'value');
  J = get(slider_J,'value');
  b = get(slider_b,'value');

  KP = get(slider_Kp,'value');
  KI = get(slider_Ki,'value');
  KD = get(slider_Kd,'value');

  % Define the new transfer function with the updated parameters
  G_new = tf(K, [J*L, (J*R + L*b), (J*b + R*b), K]);

  % Label each slider
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.45, 0.3, 0.06], 'string', strcat("K =", num2str(K)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.35, 0.3, 0.06], 'string', strcat("L =", num2str(L)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.25, 0.3, 0.06], 'string', strcat("R =", num2str(R)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.1, 0.15, 0.3, 0.06], 'string', strcat("J =", num2str(J)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.45, 0.3, 0.06], 'string', strcat("b =", num2str(b)));

  %PID sliders
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.35, 0.3, 0.06], 'string', strcat("Kp =", num2str(KP)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.25, 0.3, 0.06], 'string', strcat("Ki =", num2str(KI)));
  uicontrol('style', 'text', 'units', 'normalized', 'position', [0.5, 0.15, 0.3, 0.06], 'string', strcat("Kd =", num2str(KD)));


  % Update the plot with the new transfer function
  set(G, 'num', K);
  set(G, 'den', [J*L, (J*R + L*b), (b*R + K^2)]);

   C = pid(KP,KI,KD);
   G_feedback = feedback(C*G,1);
  subplot(2,2,1);
  step(G);
      xlim([0,3])

  subplot(2,2,2);
  step(G_feedback);
      xlim([0,3])
end

% Set the callback function for each slider
set(slider_K, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});
set(slider_R, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});
set(slider_L, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});
set(slider_J, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});
set(slider_b, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});

set(slider_Kp, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});
set(slider_Ki, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});
set(slider_Kd, 'callback', {@update_plot, G, slider_K, slider_L, slider_R, slider_J, slider_b, slider_Kd, slider_Ki, slider_Kp});



