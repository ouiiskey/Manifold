#!/usr/bin/env bash

line=$(grep version manifold.json)
version=${line:14:-2}

python3 helpers/assets.py
zip -FSqr builds/Manifold-"$version".zip manifest.json icon.png manifold.json README.md src assets lovely localization

echo Built Manifold v"$version"