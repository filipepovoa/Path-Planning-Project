clc; clear all; close all;

% load('data_set') % Pioneer 3DX
% load('data_set_1') % Wheelchair -> Center of mass in 7.119 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_2') % Wheelchair -> Center of mass in 7.139 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_3') % Wheelchair -> Center of mass in 7.159 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_4') % Wheelchair -> Center of mass in 7.179 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_5') % Wheelchair -> Center of mass in 7.199 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_6') % Wheelchair -> Center of mass in 7.219 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_7') % Wheelchair -> Center of mass in 7.239 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_8') % Wheelchair -> Center of mass in 7.259 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_9') % Wheelchair -> Center of mass in 7.279 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_10') % Wheelchair -> Center of mass in 7.299 m -> Trail = 6 cm -> Caster radius = 7.5145 cm
load('data_set_11') % Wheelchair -> Center of mass in 7.299 m (2) -> Trail = 6 cm -> Caster radius = 7.5145 cm
% load('data_set_12') % Círculo
% load('data_set_13') % Círculo
% load('data_set_14') % Quadrado
% load('data_set_15') % Wheelchair -> Center of mass in 7.119 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_16') % Wheelchair -> Center of mass in 7.139 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_17') % Wheelchair -> Center of mass in 7.159 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_18') % Wheelchair -> Center of mass in 7.179 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_19') % Wheelchair -> Center of mass in 7.199 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_20') % Wheelchair -> Center of mass in 7.219 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_21') % Wheelchair -> Center of mass in 7.239 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_22') % Wheelchair -> Center of mass in 7.259 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_23') % Wheelchair -> Center of mass in 7.279 m -> Trail = 4 cm -> Caster radius = 7.5145 cm
% load('data_set_24') % Wheelchair -> Center of mass in 7.119 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_25') % Wheelchair -> Center of mass in 7.139 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_26') % Wheelchair -> Center of mass in 7.159 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_27') % Wheelchair -> Center of mass in 7.179 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_28') % Wheelchair -> Center of mass in 7.199 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_29') % Wheelchair -> Center of mass in 7.219 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_30') % Wheelchair -> Center of mass in 7.239 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_31') % Wheelchair -> Center of mass in 7.259 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_32') % Wheelchair -> Center of mass in 7.279 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_33') % Wheelchair -> Center of mass in 7.299 m -> Trail = 6 cm -> Caster radius = 6 cm
% load('data_set_34') % Wheelchair -> Center of mass in 7.105 m -> Trail = 6 cm -> Caster radius = 7.5145 cm

pose.x = pose_wheelchair.x;
pose.y = pose_wheelchair.y;
% pose.x = pose_p3dx.x;
% pose.y = pose_p3dx.y;
target.x = target_points.x;
target.y = target_points.y;

plot(target.x,target.y)
axis equal
grid on
hold on
plot(pose.x,pose.y,'--','LineWidth',2)
title('Gráfico da trajetória realizada pela cadeira de rodas e a trajetória desejada')
% title('Gráfico da trajetória realizada pelo p3dx e a trajetória desejada')
xlabel('Coordenada x (m)')
ylabel('Coordenada y (m)')
legend('Trajetória desejada','Trajetória realizada pela cadeira de rodas')
% legend('Trajetória desejada','Trajetória realizada pelo p3dx')
set(gca,'FontSize',20)
set(gca, 'FontName', 'Times New Roman')
set(gcf,'Position',[400 75 1100 900])

soma = 0;
for i=1:length(target.x)-1
    i
    a = target.y(i+1)-target.y(i);
    b = target.x(i) - target.x(i+1);
    c = target.y(i)*target.x(i+1)-target.y(i+1)*target.x(i);
    for j=1:length(pose.x)
        if pose.x(j) >= target.x(i) && pose.x(j) <= target.x(i+1)
            % Distância do ponto à reta
            error = abs(a*pose.x(j)+b*pose.y(j)+c)/sqrt(a^2+b^2);
            soma = soma + error^2;
        else
            if pose.x(j) <= target.x(1)
                % Distância de um ponto ao outro
                error = sqrt((pose.x(j)-target.x(1))^2+(pose.y(j)-target.y(1))^2);
                soma = soma + error^2;
            elseif pose.x(j) >= target.x(length(target.x))
                % Distância de um ponto ao outro
                error = sqrt((pose.x(j)-target.x(length(target.x)))^2+(pose.y(j)-target.y(length(target.y)))^2);
                soma = soma + error^2;
            end
        end
    end
end

EQM = soma/length(pose.x);
REQM = sqrt(soma/length(pose.x));