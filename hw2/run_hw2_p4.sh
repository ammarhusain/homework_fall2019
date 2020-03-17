for learning_rate in .005 .01 .02
do
  for batch_size in 10000 30000 50000
  do
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo LearningRate: ${learning_rate} -- BatchSize: ${batch_size}
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    python cs285/scripts/run_hw2_policy_gradient.py --env_name InvertedPendulum-v2 --ep_len 1000 --discount 0.9 -n 100 -l 2 -s 64 -b ${batch_size} -lr ${learning_rate} -rtg --exp_name p4_ip_b${batch_size}_r${learning_rate}
  done
done
