#include "Stabilization.h"
#include <math.h>
#include <algorithm>

Stabilization::Stabilization(){
    _PIDOutputPsi = 0.0;
    _PIDOutputTheta = 0.0;
    _PIDOutputPhi = 0.0;
//    _filterTheta(100.f, 0.0f, 3.0f);
    _filterTheta.SetPidCoefficients(100, 0.0, 3);
}

QList<int> Stabilization::calculateStabilization(float psi, float theta, float phi) {
    QList<int> list;
    float anglePhi =  phi*(M_PI)/180;
    qWarning("anglePhi :  %f", anglePhi);
    uint8_t speedPsi = 0;
    uint8_t speedTheta = 0;

    _PIDOutputPsi = _filterPsi.CalculatePID(anglePhi);
    _PIDOutputTheta = _filterTheta.CalculatePID(theta);
    speedPsi = (uint8_t)std::min(100,abs(_PIDOutputPsi));
    speedTheta = (uint8_t)std::min(100,abs(_PIDOutputTheta));
    if( abs(psi) > M_PI/9)
    {
        //DriveSystem::spin(_PIDOutputPhi > 0 ? RIGHT : LEFT,speedPsi);
        if(_PIDOutputPsi > 0)
        {
            list.append(speedPsi); // RIGHT
            list.append(0);
        }
        else if(_PIDOutputPsi < 0)
        {
            list.append(speedPsi); // LEFT
            list.append(1);
        }
    }

    else if( abs(theta) > M_PI/9){
        //DriveSystem::go(_PIDOutputTheta > 0 ? FORWARD : BACKWARD, speedTheta);
        if(_PIDOutputTheta > 0)
        {
            list.append(speedTheta); // FORWARD
            list.append(2);
        }
        else if(_PIDOutputTheta < 0)
        {
            list.append(speedTheta); // BACKWARD
            list.append(3);
        }
    }

    return list;
}


/*QList<int> Stabilization::calculateStabilization(int psi, int theta, int phi) {
    QList<int> list;
    if (phi > 20) {
        list.append(50);
        list.append(0);
    }
    else if (phi < -20) {
        list.append(50);
        list.append(1);
    }
    else {
        list.append(0);
        list.append(2);
    }
    return list;
}*/
