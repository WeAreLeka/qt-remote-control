 #ifndef DATA_H
#define DATA_H

#include <array>
#include <QtSerialPort/QSerialPort>
#include <QDebug>
#include <iostream>

#define ACC "1"
#define GYRO "2"

/*
 * This class keeps track of the physical measures sent by the Arduino Card to the Qt Application
 * The first 3 values correspond to the values of the accelerations along the X, Y and Z axes
 * The next 3 ones correspond to the values of the angular accelerations
*/

class Data
{
private:
    std::array<double, 6> dataAsDoubles;

public:
    Data();

    std::array<double, 6> getDataAsDoubles(void) const { return dataAsDoubles; }
    double getX(void) const{return dataAsDoubles[0];}
    double getY(void) const{return dataAsDoubles[1];}
    double getZ(void) const{return dataAsDoubles[2];}

    double getA1(void) const{return dataAsDoubles[3];}
    double getA2(void) const{return dataAsDoubles[4];}
    double getA3(void) const{return dataAsDoubles[5];}
    void setDataAsDoubles(const std::array<double, 6> newDataAsDoubles) { dataAsDoubles = newDataAsDoubles; }

public:
    void parser(const QString dataAsString);
    void displayData(void) const;
};

#endif // DATA_H
