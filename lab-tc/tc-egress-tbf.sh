#!/bin/sh

## Borro si habia alguna definida antes

tc qdisc del dev eth1 root

## Funcionamiento

tc qdisc add dev eth1 root handle 1: tbf rate 1.5mbit \
	burst 10k latency 20s
