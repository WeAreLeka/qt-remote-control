#include "Header/data.h"

Data::Data()
{
    for(int i = 0; i < 6; i++)
        dataAsDoubles[i] = 0;
}


/*
 * To parse the values received from the arduino card
 * Parameter : QString received through a serial connection
*/

void Data::parser(const QString dataAsString){

    // regular expression to parse the data
    QRegExp rx("[ ]");

    // splits the QString data into a QStringList (each measure corresponds to one QString)
    QStringList list = dataAsString.split(rx, QString::SkipEmptyParts);
    size_t count(0);

    // Here we cast the measures we parsed to double in order to do some calculations with them later on
    if(!list.last().compare("A")){
        for(QStringList::ConstIterator it = list.constBegin(); it != list.constEnd() - 1; ++it){
            dataAsDoubles[count++] = (*it).toDouble();
        }
    } else
        qDebug() << "Unparsable data encountered";
}

/*
 * To display our data
*/

void Data::displayData(void) const{
    for(int i = 0; i < 6; i++)
        std::cout << dataAsDoubles[i] << "\t";

    std::cout << std::endl;
}

