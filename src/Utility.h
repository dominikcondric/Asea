#pragma once
#include <QQmlEngine>
#include <future>

class Utility : public QObject {
    Q_OBJECT
    QML_NAMED_ELEMENT(Utility)
    QML_SINGLETON

public:
    Utility() = default;
    ~Utility() = default;
    Q_INVOKABLE void generateScript(const QString &directoryPath, const QString& className);
    Q_INVOKABLE void createNewProject(const QString &directoryPath, const QString &projectName);
};