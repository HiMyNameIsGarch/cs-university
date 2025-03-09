import numpy as np
import matplotlib.pyplot as plt

# define the function to visualize
def complex_function(z):
    return np.sin(z**2 + z) / (z * (z + 4))

# Create a grid of complex numbers with extended range
x = np.linspace(-10, 10, 800)
y = np.linspace(-10, 10, 800)
X, Y = np.meshgrid(x, y)
Z = X + 1j * Y

# Evaluate the function
F = complex_function(Z)

# Mask singularities (z = 0 and z = -4)
F[np.isclose(Z, 0)] = np.nan
F[np.isclose(Z, -4)] = np.nan

# compute magnitude, phase
magnitude = np.abs(F)
phase = np.angle(F)

# plot the function
plt.figure(figsize=(10, 10))

# plot the phase
plt.imshow(phase, extent=(-10, 10, -10, 10), origin='lower', cmap='hsv', alpha=0.8)
plt.colorbar(label='Phase (radians)')

# plot the magnitude
plt.imshow(np.log1p(magnitude), extent=(-10, 10, -10, 10), origin='lower', cmap='gray', alpha=0.5)
plt.colorbar(label='Log Magnitude')

# title
plt.title("Complex Function Visualization (2025 Colored)")

# some labels
plt.xlabel("Re(z)")
plt.ylabel("Im(z)")

# showing off
plt.show()
