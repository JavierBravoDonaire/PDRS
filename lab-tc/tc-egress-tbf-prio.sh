#!/bin/sh

## Borro si habia alguna definida antes

tc qdisc del dev eth1 root

## Funcionamiento

tc qdisc add dev eth1 root handle 1: tbf rate 1.5mbit \
	burst 10k latency 20ms
	
tc qdisc add dev eth1 parent 1:0 handle 10:0 prio

tc filter add dev eth1 parent 10:0 prio 1 protocol ip u32 \
	match ip src 11.48.0.10/32 flowid 10:1
	
tc filter add dev eth1 parent 10:0 prio 2 protocol ip u32 \
	match ip src 11.48.0.20/32 flowid 10:2
	
tc filter add dev eth1 parent 10:0 prio 3 protocol ip u32 \
	match ip src 0.0.0.0/32 flowid 10:3
