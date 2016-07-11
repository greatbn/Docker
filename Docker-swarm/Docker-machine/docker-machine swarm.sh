echo "delete machine exist"
sleep 3
docker-machine rm kv-store
docker-machine rm node-1
docker-machine rm node-2
docker-machine rm node-3

echo "create kvstore machine"
sleep 3

docker-machine create -d virtualbox kv-store

echo "create container kv-store consul"
sleep 3

eval "$(docker-machine env kv-store)"
docker run -d -p 8500:8500 --name consul -h consul progrium/consul -server -bootstrap

echo "Create node-1 machine(master)"
sleep 3

docker-machine create -d virtualbox \
--swarm --swarm-master --swarm-discovery="consul://$(docker-machine ip kv-store):8500/swarm" \
--engine-opt="cluster-store=consul://$(docker-machine ip kv-store):8500" \
--engine-opt="cluster-advertise=eth1:2376" node-1

echo "Create node-2 machine"
sleep 3

docker-machine create -d virtualbox \
--swarm --swarm-discovery="consul://$(docker-machine ip kv-store):8500/swarm" \
--engine-opt="cluster-store=consul://$(docker-machine ip kv-store):8500" \
--engine-opt="cluster-advertise=eth1:2376" node-2

echo "Create node-3 machine"
sleep 3

docker-machine create -d virtualbox \
--swarm --swarm-discovery="consul://$(docker-machine ip kv-store):8500/swarm" \
--engine-opt="cluster-store=consul://$(docker-machine ip kv-store):8500" \
--engine-opt="cluster-advertise=eth1:2376" node-3
