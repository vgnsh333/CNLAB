set ns [new Simulator]
set nf [open prog1.nam w]
$ns namtrace-all $nf
set tf [open prog1.tr w]
$ns trace-all $tf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 5Mb 1ms DropTail
$ns duplex-link $n1 $n2 10Mb 1000ms DropTail
$ns queue-limit $n0 $n1 250

set udp [new Agent/UDP]
$ns attach-agent $n0 $udp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 5000
$cbr set interval_ 0.005
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $udp $sink

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec awk -f prog1.awk prog1.tr &
    exit 0
}

$ns at 0.1 "$cbr start"
$ns at 0.9 "finish"
$ns run
