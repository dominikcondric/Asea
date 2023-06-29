#pragma once
#include "Coa/ECS/Components/TagComponent.h"
#include <QQuickItem>

class TagComponentWrapper {
    Q_GADGET
    Q_PROPERTY(QString name READ name WRITE setName)

public:
    TagComponentWrapper() = default; 
    TagComponentWrapper(Coa::TagComponent* tagComponent) : m_tagComponent(tagComponent) {}
    ~TagComponentWrapper() = default; 
    void setName(const QString& name) 
    {
        m_tagComponent->name = name.toStdString();
    }

    QString name() const
    {
        return QString::fromStdString(m_tagComponent->name);
    }

private:
    Coa::TagComponent* m_tagComponent = nullptr;
};