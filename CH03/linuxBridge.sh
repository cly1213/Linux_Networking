#!/bin/bash

sudo ip netns add ns1
sudo ip netns add ns2

sudo ip link add veth1 type veth peer name veth2
sudo ip link add veth3 type veth peer name veth4

sudo ip link set veth2 netns ns1 name eth0
sudo ip link set veth4 netns ns2 name eth0

sudo ip link add br0 type bridge

sudo ip link set veth1 master br0
sudo ip link set veth3 master br0

sudo ip link set up dev veth1
sudo ip link set up dev veth3
sudo ip link set up dev br0


