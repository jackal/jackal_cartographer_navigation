-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "imu_link",
  published_frame = "odom",
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  use_odometry = true,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 1,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 0,
  lookup_transform_timeout_sec = 1.,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 0.5,
  fixed_frame_pose_sampling_ratio = 0.5,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true

TRAJECTORY_BUILDER_2D.min_range = 0.3
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 1.
TRAJECTORY_BUILDER_2D.use_imu_data = false
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.1
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 10.
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 10.
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 2e2
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 4e2

POSE_GRAPH.optimization_problem.huber_scale = 1e2

-----------------TUNE THESE PARAMETERS FOR LOW LATENCY-------------------------------

------------Global SLAM------------
POSE_GRAPH.optimize_every_n_nodes = 1 -- Decrease
MAP_BUILDER.num_background_threads = 4 -- Increase up to number of cores
POSE_GRAPH.global_sampling_ratio = 0.00001 -- Decrease
POSE_GRAPH.constraint_builder.sampling_ratio = 0.0001 -- Decrease
POSE_GRAPH.constraint_builder.min_score = 0.75 -- Increase
POSE_GRAPH.global_constraint_search_after_n_seconds = 20 -- Increase
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 5 -- Decrease

---------Global/Local SLAM---------
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.min_num_points = 100 -- Decrease
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_range = 10. -- Decrease
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_length = 1.0 -- Increase
TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.min_num_points = 50 -- Decrease
TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.max_range = 10. -- Decrease
TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.max_length = 1.8 -- Increase
TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.05 -- Increase
TRAJECTORY_BUILDER_2D.submaps.resolution=0.05 -- Increase
TRAJECTORY_BUILDER_2D.submaps.num_range_data = 1 -- Decrease
TRAJECTORY_BUILDER_2D.max_range = 10. -- Decrease

-------------------------------------------------------------------------------------

return options
