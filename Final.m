load('imgconpts5.mat'); % Load the saved data

% Choose a black and white image frame to visualize (modify this based on your needs)
frameIndex = 1;

% Extract grayscale image and plume head points for the selected frame
grayimg = imgmat(:, :, frameIndex);
xp_all = cell2mat(cellfun(@(x) x(:, 1), plumepts, 'UniformOutput', false));
yp_all = cell2mat(cellfun(@(x) x(:, 2), plumepts, 'UniformOutput', false));

% Set the desired point size
pointSize = 12;

% Line thickness
lineThickness = 1.5; % Adjust as needed

% Create a figure
figure;

% Display the background grayscale image
imagesc(grayimg);
colormap(gray);
axis equal;
hold on;

% Plot plume head points and connect them with lines using a rainbow color scheme
for i = 1:NfilesToProcess
    xp = plumepts{i}(:, 1);
    yp = plumepts{i}(:, 2);
    
    % Plot points with the specified size
    scatter(xp, yp, pointSize, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
    
    % Connect consecutive points with lines
    if numel(xp) > 1
        % Convert i/NfilesToProcess to a hue value in the range [0, 1]
        hue = i/NfilesToProcess;
        
        % Convert HSV to RGB
        rgbColor = hsv2rgb([hue, 1, 1]);
        
        % Plot the line with the rainbow color and thicker lines
        line(xp, yp, 'Color', rgbColor, 'LineWidth', lineThickness);
    end
end

title('Time Series of Plume Head Points');
xlabel('X Coordinate');
ylabel('Y Coordinate');

% Zoom out by 25%
marginPercent = 0.25;
xRange = max(xp_all) - min(xp_all);
yRange = max(yp_all) - min(yp_all);
xlim([min(xp_all) - marginPercent * xRange, max(xp_all) + marginPercent * xRange]);
ylim([min(yp_all) - marginPercent * yRange, max(yp_all) + marginPercent * yRange]);

hold off;
