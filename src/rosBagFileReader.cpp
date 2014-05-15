#include <iostream>
#include <eigen3/Eigen/Core>


namespace fileRead {

    void read(std::string file)
    {
        Eigen::Vector3d xAB, xBC, xAC;
        Eigen::Matrix3d J1, J2;

        // x, y, theta
        xAB << 4, 19, 20;
        xBC << 10, 10, 20;

        std::cout<< xAB << file <<std::endl;
    }

}
