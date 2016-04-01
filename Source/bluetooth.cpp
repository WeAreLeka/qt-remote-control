#include "Header/bluetooth.h"

#include <qbluetoothaddress.h>
#include <qbluetoothdevicediscoveryagent.h>
#include <qbluetoothlocaldevice.h>
#include <QMenu>
#include <QDebug>

BluetoothDeviceDiscovery::BluetoothDeviceDiscovery(){

  discoveryAgent = new QBluetoothDeviceDiscoveryAgent();

  connect(discoveryAgent, SIGNAL(deviceDiscovered(QBluetoothDeviceInfo)),this,SLOT(addDevice(QBluetoothDeviceInfo)));
  connect(discoveryAgent, SIGNAL(finished()),this,SLOT(scanFinished()));

  connect(localDevice, SIGNAL(hostModeStateChanged(QBluetoothLocalDevice::HostMode)),
          this, SLOT(hostModeStateChanged(QBluetoothLocalDevice::HostMode)));

  hostModeStateChanged(localDevice->hostMode());
}

BluetoothDeviceDiscovery::~BluetoothDeviceDiscovery()
{
    delete discoveryAgent;
}

void BluetoothDeviceDiscovery::startScan()
{
    discoveryAgent->start();
}

void BluetoothDeviceDiscovery::scanFinished()
{

}

void BluetoothDeviceDiscovery::addDevice(const QBluetoothDeviceInfo &info)
{
    QString label = QString("%1 %2").arg(info.address().toString()).arg(info.name());
    QList<QListWidgetItem *> items = ui->list->findItems(label, Qt::MatchExactly);
    if (items.empty()) {
        QListWidgetItem *item = new QListWidgetItem(label);
        QBluetoothLocalDevice::Pairing pairingStatus = localDevice->pairingStatus(info.address());
        if (pairingStatus == QBluetoothLocalDevice::Paired || pairingStatus == QBluetoothLocalDevice::AuthorizedPaired )
            item->setTextColor(QColor(Qt::green));
        else
            item->setTextColor(QColor(Qt::black));

        ui->list->addItem(item);
    }

}
