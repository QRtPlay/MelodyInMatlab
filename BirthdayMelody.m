% Parameters
fs = 44100;          % Sampling frequency (Hz)
duration = 5;        % Duration of the melody (seconds)

% Define the piano notes (frequency values)
C4 = 261.63;
D4 = 293.66;
E4 = 329.63;
F4 = 349.23;
G4 = 392.00;
A4 = 440.00;
B4 = 493.88;
C5 = 523.25;

% Define the note durations (in seconds)
quarterNote = 0.5;
halfNote = 1;
wholeNote = 2;

% Define the melody (note sequence)
melody = {C4, C4, D4, C4, F4, E4,C4, C4, D4, C4, G4, F4,C4, C4, C5, A4, F4, E4, D4,B4, B4, A4, F4, G4, F4};

% Define the corresponding note durations
noteDurations = {quarterNote, quarterNote, halfNote, quarterNote, quarterNote, wholeNote,quarterNote, quarterNote, halfNote, quarterNote, quarterNote, wholeNote,quarterNote, quarterNote, halfNote, quarterNote, quarterNote, quarterNote, halfNote,quarterNote, quarterNote, halfNote, quarterNote, quarterNote, wholeNote};

% Calculate the total number of notes
numNotes = numel(melody);

% Calculate the total duration of the melody
totalDuration = sum(cell2mat(noteDurations(:)));

% Initialize the melody signal
t = 0:1/fs:totalDuration-1/fs;
melodySignal = zeros(1, length(t));

% Generate the melody signal
currentIndex = 1;
for i = 1:numNotes
    noteFrequency = melody{i};
    noteDuration = noteDurations{i};
    noteSamples = round(noteDuration * fs);
    noteSignal = sin(2 * pi * noteFrequency * (0:noteSamples-1) / fs);
    melodySignal(currentIndex:currentIndex+noteSamples-1) = noteSignal;
    currentIndex = currentIndex + noteSamples;
end

% Perform FFT
N = length(melodySignal);
f = fs * (0:N/2-1) / N;
fftMelody = fft(melodySignal);
fftMelody = abs(fftMelody(1:N/2));

% Plot the spectrum
figure;
plot(f, fftMelody);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Spectrum of Birthday Melody');

% Play the melody
sound(melodySignal, fs);
% Save the melody as .wav format
filename = 'Birthday_melody.wav';
audiowrite(filename,melodySignal, fs);
