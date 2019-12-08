set ns [new Simulator]
set tf [open prog2.tr w]
$ns trace-all $tf
set nf [open prog2.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n4 100Mb 100ms DropTail
$ns duplex-link $n1 $n4 20Mb 100ms DropTail
$ns duplex-link $n2 $n4 30Mb 100ms DropTail
$ns duplex-link $n3 $n4 40Mb 100ms DropTail
$ns duplex-link $n4 $n5 1Mb 100ms DropTail

$ns queue-limit $n0 $n4 5
$ns queue-limit $n2 $n4 3
$ns queue-limit $n4 $n5 2

set p1 [new Agent/Ping]
$ns attach-agent $n0 $p1
$p1 set packetSize_ 50000
$p1 set interval_ 0.0001
set p2 [new Agent/Ping]
$ns attach-agent $n1 $p2
set p4 [new Agent/Ping]
$ns attach-agent $n3 $p4
set p5 [new Agent/Ping]
$ns attach-agent $n5 $p5

set p3 [new Agent/Ping]
$ns attach-agent $n2 $p3
$p3 set packetSize_ 30000
$p3 set interval_ 0.00001

Agent/Ping instproc recv {from rtt} {
    $self instvar node_
    puts "Node ID: [$node_ id] recved from $from in $rtt ms"
}
$ns connect $p1 $p5
$ns connect $p3 $p4

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exit 0
}

$ns at 0.1 "$p1 send;$p3 send;"
$ns at 0.2 "$p1 send;$p3 send;"
$ns at 0.3 "$p1 send;$p3 send;"
$ns at 0.4 "$p1 send;$p3 send;"
$ns at 0.5 "$p1 send;$p3 send;"
$ns at 0.6 "$p1 send;$p3 send;"
$ns at 0.7 "$p1 send;$p3 send;"
$ns at 0.8 "$p1 send;$p3 send;"
$ns at 0.9 "$p1 send;$p3 send;"
$ns at 1.0 "$p1 send;$p3 send;"
$ns at 1.1 "$p1 send;$p3 send;"
$ns at 1.2 "$p1 send;$p3 send;"
$ns at 1.3 "$p1 send;$p3 send;"
$ns at 1.4 "$p1 send;$p3 send;"
$ns at 1.5 "$p1 send;$p3 send;"
$ns at 1.6 "$p1 send;$p3 send;"
$ns at 1.7 "$p1 send;$p3 send;"
$ns at 1.8 "$p1 send;$p3 send;"
$ns at 1.9 "$p1 send;$p3 send;"
$ns at 2.0 "$p1 send;$p3 send;"
$ns at 2.1 "$p1 send;$p3 send;"
$ns at 2.2 "$p1 send;$p3 send;"
$ns at 2.3 "$p1 send;$p3 send;"
$ns at 2.4 "$p1 send;$p3 send;"
$ns at 2.5 "$p1 send;$p3 send;"
$ns at 2.6 "$p1 send;$p3 send;"
$ns at 2.7 "$p1 send;$p3 send;"
$ns at 2.8 "$p1 send;$p3 send;"
$ns at 2.9 "$p1 send;$p3 send;"
$ns at 3.0 "finish"
$ns run

