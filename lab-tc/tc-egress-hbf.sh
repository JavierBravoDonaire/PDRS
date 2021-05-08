#!/bin/sh

## Borro si habia alguna definida antes

tc qdisc del dev eth1 root

## Funcionamiento

tc qdisc add dev eth1 root handle 1:0 htb

tc class add dev eth1 parent 1:0 classid 1:1 htb rate 1.2mbit

tc class add dev eth1 parent 1:1 classid 1:2 htb rate 1.2mbit ceil 1.2mbit
tc class add dev eth1 parent 1:1 classid 1:3 htb rate 1.2mbit ceil 1.2mbit

tc filter add dev eth1 parent 1:0 protocol ip prio 1 u32 \
	match ip src 11.48.0.10 \
	flowid 1:2

tc filter add dev eth1 parent 1:0 protocol ip prio 1 u32 \
	match ip src 11.48.0.20 \
	flowid 1:3
