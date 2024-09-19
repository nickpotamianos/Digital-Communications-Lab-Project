% Φόρτωση δεδομένων από το αρχείο source.mat
load('source.mat'); % Προσαρμόστε το όνομα του αρχείου αν χρειάζεται

% Ορισμός παραμέτρων
N = length(t); % Μήκος της ακολουθίας σήματος
order = 5; % Τάξη του φίλτρου πρόβλεψης
M = 2^3; % Επίπεδα κβάντισης
max_val = 2; % Μέγιστη αποδεκτή τιμή του σφάλματος πρόβλεψης
min_val = -2; % Ελάχιστη αποδεκτή τιμή του σφάλματος πρόβλεψης

% Υπολογισμός των συντελεστών του φίλτρου πρόβλεψης
R = xcorr(t, 'unbiased');
midIndex = floor(length(R)/2) + 1; % Βρίσκουμε το μεσαίο σημείο του πίνακα R
R = R(midIndex:midIndex+order); % Παίρνουμε τα κεντρικά στοιχεία

% Υπόλοιπος κώδικας όπως είναι


% Κβάντιση και κωδικοποίηση
quant_error = zeros(1, N); % Πίνακας για το σφάλμα κβάντισης
predicted = zeros(1, N); % Πίνακας για την προβλεπόμενη τιμή

for i = order+1:N
    % Πρόβλεψη τιμής
    predicted(i) = a' * flipud(t(i-order:i-1));
    % Υπολογισμός σφάλματος και κβάντιση
    error = t(i) - predicted(i);
    quant_error(i) = min(max(error, min_val), max_val);
    quant_error(i) = round((quant_error(i) - min_val) / (max_val - min_val) * (M-1));
end

% Αποκωδικοποίηση και ανακατασκευή του σήματος
reconstructed = zeros(1, N); % Πίνακας για το ανακατασκευασμένο σήμα

for i = order+1:N
    % Αποκωδικοποίηση του σφάλματος πρόβλεψης
    decoded_error = quant_error(i) * (max_val - min_val) / (M-1) + min_val;
    
    % Ανακατασκευή του σήματος στο δέκτη
    reconstructed(i) = decoded_error + a' * flipud(reconstructed(i-order:i-1));
end

% Προαιρετικά: Παρουσίαση του αρχικού και του ανακατασκευασμένου σήματος
figure;
subplot(2,1,1);
plot(t);
title('Original Signal');
subplot(2,1,2);
plot(reconstructed);
title('Reconstructed Signal');