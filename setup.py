from setuptools import setup, find_packages

setup(
    name='burisim',
    version='0.1.0',
    description='Simulator for buri machine',
    author='Rich Wareham',
    author_email='rich.buri@richwareham.com',
    packages=find_packages(exclude=['tests']),
    install_requires=[
        'docopt',
        'future',
        'py65',
        'pyserial',
        'Pillow',
    ],
    entry_points={
        'console_scripts': [
            'burisim = burisim:main',
            'buritk = burisim.gui:main',
        ],
    },
)
