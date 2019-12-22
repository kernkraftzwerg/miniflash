#!/usr/bin/env perl
use LWP::Simple;
use Digest::SHA qw(sha256);
my $url=$ARGV[0];
my ($type)=head($url);
die "Didn't find a binary at URL $url" unless $type eq "application/octet-stream";
my $content=get($url);
my $digest=unpack( 'H*', sha256($content));
my $avahi=qx(avahi-browse -t _ewelink._tcp --resolve);
my $devid=$1 if $avahi=~/=\s\S+\sIPv4\s(\S+)/;
my $devip=$1 if $avahi=~/address\s=\s\[(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\]/;
die "Didn't find a matching zeroconf device" unless defined $devid && defined $devip;
print "Device found:\n  ID: $devid\n  IP: $devip\n";
qx(curl http://${devip}:8081/zeroconf/ota_unlock -XPOST --data '{"deviceid":"${devid}","data":{} }');
qx(curl http://${devip}:8081/zeroconf/ota_flash -XPOST --data '{"deviceid":"${devid}","data":{"downloadUrl": "$url", "sha256sum": "$digest"} }');
