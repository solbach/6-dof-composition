composition6DOF
===============

* IN PROGRESS (not completed yet, project clean up is really needed)
* Full 3D Frame Composition with six degrees of freedom
* Transformation Composition-Function using Quaternions
* Transformation Inversion-Function using Quaternions
* Jacobians
* Covariances
* A lot of Utilization-Function
	* relative motion from absolute motion 
 	* rosbag (visualodometry message) reader (really simple --> uses a pre-captured text file)
	* quaternion to rotation-matrix
	* invert quaternion
	* multiplication quaternion
* Simple Simulator
* Written in Matlab (should also work with Octave)
* More information can be taken from COMPOSITION.m

## Prerequisite
* OpenCV (>=2.4.0)
* mexopencv [1]

## Install
* add util subfolder to matlab paths
* run compMainUQ.m

## My Setup
* Ubuntu 12.04
* Matlab R2013a
* OpenCV 2.4.9
* MEXOpenCV

[1] https://github.com/kyamagu/mexopencv
