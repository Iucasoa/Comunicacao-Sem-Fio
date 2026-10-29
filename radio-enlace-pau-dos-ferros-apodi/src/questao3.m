clc; clear; close all;

c = 3e8;                          % velocidade da luz (m/s)
d = logspace(0, 5, 1000);         % 1 m a 100 km

% Parâmetros por linha: {nome, f (Hz), Pt (W), Gt (dBi), Gr (dBi)}
sistemas = {
    'Visada direta', 10e9,  10,   35, 35;
    'TV',            180e6, 1e3,  10, 15;
    'Satélite UL',   6e9,   1e3,  60, 20;
    'Satélite DL',   4e9,   10,   20, 60
};

figure; hold on; grid on;

for i = 1:size(sistemas,1)
    nome = sistemas{i,1};
    f    = sistemas{i,2};
    Pt   = sistemas{i,3};
    Gt   = sistemas{i,4};
    Gr   = sistemas{i,5};

    Pt_dBm = 10*log10(Pt*1000);
    Lfs    = 20*log10(4*pi*d*f/c);
    Pr     = Pt_dBm + Gt + Gr - Lfs;

    semilogx(d, Pr, 'LineWidth', 1.8, 'DisplayName', nome);

    fprintf('%s: Pr(1 m) = %.2f dBm | Pr(100 km) = %.2f dBm\n', ...
            nome, Pr(1), Pr(end));
end

set(gca, 'XScale', 'log');
xlabel('Distância (m)');
ylabel('Potência recebida (dBm)');
title('Potência recebida em espaço livre vs. distância');
legend('Location', 'southwest');

% Salva o gráfico em ../img/ (ou na pasta atual, se o script for colado no console)
pasta_img = fullfile(fileparts(mfilename('fullpath')), '..', 'img');
if ~exist(pasta_img, 'dir'), pasta_img = pwd; end
saveas(gcf, fullfile(pasta_img, 'Questao3Grafico.jpeg'));
