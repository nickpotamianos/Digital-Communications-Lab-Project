% Διαβάζω την εικόνα 
img = imread('parrot.png');

% Μετατροπή της εικόνας σε 1D πίνακα
pixels = img(:);

% Δημιουργία ζευγών συνεχόμενων pixels
pairs = [pixels(1:end-1), pixels(2:end)];

% Υπολογισμός των συχνοτήτων εμφάνισης κάθε ζεύγους
[symbols_pairs, ~, idx_pairs] = unique(pairs, 'rows');
counts_pairs = accumarray(idx_pairs, 1);
probabilities_pairs = counts_pairs / (numel(pixels)-1);

% Εμφάνιση των πιθανοτήτων για τα ζεύγη
for i = 1:length(symbols_pairs)
    fprintf('Ζεύγος Pixel: %d %d, Πιθανότητα: %.4f\n', symbols_pairs(i, 1), symbols_pairs(i, 2), probabilities_pairs(i));
end

% Υπολογισμός της εντροπίας για τα ζεύγη τιμών pixel
entropy_pairs = -sum(probabilities_pairs .* log2(probabilities_pairs));

% Εκτύπωση της εντροπίας
fprintf('Εντροπία για τη δεύτερης τάξης επέκταση πηγής: %.4f\n', entropy_pairs);


% Δημιουργία του Huffman δέντρου για τα ζεύγη τιμών pixel
dict_pairs = huffmandict(symbols_pairs, probabilities_pairs);

% Υπολογισμός του μέσου μήκους του κώδικα Huffman για τα ζεύγη
avglen_pairs = 0;
for i = 1:length(dict_pairs)
    symbol_length = length(dict_pairs{i, 2});
    symbol_probability = probabilities_pairs(i);
    avglen_pairs = avglen_pairs + symbol_probability * symbol_length;
end

% Εκτύπωση του μέσου μήκους του κώδικα Huffman
fprintf('Μέσο μήκος κωδικού Huffman για τα ζεύγη: %.4f\n', avglen_pairs);