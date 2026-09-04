#!/usr/bin/env bash

line=$(grep version manifold.json)
version=${line:14:-2}

python3 assets.py
zip -FSqr builds/Manifold-"$version".zip manifold.json manifold.png README.md screenshots src assets lovely localization

echo Built Manifold v"$version"