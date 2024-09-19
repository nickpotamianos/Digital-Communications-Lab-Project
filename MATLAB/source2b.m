% Φορτώστε τα δεδομένα πηγής
load('source.mat'); % Υποθέτουμε ότι το source.mat φορτώνει το σήμα στην μεταβλητή t

% Ορισμός των παραμέτρων του κβαντιστή
max_val = 3.5;
min_val = -3.5;
num_bits = 1:3;  % Αριθμός bits για τον κβαντιστή

% Ορισμός των τιμών του p
p_values = [5, 6];

% Διαίρεση του σήματος σε υποσύνολα των 5000 δειγμάτων
num_samples = 5000;
num_subsets = length(t) / num_samples;

% Εκτέλεση DPCM για κάθε υποσύνολο
for subset = 1:num_subsets
    % Επιλογή του τρέχοντος υποσύνολου
    current_subset = t((subset - 1) * num_samples + 1 : subset * num_samples);

    % Εκτέλεση για κάθε συνδυασμό N και p
    for N = num_bits
        for p = p_values
            % Αρχικοποίηση των εξόδων του κωδικοποιητή και του αποκωδικοποιητή
            encoded_signal = zeros(1, num_samples);
            decoded_signal = zeros(1, num_samples);
            prediction_error = zeros(1, num_samples);

            % Αρχικοποίηση του φίλτρου πρόβλεψης
            a = ones(1, p) * (1/p);  % Απλή προσέγγιση για τους συντελεστές

            % DPCM Κωδικοποίηση
            for i = p+1:num_samples
                % Υπολογισμός της πρόβλεψης
                prediction = sum(a .* decoded_signal(i-p:i-1));  
                error_signal = current_subset(i) - prediction;  
                
                % Κβάντιση του σήματος σφάλματος
                quantized_error = round((error_signal - min_val) / (max_val - min_val) * ((2^N) - 1));
                quantized_error = max(0, min(quantized_error, (2^N) - 1));
                encoded_signal(i) = quantized_error;
                
                % Αποκωδικοποίηση του κβαντισμένου σφάλματος
                dequantized_error = (quantized_error / ((2^N) - 1)) * (max_val - min_val) + min_val;
                
                % Ανακατασκευή του σήματος
                decoded_signal(i) = prediction + dequantized_error;
                
                % Αποθήκευση του σφάλματος πρόβλεψης
                prediction_error(i) = error_signal - dequantized_error;
            end
        end
    end
    % Σχεδίαση του αρχικού σήματος και του σφάλματος πρόβλεψης
figure; % Δημιουργία νέου παραθύρου για τα διαγράμματα

% Σχεδίαση του αρχικού σήματος
subplot(2, 1, 1); % Διαίρεση του παραθύρου για δύο γραφήματα (2 γραμμές, 1 στήλη, επιλογή 1ης θέσης)
plot(current_subset); % Σχεδίαση του αρχικού σήματος
title(['Αρχικό Σήμα - Υποσύνολο ', num2str(subset), ', p=', num2str(p), ', N=', num2str(N), ' bits']);
xlabel('Δείγμα');
ylabel('Τιμή');

% Σχεδίαση του σφάλματος πρόβλεψης
subplot(2, 1, 2); % Επιλογή 2ης θέσης για το δεύτερο γράφημα
plot(prediction_error); % Σχεδίαση του σφάλματος πρόβλεψης
title(['Σφάλμα Πρόβλεψης - Υποσύνολο ', num2str(subset), ', p=', num2str(p), ', N=', num2str(N), ' bits']);
xlabel('Δείγμα');
ylabel('Σφάλμα');

end
