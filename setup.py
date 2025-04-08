from setuptools import setup

setup(
    name="github-backup",
    version="1.1.0",
    description="",
    url="https://github.com/jszymanowski/github-backup",
    author="John Szymanowski, lnxd",
    install_requires=["requests"],
    scripts=["github-backup.py"],
    zip_safe=True,
)
