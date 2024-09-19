% Φόρτωση της εικόνας
I = imread('parrot.png');

% Εάν η εικόνα δεν είναι ασπρόμαυρη, μετατρέψτε την σε grayscale
 %I_gray = im2gray(I);

% Εύρεση μοναδικών τιμών των pixels
[unique_pixels, ia, ic] = unique(I(:));

% Καταμέτρηση των εμφανίσεων κάθε μοναδικής τιμής pixel
pixel_counts = accumarray(ic, 1);
total_pixels = numel(I);

% Υπολογισμός των πιθανοτήτων εμφάνισης για κάθε τιμή pixel
probabilities = pixel_counts / total_pixels;

% Δημιουργία πίνακα για να αποθηκεύσουμε τις τιμές και τις πιθανότητες
symbols_with_probabilities = [unique_pixels, probabilities];

% Εμφάνιση των αποτελεσμάτων
disp(symbols_with_probabilities);
