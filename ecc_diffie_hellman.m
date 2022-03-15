% ecc diffie_hellman
clear all

q = 102070201;	% large prime number
a = 2733342;
b = 3401342;
n = 1043;       	
% Set a high value of n, make sure the number of rows
% in Eq_a_b should be greater that n          

Eq_a_b = generate_elliptic_curve(a,b,q,0,10000000);
G_x = Eq_a_b(n,1);
G_y = Eq_a_b(n,2);

% alice
n_alice = 289;     % alice's private key
p_alice_x = G_x;   % alice's public key to be
p_alice_y = G_y;   % generated

% multiply n_alice times
for i = 2:n_alice
    P = elliptic_curve_add(G_x,G_y,p_alice_x,p_alice_y,a,b,q);
    p_alice_x = P(1);
    p_alice_y = P(2);
end


%bob
n_bob = 109;       % bob's private key
p_bob_x = G_x;     % bob's public key to be
p_bob_y = G_y;     % generated



% multiply n_bob times
for i = 2:n_bob
    P2 = elliptic_curve_add(G_x,G_y,p_bob_x,p_bob_y,a,b,q);
    p_bob_x = P2(1);
    p_bob_y = P2(2);
end 


% key exchange

% alice
% K
k1_x = p_bob_x;
k1_y = p_bob_y;

for i = 2:n_alice
    P3 = elliptic_curve_add(p_bob_x,p_bob_y,k1_x,k1_y,a,b,q);
    k1_x = P3(1);
    k1_y = P3(2);
end

% bob
% K
k2_x = p_alice_x;
k2_y = p_alice_y;

for i = 2:n_bob
    P4 = elliptic_curve_add(p_alice_x,p_alice_y,k2_x,k2_y,a,b,q);
    k2_x = P4(1);
    k2_y = P4(2);
end

fprintf('a=%s, b=%s, q=%s, n=%s, n_alice=%s, n_bob=%s\n', ...
    num2str(a),num2str(b),num2str(q),num2str(n),num2str(n_alice),num2str(n_bob));
fprintf('Shared key of Alice: (%s,%s)\n',num2str(k1_x),num2str(k1_y));
fprintf('Shared key of bob: (%s,%s)\n',num2str(k2_x),num2str(k2_y));