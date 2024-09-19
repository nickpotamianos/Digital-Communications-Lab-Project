% Διαβάζω την εικόνα 
I = imread('parrot.png');

% Υπολογίζω τις συχνότητες εμφάνισης κάθε τιμής pixel
[symbols, ~, idx] = unique(I);
counts = accumarray(idx(:), 1);
probabilities = counts / numel(I);

% Μετατροπή της εικόνας σε 1D πίνακα
pixels = I(:);

% Υπολογισμός της εντροπίας
H = -sum(probabilities .* log2(probabilities));

% Δημιουργία του Huffman δέντρου
dict = huffmandict(symbols, probabilities);

% Κωδικοποίηση της εικόνας με Huffman
encoded_img = huffmanenco(pixels, dict);

% Υπολογισμός του συνολικού μήκους του κωδικοποιημένου σήματος
encoded_length = length(encoded_img);

% Το μέγεθος της αρχικής εικόνας σε bits (κάθε pixel είναι 8 bits)
original_bits = numel(I) * 8;

% Λόγος συμπίεσης
J = encoded_length / original_bits;

% Εμφάνιση του λόγου συμπίεσης
fprintf('Λόγος συμπίεσης (J): %.4f\n', J);

% Προσομοίωση Δυαδικού Συμμετρικού Καναλιού και υπολογισμός της πιθανότητας p
y = binary_symmetric_channel(encoded_img);
p = sum(encoded_img == y) / length(encoded_img);

% Υπολογισμός χωρητικότητας καναλιού και αμοιβαίας πληροφορίας
H_p = -p*log2(p) - (1-p)*log2(1-p);
C = 1 - H_p;
% Calculate the probabilities
p0 = sum(encoded_img == 0) / length(encoded_img);
p1 = sum(encoded_img == 1) / length(encoded_img);

% Calculate the entropy
H_X = -p0 * log2(p0 + (p0 == 0)) - p1 * log2(p1 + (p1 == 0));
amoivaia_pliroforia = H_X - H_p;

% Εμφάνιση των αποτελεσμάτων
fprintf('Χωρητικότητα του καναλιού: %.4f bits\n', C);
fprintf(['Αμοιβαία Πληροφορία: ', num2str(amoivaia_pliroforia)]);
fprintf('\np: %.2f', p);

