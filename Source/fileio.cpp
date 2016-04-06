#include "Header/fileio.h"
#include <QFile>
#include <QTextStream>

FileIO::FileIO()
{

}

void FileIO::save(QString source, QString text){

    QFile file(source);
/*    if(file.open(QIODevice::ReadWrite)){
        QTextStream stream(&file);
        stream << text << endl;
    }*/
    if(!file.open(QFile::Append | QFile::Text)){
            return;
        }
    QTextStream out(&file);
        out << text << "\n";

        file.close();

    return;
}

FileIO::~FileIO()
{

}

