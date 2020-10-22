echo "Starting modules..."
./run_modules.sh
echo "Waiting for port 443 to open..."
while ! nc -z localhost 443:
do   
sleep 0.1 
done
echo "Sending PDF..."
curl -F file=@/root/crowd-task-manager/testing_resources/pdf/beethoven.pdf -F "mei=@/dev/null;filename=" http://localhost:443/upload
echo "PDF sent succesfully!"

# Modules required for testing setup
echo 'starting task_passthrough'
cd $HOME/crowd-task-manager/task_scheduler
screen -dm -S task_passthrough python3 task_passthrough.py

# Module to view logs of after start-up
screen -r task_scheduler