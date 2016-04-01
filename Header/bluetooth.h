#ifndef BLUETOOTH_H
#define BLUETOOTH_H


#include <qbluetoothglobal.h>
#include <qbluetoothlocaldevice.h>

QT_FORWARD_DECLARE_CLASS(QBluetoothDeviceDiscoveryAgent)
QT_FORWARD_DECLARE_CLASS(QBluetoothDeviceInfo)

class BluetoothDeviceDiscovery:
{
    Q_OBJECT

public:
    BluetoothDeviceDiscovery();
    ~BluetoothDeviceDiscovery();

public slots:
    void addDevice(const QBluetoothDeviceInfo&);

private slots:
    void startScan();
    void scanFinished();
    void hostModeStateChanged(QBluetoothLocalDevice::HostMode);

private:
    QBluetoothDeviceDiscoveryAgent *discoveryAgent;
    QBluetoothLocalDevice *localDevice;
    QList<QObject*>

};
#endif // BLUETOOTH_H
