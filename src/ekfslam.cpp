/**
* @file ekfslam.cpp
* @author Markus Solbach <mksolb@gmail.com>
* @version 1.0
*
* @section LICENSE
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation; either version 2 of
* the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful, but
* WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
* General Public License for more details at
* http://www.gnu.org/copyleft/gpl.html
*
* @section DESCRIPTION
*
* CMake Framework
*
* @section TODO
* - Everything
*/

#include <iostream>
#include <eigen3/Eigen/Core>

int main( int argc, const char* argv[] )
{

    std::cout << "Hallo Welt" << std::endl;


    Eigen::Vector3d xAB, xBC, xAC;
    Eigen::Matrix3d J1, J2;

    // x, y, theta
    xAB << 4, 19, 20;
    xBC << 10, 10, 20;

    std::cout<< xAB <<std::endl;


    return 0;
}
