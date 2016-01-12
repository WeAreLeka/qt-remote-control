#ifndef STABILIZATION_H
#define STABILIZATION_H
#include "Filters.h"
#include <QObject>
#include <algorithm>



class Stabilization: public QObject
{
    Q_OBJECT

public:
    Stabilization(void);
//    ~Stabilization(void);
    Q_INVOKABLE QList<int> calculateStabilization(float psi, float theta, float phi);
private:
    PID _filterPsi;
    PID _filterTheta;
    PID _filterPhi;

    float _PIDOutputPsi;
    float _PIDOutputTheta;
    float _PIDOutputPhi;
};

#endif // STABILIZATION_H
