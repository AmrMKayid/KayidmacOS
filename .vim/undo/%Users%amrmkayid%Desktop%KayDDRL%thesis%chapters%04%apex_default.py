Vim�UnDo� �z��M`R4��::�ͶN?�H �/�(��   ~                                   ]Fu    _�                      2        ����                                                                                                                                                                                                                                                                                                                                                             ]Ft    �   }             )�   |   ~              },�   {   }                  "min_iter_time_s": 30,�   z   |          +        "worker_side_prioritization": True,�   y   {          '        "per_worker_exploration": True,�   x   z          )        "timesteps_per_iteration": 25000,�   w   y          -        "target_network_update_freq": 500000,�   v   x                   "sample_batch_size": 50,�   u   w                   "train_batch_size": 512,�   t   v          !        "learning_starts": 50000,�   s   u                  "buffer_size": 2000000,�   r   t                  "num_workers": 32,�   q   s                  "num_gpus": 1,�   p   r                  "n_step": 3,�   o   q                      }),�   n   p                          "debug": False�   m   o          .                "num_replay_buffer_shards": 4,�   l   n          -                "max_weight_sync_delay": 400,�   k   m          &            DQN_CONFIG["optimizer"], {�   j   l          !        "optimizer": merge_dicts(�   i   k              {�   h   j          K    DQN_CONFIG,  # see also the options in dqn.py, which are also supported�   1   3              },5��