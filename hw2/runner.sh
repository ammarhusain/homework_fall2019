#!/bin/bash

# Script to run HW2 experiments.

# Copy the user args
ARGS=$@
# If none specified run all experiments.
if [[ -z $ARGS ]]; then
  ARGS="P3 P4 P6 P7"
fi

for P_i in $ARGS
do
  if [[ $P_i == "P3" ]]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "Running P3 experiments"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name CartPole-v0 -n 100 -b 1000 -dsa --exp_name p3_sb_no_rtg_dsa
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name CartPole-v0 -n 100 -b 1000 -rtg -dsa --exp_name p3_sb_rtg_dsa
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name CartPole-v0 -n 100 -b 1000 -rtg --exp_name p3_sb_rtg_na
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name CartPole-v0 -n 100 -b 5000 -dsa --exp_name p3_lb_no_rtg_dsa
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name CartPole-v0 -n 100 -b 5000 -rtg -dsa --exp_name p3_lb_rtg_dsa
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name CartPole-v0 -n 100 -b 5000 -rtg --exp_name p3_lb_rtg_na
  elif [[ $P_i == "P4" ]]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "Running P4 experiments"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    for learning_rate in 0.0005 .005 .01 .02 0.1
    do
      for batch_size in 500 1000 5000 10000
      do
        echo "@@@@@@@@@@"
        echo LearningRate: ${learning_rate} -- BatchSize: ${batch_size}
        echo "@@@@@@@@@@"
        python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name InvertedPendulum-v2 --ep_len 1000 --discount 0.9 -n 100 -l 2 -s 64 -b ${batch_size} -lr ${learning_rate} -rtg --exp_name p4_ip_b${batch_size}_r${learning_rate}
      done
    done
  elif [[ $P_i == "P6" ]]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "Running P6 experiments"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name LunarLanderContinuous-v2 --ep_len 1000 --discount 0.99 -n 100 -l 2 -s 64 -b 40000 -lr 0.005 -rtg --nn_baseline --exp_name p6_ll_b40000_r0.005
  elif [[ $P_i == "P7" ]]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "Running P7 experiments"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    for learning_rate in .005 .01 .02
    do
      for batch_size in 10000 30000 50000
      do
        echo "@@@@@@@@@@"
        echo LearningRate: ${learning_rate} -- BatchSize: ${batch_size}
        echo "@@@@@@@@@@"
        python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name HalfCheetah-v2 --ep_len 150 --discount 0.95 -n 100 -l 2 -s 32 -b ${batch_size} -lr ${learning_rate} --video_log_freq -1 --reward_to_go --nn_baseline --video_log_freq 10 --exp_name p7_hc_b${batch_size}_lr${learning_rate}_nnbaseline
      done
    done
  elif [[ $P_i == "P7D" ]]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "Running P7 Deliverables experiments"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1  --env_name HalfCheetah-v2 --ep_len 150 --discount 0.95 -n 100 -l 2 -s 32 -b 50000 -lr 0.02 --exp_name hc_b50000_r0.02
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name HalfCheetah-v2 --ep_len 150 --discount 0.95 -n 100 -l 2 -s 32 -b 50000 -lr 0.02 -rtg --exp_name hc_b50000_r0.02
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name HalfCheetah-v2 --ep_len 150 --discount 0.95 -n 100 -l 2 -s 32 -b 50000 -lr 0.02 --nn_baseline --exp_name hc_b50000_r0.02
    python cs285/scripts/run_hw2_policy_gradient.py --use_gpu --which_gpu 1 --env_name HalfCheetah-v2 --ep_len 150 --discount 0.95 -n 100 -l 2 -s 32 -b 50000 -lr 0.02 -rtg --nn_baseline --exp_name hc_b50000_r0.02
  else
    echo "Invalid experiment.... Skipping"
  fi
done

## Have the final P7 experiment to run after determining b* & r*

echo "User args: " $@
