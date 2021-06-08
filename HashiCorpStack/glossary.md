# Consul

## Agent

An agent is the long running daemon on every member of the Consul cluster. It is started by running consul agent.
The agent is able to run in either client or server mode. Since all nodes must be running an agent, it is simpler 
to refer to the node as being either a client or server, but there are other instances of the agent. All agents 
can run the DNS or HTTP interfaces, and are responsible for running checks and keeping services in sync.

## Client

A client is an agent that forwards all RPCs to a server. The client is relatively stateless. The only background 
activity a client performs is taking part in the LAN gossip pool. This has a minimal resource overhead and 
consumes only a small amount of network bandwidth.

## Server

A server is an agent with an expanded set of responsibilities including participating in the Raft quorum, 
maintaining cluster state, responding to RPC queries, exchanging WAN gossip with other datacenters, and forwarding
queries to leaders or remote datacenters.

## RPC

Remote Procedure Call. This is a request / response mechanism allowing a client to make a request of a server.

# Nomad

## Agent

A Nomad agent is a Nomad process running in server or client mode. Agents are the basic building block 
of a Nomad cluster.

## Dev agent

A Nomad development agent is a special configuration that provides useful defaults for running experiments with Nomad. 
It runs in server and client mode and does not persist its cluster state to disk, which allows your agent to start 
from a repeatable clean state without having to remove disk based state between runs. Nomad dev agents are for 
development and experimental use only. To learn about production Nomad deployments, consult the Enterprise Reference 
Architecture and Deployment Guides collection.

## Server

A Nomad agent running in server mode. Nomad servers are the brains of the cluster. There is a cluster of servers 
per region and they manage all jobs and clients, run evaluations, and create task allocations. The servers replicate
data between each other and perform leader election to ensure high availability. Servers federate across regions 
to make Nomad globally aware. All servers in a region are members of the same gossip domain and consensus group.

## Leader 

The leader is a Nomad server that performs the bulk of the cluster management. It is in charge of applying plans, 
deriving Vault tokens for the workloads, and maintaining the cluster state.

## Follower 

Non-leader Nomad servers. Followers create scheduling plans and submit them to the leader to provide 
more scheduling capacity to the cluster.

## Client 

A Nomad agent running in client mode. Client agents are responsible for registering themselves with the servers, 
watching for any work to be assigned, and executing tasks. Clients create a multiplexed connection to the servers. 
This enables topologies that require NAT punch-through. Once connected, the servers use this connection to 
forward RPC calls to the clients as necessary.