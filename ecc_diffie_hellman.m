% ecc diffie_hellman
clear all

q = 1097879;
a = 2;
b = 3;
n = 30;         

Eq_a_b = generate_elliptic_curve(a,b,q,0,10000);
G_x = Eq_a_b(n,1);
G_y = Eq_a_b(n,2);

% alice
n_device = 12;
p_device_x = G_x;
p_device_y = G_y;

% multiply n_device times
for i = 2:n_device
    P = elliptic_curve_add(G_x,G_y,p_device_x,p_device_y,a,b,q);
    p_device_x = P(1);
    p_device_y = P(2);
end


%bob
n_fcm = 10;
p_fcm_x = G_x;
p_fcm_y = G_y;

% multiply n_device times
for i = 2:n_fcm
    P2 = elliptic_curve_add(G_x,G_y,p_fcm_x,p_fcm_y,a,b,q);
    p_fcm_x = P2(1);
    p_fcm_y = P2(2);
end 


% key exchange

% alice
% K
k1_x = p_fcm_x;
k1_y = p_fcm_y;

for i = 2:n_device
    P3 = elliptic_curve_add(p_fcm_x,p_fcm_y,k1_x,k1_y,a,b,q);
    k1_x = P3(1);
    k1_y = P3(2);
end

% bob
% K

k2_x = p_device_x;
k2_y = p_device_y;

for i = 2:n_fcm
    P4 = elliptic_curve_add(p_device_x,p_device_y,k2_x,k2_y,a,b,q);
    k2_x = P4(1);
    k2_y = P4(2);
end







