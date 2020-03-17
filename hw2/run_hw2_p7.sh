for learning_rate in .005 .01 .02
do
  for batch_size in 10000 30000 50000
  do
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo LearningRate: ${learning_rate} -- BatchSize: ${batch_size}
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    python cs285/scripts/run_hw2_policy_gradient.py --env_name HalfCheetah-v2 --ep_len 150 --discount 0.95 -n 100 -l 2 -s 32 -b ${batch_size} -lr ${learning_rate} --video_log_freq -1 --reward_to_go --nn_baseline --video_log_freq 10 --exp_name p7_hc_b${batch_size}_lr${learning_rate}_nnbaseline
  done
done
