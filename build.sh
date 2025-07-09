#!/usr/bin/env bash

line=$(grep version manifold.json)
version=${line:14:-2}

python assets.py
zip -FSqr builds/Manifold-"$version".zip manifold.json LICENSE src assets lovely localization

echo Built Manifold v"$version"