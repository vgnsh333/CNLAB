set bwDL(gsm) 384000
set bwUL(gsm) 64000
set propDL(gsm) .150
set propUL(gsm) .150
set buf(gsm) 20

set ns [new Simulator]
set tf [open l6.tr w]
$ns trace-all $tf

set nodes(c1) [$ns node]
set nodes(ms) [$ns node]
set nodes(bs1) [$ns node]
set nodes(bs2) [$ns node]
set nodes(c2) [$ns node]

proc cell_topo {} {
    global ns nodes
    $ns duplex-link $nodes(c1) $nodes(bs1) 3Mb 10ms DropTail
    $ns duplex-link $nodes(bs1) $nodes(ms) 1 1 RED
    $ns duplex-link $nodes(ms) $nodes(bs2) 1 1 RED
    $ns duplex-link $nodes(bs2) $nodes(c2) 3Mb 50ms DropTail
}

switch umts {
    cdma -
    umts {cell_topo}
}

$ns bandwidth $nodes(bs1) $nodes(ms) $bwDL(gsm) simplex
$ns bandwidth $nodes(ms) $nodes(bs1) $bwUL(gsm) simplex
$ns bandwidth $nodes(bs2) $nodes(ms) $bwDL(gsm) simplex
$ns bandwidth $nodes(ms) $nodes(bs2) $bwUL(gsm) simplex

$ns delay $nodes(bs1) $nodes(ms) $propDL(gsm) simplex
$ns delay $nodes(ms) $nodes(bs1) $propDL(gsm) simplex
$ns delay $nodes(bs2) $nodes(ms) $propDL(gsm) simplex
$ns delay $nodes(ms) $nodes(bs2) $propDL(gsm) simplex

$ns queue-limit $nodes(bs1) $nodes(ms) $buf(gsm)
$ns queue-limit $nodes(ms) $nodes(bs1) $buf(gsm)
$ns queue-limit $nodes(bs2) $nodes(ms) $buf(gsm)
$ns queue-limit $nodes(ms) $nodes(bs2) $buf(gsm)

$ns insert-delayer $nodes(ms) $nodes(bs1) [new Delayer]
$ns insert-delayer $nodes(bs1) $nodes(ms) [new Delayer]
$ns insert-delayer $nodes(ms) $nodes(bs2) [new Delayer]
$ns insert-delayer $nodes(bs2) $nodes(ms) [new Delayer]

set tcp [new Agent/TCP]
$ns attach-agent $nodes(c1) $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $nodes(c2) $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns connect $tcp $sink

proc End {} {
    global ns tf
    $ns flush-trace
    close $tf
    exec awk -f l6.awk l6.tr &
    exec xgraph -bar -x time -y packets cdma.xgr &
    exit 0
}

$ns at 0.1 "$ftp start"
$ns at 10.0 "End"
$ns run




