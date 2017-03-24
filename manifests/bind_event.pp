# Define: qpid::bind_event
#
# This define binds the event queue with the correct messages
#
# === Parameters
#
# $queue::                      Name of the event queue
#
# $exchange::                   Name of the exchange the queue is on
#
# $hostname::                   Set to localhost for qpid-config operations
#
# $port::                       Port that qpid is listening on
#
# $ssl_cert::                   SSL cert to use for qpid-config commands
define qpid::bind_event(
  $queue,
  $exchange = 'event',
  $hostname = 'localhost',
  $port = undef,
  $ssl_cert = undef
)
{
  qpid::config_cmd { "bind queue to exchange and filter messages that deal with ${title}":
    command  => "bind ${exchange} ${queue} ${title}",
    onlyif   => "exchanges ${exchange} -r | grep ${title}",
    hostname => $hostname,
    port     => $port,
    ssl_cert => $ssl_cert,
  }
}
