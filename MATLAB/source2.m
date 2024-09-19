% Φορτώστε τα δεδομένα πηγής
load('source.mat');

% Ορισμός των παραμέτρων του κβαντιστή
max_val = 3.5;
min_val = -3.5;
num_bits = 8;

% Επιλέξτε διάφορες τιμές για N και P
N_values = [5, 10]; % Τιμές για N
P = 3; % Αντικαταστήστε αυτό με το επιθυμητό P

for N = N_values
    % Δημιουργία του φίλτρου πρόβλεψης
    R = toeplitz(r(1:N)); % Πίνακας αυτοσυσχέτισης
    a = -R \ r(2:N+1); % Συντελεστές πρόβλεψης

    % Αρχικοποίηση των εξόδων του κωδικοποιητή και του αποκωδικοποιητή
    encoded_signal = zeros(size(t));
    decoded_signal = zeros(size(t));

    % DPCM Κωδικοποίηση
    for i = N+1:length(t)
        prediction = a' * decoded_signal(i-N:i-1); % Πρόβλεψη
        error_signal = t(i) - prediction; % Σφάλμα πρόβλεψης
        quantized_error = round((error_signal - min_val) / (max_val - min_val) * (2^num_bits - 1));
        quantized_error = max(0, min(quantized_error, 2^num_bits - 1));
        encoded_signal(i) = quantized_error;
    end

    % DPCM Αποκωδικοποίηση
    for i = N+1:length(encoded_signal)
        quantized_error = encoded_signal(i) * (max_val - min_val) / (2^num_bits - 1) + min_val;
        prediction = a' * decoded_signal(i-N:i-1); % Πρόβλεψη
        decoded_signal(i) = prediction + quantized_error; % Ανακατασκευή
    end

    % Σχεδίαση του αρχικού και του ανακατασκευασμένου σήματος
    figure;
    subplot(2, 1, 1);
    plot(t);
    title(['Αρχικό Σήμα - N: ' num2str(N)]);
    subplot(2, 1, 2);
    plot(decoded_signal);
    title(['Ανακατασκευασμένο Σήμα - N: ' num2str(N)]);
end
