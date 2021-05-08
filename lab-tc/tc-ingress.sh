#!/bin/sh

## Borro si habia alguna definida antes

tc qdisc del dev eth0 ingress

## Funcionamiento

tc qdisc add dev eth0 ingress handle ffff:

tc filter add dev eth0 parent ffff: protocol ip u32 \
	match ip src 11.48.0.10/32 \
	police rate 1mbit burst 10k drop flowid :1
	
tc filter add dev eth0 parent ffff:	protocol ip u32 \
	match ip src 11.48.0.20/32 \
	police rate 2mbit burst 10k drop flowid :2
