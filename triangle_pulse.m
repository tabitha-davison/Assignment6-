

%triangle pulse function
%INPUTS:
%t: current time
%w: width of pulse (starts at t=0, ends at t=h)
%h: height of pulse
%OUTPUTS:
%res: pulse evaluated at t
function res = triangle_pulse(t,w,h)
t = t*(2/w);
res = 1-min(1*abs(t-1),1);
res = h*res;
end

% %short blurb showing how to find x-coord of tracking line
% %x = x-coord of tracking line, t = current time
% %c = wave speed, w = pulse width (in time), L = string length
% x = string_length-c*t+.5*w*c;
% x = mod(x,2*L);
% if x > L
% x = 2*L - x;
% end


% 
% %triangle pulse function (derivative)
% %INPUTS:
% %t: current time
% %w: width of pulse (starts at t=0, ends at t=h)
% %h: height of pulse
% %OUTPUTS:
% %res: derivative of pulse evaluated at t
% function res = triangle_pulse_derivative(t,w,h)
% t = t*(2/w);
% res = -sign(t-1).*(abs(t-1)<1);
% res = (2*h/w)*res;
% end
% 
% %b-spline pulse function
% %INPUTS:
% %t: current time
% %w: width of pulse (starts at t=0, ends at t=h)
% %h: height of pulse
% %OUTPUTS:
% %res: pulse evaluated at t
% function res = b_spline_pulse(t,w,h)
% t = 4*t/w;
% b3 = (0<=t).*(t<1).*(t.^3)/4;
% t = t-1;
% b2 = (0<=t).*(t<1).*(-3*t.^3+3*t.^2+3*t+1)/4;
% t = t-1;
% b1 = (0<=t).*(t<1).*(3*t.^3-6*t.^2+4)/4;
% t = t-1;
% b0 = (0<=t).*(t<1).*(-t.^3+3*t.^2-3*t+1)/4;
% res = h*(b0+b1+b2+b3);
% end
% 
% %b-spline pulse function (derivative)
% %INPUTS:
% %t: current time
% %w: width of pulse (starts at t=0, ends at t=h)
% %h: height of pulse
% %OUTPUTS:
% %res: derivative of pulse evaluated at t
% function res = b_spline_pulse_derivative(t,w,h)
% t = 4*t/w;
% b3 = (0<=t).*(t<1).*(3*t.^2)/4;
% t = t-1;
% b2 = (0<=t).*(t<1).*(-9*t.^2+6*t+3)/4;
% t = t-1;
% b1 = (0<=t).*(t<1).*(9*t.^2-12*t)/4;
% t = t-1;
% b0 = (0<=t).*(t<1).*(-3*t.^2+6*t-3)/4;
% res = (4*h/w)*(b0+b1+b2+b3);
% end
