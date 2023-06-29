#pragma once
#include <QQmlEngine>
#include "Coa/ECS/Components/ScriptComponent.h"
#include "Coa/Utility/SharedLibrary.h"

class ScriptComponentWrapper {
    Q_GADGET
    Q_PROPERTY(QString sharedLibraryPath READ sharedLibraryPath)
    Q_PROPERTY(QString className READ className)

public:
    ScriptComponentWrapper() = default;
    ScriptComponentWrapper(Coa::ScriptComponent* scriptComponent) : m_scriptComponent(scriptComponent) {}
    ~ScriptComponentWrapper() = default;
    QString sharedLibraryPath() const { return QString::fromStdString(m_scriptComponent->getSharedLibrary().getPath()); }
    QString className() const { return QString::fromStdString(m_scriptComponent->getClassName()); }

    Q_INVOKABLE bool loadScript(const QString& libraryPath, const QString& className)
    {
        Coa::SharedLibrary library(libraryPath.toStdString());
        if (!library.loadFunction<Coa::ScriptComponent::Script>("load" + className.toStdString()))
        {
            qDebug() << "Class name does not exist in shared library!";
            return false; 
        }

        m_scriptComponent->loadScript(Coa::SharedLibrary(libraryPath.toStdString()), className.toStdString());
        return true;
    }

private:
    Coa::ScriptComponent* m_scriptComponent;
};